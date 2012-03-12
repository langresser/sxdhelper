//
//  File: AdMoGoAdapterGreystripe.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterGreystripe.h"

#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "GSAdView.h"
#import "GSAdEngine.h"

// constants
NSString * const kGSBannerSlotName = @"gsBanner";
NSString * const kGSFullScreenSlotName = @"gsFullScreen";
NSString * const kGSIPadMediumRectangle = @"gsiPadMediumRectangle";
NSString * const kGSIPadLeaderboard = @"gsiPadLeaderboard";

// static globals
static BOOL g_didStartUpGreystripe;

@interface AdMoGoAdapterGreystripe ()
- (void)bannerAdReady;
@end

@implementation AdMoGoAdapterGreystripe

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeGreyStripe;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (id)initWithAdMoGoDelegate:(id<AdMoGoDelegate>)delegate
						view:(AdMoGoView *)view
					  config:(AdMoGoConfig *)config
			   networkConfig:(AdMoGoAdNetworkConfig *)netConf {
	if((self = [super initWithAdMoGoDelegate:delegate view:view config:config networkConfig:netConf])) {
		if(!g_didStartUpGreystripe) {
			@try {
				GSAdSlotDescription * bannerSlot = [GSAdSlotDescription descriptionWithSize:kGSAdSizeBanner name:kGSBannerSlotName];
                
				GSAdSlotDescription * iPadMediumRectangleSlot = [GSAdSlotDescription descriptionWithSize:kGSAdSizeIPadMediumRectangle name:kGSIPadMediumRectangle];
                
                GSAdSlotDescription * iPadLeaderboardSlot = [GSAdSlotDescription descriptionWithSize:kGSAdSizeIPadLeaderboard name:kGSIPadLeaderboard];
                
                if (adMoGoView.adType == AdViewTypeFullScreen) {
                    GSAdSlotDescription *fullScreenSlot = [GSAdSlotDescription descriptionWithSize:kGSAdSizeIPhoneFullScreen name:kGSFullScreenSlotName];
                    [GSAdEngine startupWithAppID:netConf.pubId 
                              adSlotDescriptions:[NSArray arrayWithObjects:bannerSlot,iPadMediumRectangleSlot,iPadLeaderboardSlot,fullScreenSlot,nil]];
                }
                else {
                    [GSAdEngine startupWithAppID:netConf.pubId 
                              adSlotDescriptions:[NSArray arrayWithObjects:bannerSlot,iPadMediumRectangleSlot,iPadLeaderboardSlot,nil]];
                }
				g_didStartUpGreystripe = YES;
			}
			@catch (NSException *e) {
				if([e.name isEqualToString:NSInternalInconsistencyException]){
					g_didStartUpGreystripe = YES;
				}
				else {
					@throw e;
				}
			}
		}
	}
	return self;
}

- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"greystripe"];
    
    NSString *name = nil;
    AdViewType type = adMoGoView.adType;
    switch (type) {
        case AdViewTypeNormalBanner:
            name = kGSBannerSlotName;
            break;
        case AdViewTypeRectangle:
            name = kGSIPadMediumRectangle;
            break;
        case AdViewTypeMediumBanner:
            break;
        case AdViewTypeLargeBanner:
            name = kGSIPadLeaderboard;
            break;
        case AdViewTypeFullScreen:
            name = kGSFullScreenSlotName;
            break;
        default:
            break;
    }
    if (name == nil) {
        [adMoGoView adapter:self didFailAd:nil];
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    if (type == AdViewTypeFullScreen) {
        [GSAdEngine setFullScreenDelegate:self forSlotNamed:kGSFullScreenSlotName];
    }
    else {
        GSAdView *gsAdView = [GSAdView adViewForSlotNamed:name delegate:self];
        self.adNetworkView = gsAdView;
     }
}

- (void)stopBeingDelegate {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    
    NSString *name = nil;
    AdViewType type = adMoGoView.adType;
    switch (type) {
        case AdViewTypeNormalBanner:
            name = kGSBannerSlotName;
            break;
        case AdViewTypeRectangle:
            name = kGSIPadMediumRectangle;
            break;
        case AdViewTypeMediumBanner:
            //No ad error
            break;
        case AdViewTypeLargeBanner:
            name = kGSIPadLeaderboard;
            break;
        case AdViewTypeFullScreen:
            [GSAdEngine setFullScreenDelegate:nil forSlotNamed:kGSFullScreenSlotName];
            return;
        default:
            break;
    }
    if (name) {
        [GSAdView adViewForSlotNamed:name delegate:nil];
    }
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
	[super dealloc];
}

#pragma mark -
#pragma mark GreystripeDelegate notification methods
- (void)greystripeAdReadyForSlotNamed:(NSString *)a_name {
    if ([a_name isEqual:kGSFullScreenSlotName]) {
        if (timer) {
            [timer invalidate];
            [timer release];
            timer = nil;
        }
        [GSAdEngine displayFullScreenAdForSlotNamed:kGSFullScreenSlotName];
        [adMoGoView adapter:self didReceiveAdView:nil];
        return;
	}
    
    NSString *name = nil;
    AdViewType type = adMoGoView.adType;
    switch (type) {
        case AdViewTypeNormalBanner:
            name = kGSBannerSlotName;
            break;
        case AdViewTypeRectangle:
            name = kGSIPadMediumRectangle;
            break;
        case AdViewTypeMediumBanner:
            break;
        case AdViewTypeLargeBanner:
            name = kGSIPadLeaderboard;
            break;
        default:
            break;
    }
    
	if ([a_name isEqualToString:name]) {
		[self bannerAdReady];
	}
}

- (void)greystripeFullScreenDisplayWillOpen {
    if (adMoGoView.adType == AdViewTypeFullScreen) {
        [self helperNotifyDelegateOfFullScreenAdModal];
    }
    else {
        [self helperNotifyDelegateOfFullScreenModal];
    }
}

- (void)greystripeFullScreenDisplayWillClose {
    if (adMoGoView.adType == AdViewTypeFullScreen) {
        [GSAdEngine setFullScreenDelegate:nil forSlotNamed:kGSFullScreenSlotName];
        [self helperNotifyDelegateOfFullScreenAdModalDismissal];
    }
    else {
        [self helperNotifyDelegateOfFullScreenModalDismissal];
    }
}
#pragma mark -
#pragma mark Internal methods
- (void)bannerAdReady {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }	
    [adMoGoView adapter:self didReceiveAdView:self.adNetworkView];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didFailAd:nil];
}
@end