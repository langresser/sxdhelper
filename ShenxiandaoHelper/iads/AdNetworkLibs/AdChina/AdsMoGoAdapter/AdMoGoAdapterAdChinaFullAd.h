//
//  File: AdMoGoAdapterAdChinaFullAd.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.4
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "AdMoGoAdapterAdChinaFullAdController.h"
#import "AdChinaFullScreenView.h"

@interface AdMoGoAdapterAdChinaFullAd : AdMoGoAdNetworkAdapter {
    AdChinaFullScreenView *fullScreenAd;
    AdMoGoAdapterAdChinaFullAdController *controller;
}
+ (AdMoGoAdNetworkType)networkType;
@end
