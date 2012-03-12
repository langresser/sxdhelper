//
//  File: AdMoGoAdapterInMobi.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterInMobi.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "IMAdView.h"
#import "IMAdRequest.h"
#import "IMAdInterstitial.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

@implementation AdMoGoAdapterInMobi

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeInMobi;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"inmobi"];

    AdViewType type = adMoGoView.adType;
    CGSize size = CGSizeZero;
    NSUInteger unitIndex = 0;
    switch (type) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            size = CGSizeMake(320, 50);
            unitIndex = IM_UNIT_320x50;
            break;
        case AdViewTypeRectangle:
            size = CGSizeMake(300, 250);
            unitIndex = IM_UNIT_300x250;
            break;
        case AdViewTypeMediumBanner:
            size = CGSizeMake(468, 60);
            unitIndex = IM_UNIT_468x60;
            break;
        case AdViewTypeLargeBanner:
            size = CGSizeMake(728, 90);
            unitIndex = IM_UNIT_728x90;
            break;
        default:
            break;
    }

    if (type == AdViewTypeFullScreen) {
        IMAdInterstitial *interstitialAd = [[IMAdInterstitial alloc] init];
        interstitialAd.delegate = self;
        interstitialAd.imAppId = networkConfig.pubId;
        IMAdRequest *request = [IMAdRequest request];
        request.testMode = networkConfig.testMode;
        [interstitialAd loadRequest:request];
        return;
    }
    
    IMAdView *inmobiAdView = [[IMAdView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) imAppId:networkConfig.pubId imAdUnit:unitIndex rootViewController:[adMoGoDelegate viewControllerForPresentingModalView]];
    inmobiAdView.delegate = self;
    inmobiAdView.refreshInterval = REFRESH_INTERVAL_OFF;
    IMAdRequest *request = [IMAdRequest request];
    request.testMode = networkConfig.testMode;
    if ([adMoGoDelegate respondsToSelector:@selector(postalCode)]) {
        request.postalCode = [adMoGoDelegate postalCode];
	}
    
    if (![adMoGoDelegate respondsToSelector:@selector(gender)]) {
        request.gender = G_None;
	}
    else {
        NSString *genderStr = [adMoGoDelegate gender];
        if ([genderStr isEqualToString:@"f"]) {
            request.gender = G_F;
        }
        if ([genderStr isEqualToString:@"m"]) {
            request.gender = G_M;
        }
    }

    inmobiAdView.imAdRequest = request;
	self.adNetworkView = inmobiAdView;
    [inmobiAdView loadIMAdRequest];
    [inmobiAdView release];
}

- (void)stopBeingDelegate {
    IMAdView *inmobiAdView = (IMAdView *)self.adNetworkView;
	if (inmobiAdView != nil) {
		inmobiAdView.delegate = nil;
	}
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark InMobiAdDelegate methods
- (void)adViewDidFinishRequest:(IMAdView *)adView {
    [adMoGoView adapter:self didReceiveAdView:adView];
}

- (void)adView:(IMAdView *)view didFailRequestWithError:(IMAdError *)error {
    NSLog(@"%@",[error localizedDescription]);
    [adMoGoView adapter:self didFailAd:nil];
}

- (void)adViewWillPresentScreen:(IMAdView *)adView {
    [self helperNotifyDelegateOfFullScreenModal];
}

- (void)adViewDidDismissScreen:(IMAdView *)adView {
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

#pragma mark -
#pragma mark IMAdInterstitialDelegate
- (void)interstitialDidFinishRequest:(IMAdInterstitial *)ad {
    [ad presentFromRootViewController:[adMoGoDelegate viewControllerForPresentingModalView]];
}

- (void)interstitial:(IMAdInterstitial *)ad didFailToReceiveAdWithError:(IMAdError *)error {
    [adMoGoView adapter:self didFailAd:nil];
}

- (void)interstitialWillPresentScreen:(IMAdInterstitial *)ad {
    [adMoGoView adapter:self didReceiveAdView:nil];
    [self helperNotifyDelegateOfFullScreenAdModal];
}

- (void)interstitialDidDismissScreen:(IMAdInterstitial *)ad {
    [self helperNotifyDelegateOfFullScreenAdModalDismissal];
}

@end