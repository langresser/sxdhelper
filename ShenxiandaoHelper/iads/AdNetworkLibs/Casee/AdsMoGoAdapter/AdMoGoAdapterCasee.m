//
//  File: AdMoGoAdapterCasee.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterCasee.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h" 

@implementation AdMoGoAdapterCasee

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeCasee;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    timer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];

    AdViewType type = adMoGoView.adType;
    CaseeAdSizeIdentifier size;
    switch (type) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            size = caseeAdSizeIdentifier_320x48;
            break;
        case AdViewTypeRectangle:
            size = caseeAdSizeIdentifier_300x250;
            break;
        case AdViewTypeMediumBanner:
            size = caseeAdSizeIdentifier_364x60;
            break;
        case AdViewTypeLargeBanner:
            size = caseeAdSizeIdentifier_728x90;
            break;
        default:
            break;
    }

    caseeView = [[CaseeAdView adViewWithDelegate:self caseeRectStyle:size] retain];
    self.adNetworkView = caseeView;
}

- (void)stopBeingDelegate {
    
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
    if (caseeView) {
        [caseeView release];
        caseeView = nil;
    }
	[super dealloc];
}

#pragma mark CaseeAdDelegate required methods
- (NSString *)appId {
	return networkConfig.pubId;
}
#pragma mark CaseeAdDelegate optional methods
- (CLLocation *)location {
	if ([adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return [adMoGoDelegate locationInfo];
	}
	return nil;
}
// Other information may send with an ad request

// current context related keywords, such as @"sichuan food"
- (NSString *)keywords {
	if ([adMoGoDelegate respondsToSelector:@selector(keywords)]) {
		return [adMoGoDelegate keywords];
	}
	return nil;
}	   

- (void)didReceiveAdIn:(CaseeAdView *)adView {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"casee"];
    [adMoGoView adapter:self didReceiveAdView:adView];
}

- (void)adView:(CaseeAdView *)adView failedWithError:(NSError *)error {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"casee"];
    [adMoGoView adapter:self didFailAd:error];
}

- (void)willShowFullScreenAd {
	[self helperNotifyDelegateOfFullScreenModal];
}

- (void)didCloseFullScreenAd {
	[self helperNotifyDelegateOfFullScreenModalDismissal];
}

- (BOOL)isTestMode {
    if (networkConfig.testMode) {
        return YES;
    }
    return NO;
}

- (NSTimeInterval)adInterval {
	return 0;
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didGetAd:@"casee"];
    [adMoGoView adapter:self didFailAd:nil];
}

- (BOOL)allowShareLocation {
    return NO;
}
@end