//
//  File: AdMoGoAdapterAirAd.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterAirAd.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h" 

@implementation AdMoGoAdapterAirAd

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeAirAd;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd{
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    if (adMoGoView.adType == AdViewTypeNormalBanner) {
        airADView * adView = [[airADView alloc] init];
        [adView setAppIdentifier:networkConfig.pubId];
        [adView setDelegate:self];
        
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
        [myView addSubview:adView];
        
        self.adNetworkView = myView;
        [myView release];
        [adView release];
    }
	
}

- (void)stopBeingDelegate {
    NSArray *array = [self.adNetworkView subviews];
    if (array && array.count > 0) {
        airADView *adView = (airADView *)[[self.adNetworkView subviews] objectAtIndex:0];
        if (adView) {
            adView.delegate = nil;
            [adView removeFromSuperview];
        }
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

#pragma mark airAD Connection

//当遇到以下情况,会发送此请求:
//1.IP地址非法.在一些无法访问airAD广告的地区,会返回此信息.
//2.网络无相应.
//3.传输参数非法,比如,非正确的App_ID.
- (void)airADConnectFailed:(NSError*)error {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"airad"];
    [adMoGoView adapter:self didFailAd:error];
}

#pragma mark Ad Request Lifecycle Notifications

// 当接收到一个广告的时候，会发送该请求。广告在后台会自动刷新。
- (void)adViewDidReceiveAd:(airADView *)view {
//    if (timer) {
//        [timer invalidate];
//        [timer release];
//        timer = nil;
//    }
//    [adMoGoView adapter:self didGetAd:@"airad"];
//    [adMoGoView adapter:self didReceiveAdView:view];
}

// 当接收广告失败的时候，会发送该请求。 通常是由于网络原因，或者是没有广告填充。
- (void)adView:(airADView *)view
didFailToReceiveAdWithError:(NSError *)error {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"airad"];
    [adMoGoView adapter:self didFailAd:error];
}

#pragma mark Ad Banner Lifecycle Notifications
- (void)adBannerWillShow:(airADView *)adView {
    
}

- (void)adBannerDidShow:(airADView *)adView {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didGetAd:@"airad"];
    [adMoGoView adapter:self didReceiveAdView:adView];
}

- (void)adBannerWillDismiss:(airADView *)adView {
    
}

- (void)adBannerDidDismiss:(airADView *)adView {
    
}

- (void)adBannerClicked:(airADView *)adView {
    
}

#pragma mark Ad Content Lifecycle Notifications

- (void)adContentWillShow:(airADView *)adView {
    [self helperNotifyDelegateOfFullScreenModal];
}
- (void)adContentDidShow:(airADView *)adView {
  
}

//当广告载入完毕时,发送此请求.也以此作为广告完成一次点击.
- (void)adContentDidLoaded:(airADView *)adView {
  
}

- (void)adContentWillDismiss:(airADView *)adView {
   
}

- (void)adContentDidDismiss:(airADView *)adView {
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didGetAd:@"airad"];
    [adMoGoView adapter:self didFailAd:nil];
}
@end