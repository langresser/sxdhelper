//
//  File: AdMoGoAdapterWooboo.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterWooboo.h"
#import "AdMoGoView.h"
#import "CommonADView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"

@implementation AdMoGoAdapterWooboo

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeWooboo;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
	[adMoGoView adapter:self didGetAd:@"wooboo"];
	
	NSString *WOOBOO_PID = networkConfig.pubId;

	BOOL isTestAD = NO;
    if (networkConfig.testMode) {
        isTestAD = YES;
    }
    
	if (WOOBOO_PID!=nil && ![WOOBOO_PID isEqualToString:@""]) {
        CommonADView *myCommonADView = [[CommonADView alloc] initWithADWith:WOOBOO_PID status:isTestAD xLocation:0 yLocation:0 displayType:CommonBannerScreen horizontalOrientation:CommonOrientationPortrait];
        [myCommonADView setListenerDelegate:self];
		[myCommonADView startADRequest];
        myCommonADView.requestADTimeIntervel = 0;
        
		self.adNetworkView = myCommonADView;
		[myCommonADView release];
	}
	else {
		[adMoGoView adapter:self didFailAd:nil];
	}
}

- (void)stopBeingDelegate {
	CommonADView *ad = (CommonADView *)self.adNetworkView;
	if (ad != nil) {
		[ad setListenerDelegate:nil];
	}
}

- (void)dealloc {
	[super dealloc];
}

//set ContentLabel Color//
-(UIColor*) setContentLabelColor {
	return [self helperTextColorToUse];
}
//set AD providers NameLabel Color//
-(UIColor*) setNameLabelColor {
	return [self helperSecondaryTextColorToUse];
}

/* 点击广告条 */
- (void)onClickAD {
    
}

/* 成功获取广告时候调用 */
- (void)receiveAD {
    if ([NSThread isMainThread]) {
        [adMoGoView adapter:self didReceiveAdView:adNetworkView];
    }
    else {
        [self performSelectorOnMainThread:@selector(showAd)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

/* 获取广告失败的时候调用 */
- (void)onFailedToReceiveAD:(NSString*)error {
    [adMoGoView adapter:self didFailAd:nil];
}

- (void)showAd {
    [adMoGoView adapter:self didReceiveAdView:adNetworkView];
}
@end