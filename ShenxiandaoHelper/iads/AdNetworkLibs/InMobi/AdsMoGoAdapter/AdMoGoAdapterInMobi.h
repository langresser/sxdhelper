//
//  File: AdMoGoAdapterInMobi.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//InMobi v3.0.2

#import "AdMoGoAdNetworkAdapter.h"
#import "IMAdDelegate.h"
#import "IMAdInterstitialDelegate.h"

@interface AdMoGoAdapterInMobi : AdMoGoAdNetworkAdapter <IMAdDelegate,IMAdInterstitialDelegate> {
	
}

+ (AdMoGoAdNetworkType)networkType;

@end
