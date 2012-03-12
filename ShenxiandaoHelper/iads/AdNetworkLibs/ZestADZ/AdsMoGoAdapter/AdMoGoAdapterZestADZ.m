//
//  File: AdMoGoAdapterZestADZ.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterZestADZ.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "ZestadzView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

@implementation AdMoGoAdapterZestADZ

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeZestADZ;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"zestadz"];
    
	ZestadzView *zestView = [ZestadzView requestAdWithDelegate:self];
	self.adNetworkView = zestView;
}

- (void)stopBeingDelegate {
	// no way to set zestView's delegate to nil
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark ZestadzDelegate required methods.
- (NSString *)clientId {
	return networkConfig.pubId;
}

- (UIViewController *)currentViewController {
	return [adMoGoDelegate viewControllerForPresentingModalView];
}

#pragma mark ZestadzDelegate notification methods
- (void)didReceiveAd:(ZestadzView *)adView {
	[adMoGoView adapter:self didReceiveAdView:adView];
}

- (void)didFailToReceiveAd:(ZestadzView *)adView {
	[adMoGoView adapter:self didFailAd:nil];
}

- (void)willPresentFullScreenModal {
	[self helperNotifyDelegateOfFullScreenModal];
}

- (void)didDismissFullScreenModal {
	[self helperNotifyDelegateOfFullScreenModalDismissal];
}

#pragma mark ZestadzDelegate config methods
- (UIColor *)adBackgroundColor {
    return nil;
}

- (NSString *)keywords {
	if ([adMoGoDelegate respondsToSelector:@selector(keywords)]) {
		return [adMoGoDelegate keywords];
	}
	return @"iphone ipad ipod";
}
@end