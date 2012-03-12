//
//  File: AdMoGoAdapterAdChinaFullAd.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.4
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterAdChinaFullAd.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h" 

@implementation AdMoGoAdapterAdChinaFullAd

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeAdChinaFullAd;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
	if (adMoGoView.adType == AdViewTypeFullScreen) {
        controller = [[AdMoGoAdapterAdChinaFullAdController alloc] initWithAdChina:self];
        [adMoGoView adapter:self didGetAd:@"adchina"];
        fullScreenAd = [AdChinaFullScreenView requestAdWithAdSpaceId:networkConfig.pubId  delegate:controller];
        [controller.view addSubview:fullScreenAd];
    }
}

- (void)stopBeingDelegate {
    fullScreenAd = nil;
}

- (void)dealloc {
    [super dealloc];
    [controller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
