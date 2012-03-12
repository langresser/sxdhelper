//
//  AdMoGoAdapterUM.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.4
//  Created by pengxu on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdMoGoAdapterUM.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkConfig.h"

#define kAdMoGoUMClientID @"ClientID"
#define kAdMoGoUMSlotID @"SlotID"

@implementation AdMoGoAdapterUM

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeUM;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}
- (void)getAd {
    
    [adMoGoView adapter:self didGetAd:@"um"];
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];

    CGSize size = [UMAdBannerView sizeOfBannerContentSize];
    
    [UMAdManager setAppDelegate:self];
    [UMAdManager appLaunched];
    
    UMAdBannerView *adView = [[UMAdBannerView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    adView.frame = CGRectMake(0, 0, 320, 50);

    [adView setProperty:[adMoGoDelegate viewControllerForPresentingModalView] slotid:[networkConfig.credentials objectForKey:kAdMoGoUMSlotID]];
    
    [adView setDelegate:self];
    
    self.adNetworkView = adView;
    
    [adView release];
}

-(NSString *)UMADClientId{
    return [networkConfig.credentials objectForKey:kAdMoGoUMClientID];
}

- (void)UMADBannerViewDidLoadAd:(UMAdBannerView *)banner {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didReceiveAdView:banner];
}
- (void)UMADBannerView:(UMAdBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didFailAd:error];
}

- (void) dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)stopBeingDelegate {

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
