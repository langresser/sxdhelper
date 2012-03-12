//  File: AdMoGoAdapterSmaato.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterSmaato.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

#define kAdMoGoSmaatoPublisherID @"PublisherId"
#define kAdMoGoSmattoAdspaceID @"AdSpaceId"

@implementation AdMoGoAdapterSmaato

static bool isFirst = NO;

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeSmaato;
}


- (void)getAd {
    if (!isFirst) {
        isFirst = YES;
        [[SOMAEnvironment defaultEnvironment] sessionStart];
    }
    
    [adMoGoView adapter:self didGetAd:@"smaato"];
    NSString *publisherID = [networkConfig.credentials objectForKey:kAdMoGoSmaatoPublisherID];
    NSString *adspaceID = [networkConfig.credentials objectForKey:kAdMoGoSmattoAdspaceID];
    
    AdViewType type = adMoGoView.adType;
    if (type == AdViewTypeFullScreen) {
        SOMAFullScreenBanner *fullScreenBanner = [SOMAFullScreenBanner 
                                                  bannerViewWithPublisherID:[publisherID intValue]
                                                  adSpaceID:[adspaceID intValue]];
		fullScreenBanner.delegate = self;
		self.adNetworkView = fullScreenBanner;
    }
    else {
        SOMABannerView *mBannerView = 
        [SOMABannerView bannerViewWithPublisherID:[publisherID intValue]
                                    withAdspaceID:[adspaceID intValue]];
        switch (type) {
            case AdViewTypeNormalBanner:
            case AdViewTypeiPadNormalBanner:
                break;
            case AdViewTypeRectangle:
                mBannerView.bannerFormat = kSOMAMedRect; //300*250
                break;
            case AdViewTypeMediumBanner:
                [adMoGoView adapter:self didFailAd:nil];
                return;
                break;
            case AdViewTypeLargeBanner:
                mBannerView.bannerFormat = kSOMAFormatLeader;//728 * 90
                break;
            default:
                break;
        }
        [mBannerView setDelegate:self];
        self.adNetworkView = mBannerView;
        [mBannerView refresh];
    }
}

- (void)stopBeingDelegate {
	SOMABannerView *mBannerView = (SOMABannerView *)adNetworkView;
    if (mBannerView) {
        [mBannerView setDelegate:nil];
    }
}

- (void)dealloc {
    [super dealloc];
}

-(void) SOMAdidReceiveAd:(SOMABannerView *)somaBannerView {
    [adMoGoView adapter:self didReceiveAdView:somaBannerView];
}
-(void) SOMAdidFailToReceiveAd:(SOMABannerView *)somaBannerView { 
    [adMoGoView adapter:self didFailAd:nil];
}

- (void)SOMABannerView:(SOMABannerView *)somaBannerView displayLandingPage:(UIViewController *)controller{
    [[adMoGoDelegate viewControllerForPresentingModalView] 
     presentModalViewController:controller animated:YES];
}
- (void)SOMABannerView:(SOMABannerView *)somaBannerView dismiss:(UIViewController *)controller{ 
    [[adMoGoDelegate viewControllerForPresentingModalView] 
     dismissModalViewControllerAnimated:YES];
}

-(void) willShowDefaultWebView:(SOMABannerView *)somaBannerView {
    [self helperNotifyDelegateOfFullScreenModal];
}

-(void) didHideDefaultWebView:(SOMABannerView *)somaBannerView {
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

#pragma mark - 
#pragma Full
-(UIViewController *)viewControllerForMoreInfo {
    return [adMoGoDelegate viewControllerForPresentingModalView];
}
-(void)dismissFullScreenBannerView:(SOMAFullScreenBanner *)somaBannerView {
    [adMoGoView adapter:self didFailAd:nil];
}
-(void)willDisplayMoreInfo:(SOMAFullScreenBanner *)somaBannerView {
}
-(void)didReturnDisplayLandingPage:(SOMAFullScreenBanner *)somaBannerView {
}
@end