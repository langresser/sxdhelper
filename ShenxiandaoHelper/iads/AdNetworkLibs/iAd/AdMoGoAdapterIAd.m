//
//  File: AdMoGoAdapterIAd.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterIAd.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

@implementation AdMoGoAdapterIAd

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeIAd;
}

+ (void)load {
	if(NSClassFromString(@"ADBannerView") != nil) {
		[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
	}
}

- (void)getAd {
    AdViewType type = adMoGoView.adType;
    BOOL isBanner = YES;
    if ( (type == AdViewTypeRectangle)||(type == AdViewTypeMediumBanner) ) {
        isBanner = NO;
    }
    if (!isBanner) {
        //NSLog(@"iAd does not support AdViewTypeRectangle and AdViewTypeMediumBanner");
        [adMoGoView adapter:self didFailAd:nil];
        return;
    }
    
    [adMoGoView adapter:self didGetAd:@"iad"];
    
	ADBannerView *iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
	kADBannerContentSizeIdentifierPortrait =
    &ADBannerContentSizeIdentifierPortrait != nil ?
	ADBannerContentSizeIdentifierPortrait :
	ADBannerContentSizeIdentifier320x50;
	kADBannerContentSizeIdentifierLandscape =
    &ADBannerContentSizeIdentifierLandscape != nil ?
	ADBannerContentSizeIdentifierLandscape :
	ADBannerContentSizeIdentifier480x32;
	iAdView.requiredContentSizeIdentifiers = [NSSet setWithObjects:
											  kADBannerContentSizeIdentifierPortrait,
											  kADBannerContentSizeIdentifierLandscape,
											  nil];
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	
	if (UIDeviceOrientationIsLandscape(orientation)) {
		iAdView.currentContentSizeIdentifier = kADBannerContentSizeIdentifierLandscape;
	}
	else {
		iAdView.currentContentSizeIdentifier = kADBannerContentSizeIdentifierPortrait;
	}
	[iAdView setDelegate:self];
	
	self.adNetworkView = iAdView;
	[iAdView release];
}

- (void)stopBeingDelegate {
	ADBannerView *iAdView = (ADBannerView *)self.adNetworkView;
	if (iAdView != nil) {
		iAdView.delegate = nil;
	}
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation {
	ADBannerView *iAdView = (ADBannerView *)self.adNetworkView;
	if (iAdView == nil) return;
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		iAdView.currentContentSizeIdentifier = kADBannerContentSizeIdentifierLandscape;
	}
	else {
		iAdView.currentContentSizeIdentifier = kADBannerContentSizeIdentifierPortrait;
	}
	// ADBanner positions itself in the center of the super view, which we do not
	// want, since we rely on publishers to resize the container view.
	// position back to 0,0
	CGRect newFrame = iAdView.frame;
	newFrame.origin.x = newFrame.origin.y = 0;
	iAdView.frame = newFrame;
}

- (BOOL)isBannerAnimationOK:(AMBannerAnimationType)animType {
	if (animType == AMBannerAnimationTypeFadeIn) {
		return NO;
	}
	return YES;
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark IAdDelegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	// ADBanner positions itself in the center of the super view, which we do not
	// want, since we rely on publishers to resize the container view.
	// position back to 0,0
	CGRect newFrame = banner.frame;
	newFrame.origin.x = newFrame.origin.y = 0;
	banner.frame = newFrame;
	
	[adMoGoView adapter:self didReceiveAdView:banner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	[adMoGoView adapter:self didFailAd:error];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
	[self helperNotifyDelegateOfFullScreenModal];
	return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
	[self helperNotifyDelegateOfFullScreenModalDismissal];
}

@end
