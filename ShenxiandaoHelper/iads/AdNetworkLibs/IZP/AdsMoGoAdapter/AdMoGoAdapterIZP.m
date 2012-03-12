//
//  File: AdMoGoAdapterAdwo.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterIZP.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h" 

@implementation AdMoGoAdapterIZP
static BOOL isFirst = YES;
static IZPView *adView = nil;

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeIZP;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd{
    AdViewType type = adMoGoView.adType;
    Model model;
    if (networkConfig.testMode) {
        model = MODEL_TEST;
    }
    else {
        model = MODEL_RELEASE;
    }
    if (isFirst) {
        [IZPView setPID:networkConfig.pubId adType:AD_TYPE_BANNER model:model];
        isFirst = NO;
    }
    if (type == AdViewTypeNormalBanner) {
        if (adView == nil) {
            adView = [[IZPView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        }
    }
    else if (type == AdViewTypeLargeBanner) {
        if (adView == nil) {
            adView = [[IZPView alloc] initWithFrame:CGRectMake(0, 0, 728, 90)];
        }
    }
    [adView start];
    [adView setDelegate:self];
    self.adNetworkView = adView;

    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
}

- (void)stopBeingDelegate {
    IZPView *adView = (IZPView *)self.adNetworkView;
    [adView pause];
    if(adView != nil)
    {
        [adView setDelegate:nil];
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

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didGetAd:@"izp"];
    [adMoGoView adapter:self didFailAd:nil];
}

- (void)didReceiveFreshAd:(IZPView*)view adCount:(NSInteger)count {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"izp"];
    [adMoGoView adapter:self didReceiveAdView:view];
}
 
- (void)didStopFullScreenAd:(IZPView*)view {
 
}

- (void)willLeaveApplication:(IZPView*)adView {

}

-(BOOL)shouldRequestFreshAd:(IZPView*)view {
    return YES;
}
-(BOOL)shouldShowFreshAd:(IZPView*)view {
    return YES;
}

-(void)didShowFreshAd:(IZPView*)view {

}


- (void) errorReport:(NSInteger)code erroInfo:(NSString*) info {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    IZPView *adView = (IZPView *)self.adNetworkView;
    [adView pause];
    [adMoGoView adapter:self didGetAd:@"izp"];
    [adMoGoView adapter:self didFailAd:nil];
}

@end