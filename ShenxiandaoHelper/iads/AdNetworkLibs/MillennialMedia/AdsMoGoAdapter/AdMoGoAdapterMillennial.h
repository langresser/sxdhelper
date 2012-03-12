//
//  File: AdMoGoAdapterMillennial.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//MM v4.5.2

#import "AdMoGoAdNetworkAdapter.h"
#import "MMAdView.h"

@interface AdMoGoAdapterMillennial : AdMoGoAdNetworkAdapter <MMAdDelegate> {
	NSMutableDictionary *requestData;
    
    MMAdView *fullAdView;
    NSUInteger savedType;
}

+ (AdMoGoAdNetworkType)networkType;

@end
