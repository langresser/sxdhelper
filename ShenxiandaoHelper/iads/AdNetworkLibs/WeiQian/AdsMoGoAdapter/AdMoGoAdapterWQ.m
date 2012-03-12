//
//  AdMoGoAdapterWQ.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.4
//  Created by pengxu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdMoGoAdapterWQ.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "WQAdView.h"
#import "WQAdSDK.h"
#import "AdMoGoAdNetworkConfig.h"

#define kAdMoGoWQAppID @"AppID"
#define kAdMoGoWQPublisherID @"PublisherID"

@implementation AdMoGoAdapterWQ

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeWQ;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}
- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"wq"];
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
     
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];

    [WQAdSDK init:[networkConfig.credentials objectForKey:kAdMoGoWQAppID] withPubID:[networkConfig.credentials objectForKey:kAdMoGoWQPublisherID] withRefreshRate:600 isTestMode:NO];
    
    WQAdView *adView = [WQAdView requestAdOfRect:CGRectMake(0, 0, 320, 48) withDelegate:self];

    [view addSubview:adView];
    self.adNetworkView = view;
    [adView startRequestAd];
    [adView release];
}

-(void) didReceivedAd:(WQAdView*) adView {

        if (timer) {
            [timer invalidate];
            [timer release];
            timer = nil;
        }
        [adMoGoView adapter:self didReceiveAdView:adNetworkView];

   
}

-(void) didFailToReceiveAd:(WQAdView*) adView {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didFailAd:nil];
}
    
- (void) dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [super dealloc];
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
