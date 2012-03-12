//
//  File: AdMoGoAdapterIAd.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import <iAd/ADBannerView.h>

@interface AdMoGoAdapterIAd : AdMoGoAdNetworkAdapter <ADBannerViewDelegate> {
	NSString *kADBannerContentSizeIdentifierPortrait;
	NSString *kADBannerContentSizeIdentifierLandscape;
}

+ (AdMoGoAdNetworkType)networkType;

@end
