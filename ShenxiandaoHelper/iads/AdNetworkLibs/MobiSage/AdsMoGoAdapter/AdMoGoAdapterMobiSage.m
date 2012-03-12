//
//  File: AdMoGoAdapterMobiSage.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterMobiSage.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"

@implementation AdMoGoAdapterMobiSage
+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeMobiSage;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
	[adMoGoView adapter:self didGetAd:@"mobisage"];

    AdViewType type = adMoGoView.adType;
    CGSize size =CGSizeMake(0, 0);
    NSUInteger adIndex = 0;
    switch (type) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            adIndex = Ad_320X40;
            size = CGSizeMake(320, 40);
            break;
        case AdViewTypeRectangle:
            adIndex = Ad_320X270;
            size = CGSizeMake(320, 270);
            break;
        case AdViewTypeMediumBanner:
            adIndex = Ad_480X40;
            size = CGSizeMake(480, 40);
            break;
        case AdViewTypeLargeBanner:
            adIndex = Ad_748X110;
            size = CGSizeMake(748, 110);
            break;
        default:
            break;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    MobiSageManager *adViewManager = [MobiSageManager getInstance];
    [adViewManager setPublisherID:networkConfig.pubId];
    MobiSageAdView *adView = [adViewManager createMobiSageAdView:adIndex];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [view addSubview:adView];
    self.adNetworkView = view;
    [view release];
    [adView release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adStartShow:) 
                                                 name:MobiSageAdView_Start_Show_AD 
                                               object:adView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adPauseShow:) 
                                                 name:MobiSageAdView_Pause_Show_AD
                                               object:adView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adPop:) 
                                                 name:MobiSageAdView_Pop_AD_Window
                                               object:adView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adHide:) 
                                                 name:MobiSageAdView_Hide_AD_Window
                                               object:adView];
}

- (void)stopBeingDelegate {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)dealloc {
	[super dealloc];
}

- (void)adStartShow:(id)sender {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didReceiveAdView:self.adNetworkView];
}

- (void)adPauseShow:(id)sender {
    
}

- (void)adPop:(id)sender {
    [self helperNotifyDelegateOfFullScreenModal];
}

- (void)adHide:(id)sender {
    [self helperNotifyDelegateOfFullScreenModalDismissal];
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
