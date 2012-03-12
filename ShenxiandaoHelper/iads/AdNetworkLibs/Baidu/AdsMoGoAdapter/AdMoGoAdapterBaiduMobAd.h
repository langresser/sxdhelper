//
//  File: AdMoGoAdapterBaiduMobAd.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//Baidu v2.0

#import "AdMoGoAdNetworkAdapter.h"
#import "BaiduMobAdView.h"

@interface AdMoGoAdapterBaiduMobAd : AdMoGoAdNetworkAdapter <BaiduMobAdViewDelegate>{
    NSTimer *timer;
}
+ (AdMoGoAdNetworkType)networkType;
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
