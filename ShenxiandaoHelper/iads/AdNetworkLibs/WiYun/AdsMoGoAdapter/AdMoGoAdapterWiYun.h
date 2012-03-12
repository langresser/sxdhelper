//
//  File: AdMoGoAdapterWiYun.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//WiYun v3.0.0

#import "AdMoGoAdNetworkAdapter.h"
#import "WiAdView.h"

@interface AdMoGoAdapterWiYun : AdMoGoAdNetworkAdapter <WiAdViewDelegate>{
	
}

+ (AdMoGoAdNetworkType)networkType;

@end
