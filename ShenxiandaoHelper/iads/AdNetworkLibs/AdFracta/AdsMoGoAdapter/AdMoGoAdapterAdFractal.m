//
//  File: AdMoGoAdapterAdFractal.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterAdFractal.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

@implementation AdMoGoAdapterAdFractal

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeAdFractal;
}

- (void)getAd {
    @try {
        AdViewType type = adMoGoView.adType;
        CGSize size =CGSizeMake(0, 0);
        switch (type) {
            case AdViewTypeNormalBanner:
            case AdViewTypeiPadNormalBanner:
                size = CGSizeMake(320, 50);
                break;
            case AdViewTypeRectangle:
                size = CGSizeMake(320, 270);
                break;
            case AdViewTypeMediumBanner:
                size = CGSizeMake(488, 88);
                break;
            case AdViewTypeLargeBanner:
                size = CGSizeMake(748, 110);
                break;
            default:
                break;
        }
        
        AdFractaView *adFractaView = [AdFractaView photoAdWithFrame:CGRectMake(0, 0, size.width, size.height) delegate:self adType:MCAD_RECTANGLE];
        adFractaView.animtionType_ = ADAnimationNone;
        adFractaView.isLocation = NO;
        adFractaView.adOpenType_ = ADOpenInViewController;
        adFractaView.rootViewController_ = [adMoGoDelegate viewControllerForPresentingModalView];
        [adFractaView startRequest];
        
        self.adNetworkView = adFractaView;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

- (void)stopBeingDelegate {
    if (self.adNetworkView) {
        AdFractaView *adView = (AdFractaView *)adNetworkView;
        adView.delegate_ = nil;
        adView.rootViewController_ = nil;
    }
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)publisherid {
    return networkConfig.pubId;
}

- (CGSize)adSize {
    AdViewType type = adMoGoView.adType;
    switch (type) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            return AD_SIZE_320x48;
            break;
        case AdViewTypeRectangle:
            return AD_SIZE_320x270;
            break;
        case AdViewTypeMediumBanner:
            return AD_SIZE_488x80;
            break;
        case AdViewTypeLargeBanner:
            return AD_SIZE_748x110;
            break;
        default:
            break;
    }
    return AD_SIZE_320x48;
}
- (int)refreshTime {
    return 600;
}
- (void)didFailToReceiveAd:(AdFractaView *)adView {
    [adMoGoView adapter:self didGetAd:@"adfractal"];
    [adMoGoView adapter:self didFailAd:nil];
}
- (void)didReceiveAd:(AdFractaView *)adView {
    @try {
        if ([NSThread isMainThread]) {
            [adMoGoView adapter:self didGetAd:@"adfractal"];
            [adMoGoView adapter:self didReceiveAdView:adNetworkView];
        }
        else {
            [self performSelectorOnMainThread:@selector(showAd:)
                                   withObject:nil
                                waitUntilDone:NO];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

- (BOOL) shouldCloseAdFractaView:(AdFractaView *)adView {
    return YES;
}

- (void) willAdViewClosed:(AdFractaView *)adView {

}

- (void)showAd:(id)sender {
    @try {
        [adMoGoView adapter:self didGetAd:@"adfractal"];
        [adMoGoView adapter:self didReceiveAdView:adNetworkView];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}
@end