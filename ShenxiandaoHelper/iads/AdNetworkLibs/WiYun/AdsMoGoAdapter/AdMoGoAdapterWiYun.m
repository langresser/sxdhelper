//
//  File: AdMoGoAdapterWiYun.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterWiYun.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h"

@implementation AdMoGoAdapterWiYun

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeWiAd;
}

+ (void)load { 
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
	[adMoGoView adapter:self didGetAd:@"wiyun"];
	
	NSString *resId = [NSString stringWithFormat:@"%@",networkConfig.pubId];
    
	if (resId!=nil && ![resId isEqualToString:@""]) {
		
		WiAdView *adView = nil;
        
        AdViewType type = adMoGoView.adType;
        WiAdViewStyle size;
        CGPoint point;
        switch (type) {
            case AdViewTypeNormalBanner:
            case AdViewTypeiPadNormalBanner:
                size = kWiAdViewStyleBanner320_50;
                point = CGPointMake(0, 0);
                break;
            case AdViewTypeRectangle:
                size = kWiAdViewStyleBanner320_270;
                point = CGPointMake(-10, -10);
                break;
            case AdViewTypeMediumBanner:
                size = kWiAdViewStyleBanner508_80;
                point = CGPointMake(-10, -10);
                break;
            case AdViewTypeLargeBanner:
                size = kWiAdViewStyleBanner768_110;
                point = CGPointMake(-10, -10);
                break;
            case AdViewTypeFullScreen:
                size = kWiAdViewStyleFullscreen;
                point = CGPointMake(0, 0);
            default:
                break;
        }
        @try {
            adView = [WiAdView adViewWithResId:resId
                                         style:size];
        }
        @catch (NSException *exception) {
            NSLog(@"WiYun Exception %@",[exception reason]);
            [adMoGoView adapter:self didFailAd:nil];
        }
        @finally {
            
        }
        
        CGRect rect = adView.frame;
        rect.origin = point;
        adView.frame = rect;
		
		adView.delegate = self;
		UIColor *textColor = [self helperTextColorToUse];
		adView.adTextColor = textColor;
		UIColor *bgColor = [self helperBackgroundColorToUse];
		adView.adBgColor = bgColor;
		adView.refreshInterval = 0;// do not self-refresh
		[adView requestAd];
		self.adNetworkView = adView;
	}
	else {
		[adMoGoView adapter:self didFailAd:nil];
	}
	
}
- (void)stopBeingDelegate {
	WiAdView *adView = (WiAdView *)self.adNetworkView;
	if (adView != nil) {
		adView.delegate = nil;
	}
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark -
#pragma mark WiAdViewDelegate methods
- (BOOL)WiAdUseTestMode:(WiAdView*)adView{
    //返回是否使用测试模式
    if (networkConfig.testMode) {
        return YES;
    }
    return NO;
}

- (int)WiAdTestAdType:(WiAdView*)adView{
    //返回测试广告类型
    return	TEST_WIAD_TYPE_BANNER;
}

- (void)WiAdDidLoad:(WiAdView*)adView{
    //广告加载成功    
	[adMoGoView adapter:self didReceiveAdView:adView];
}

- (void)WiAdDidFailLoad:(WiAdView*)adView{
    //广告加载失败
	[adMoGoView adapter:self didFailAd:nil];
}

//全屏广告关闭按钮点击时调用
- (void)WiAdFullScreenAdSkipped:(WiAdView*)adView {
	[self helperNotifyDelegateOfFullScreenModalDismissal];
}

//全屏广告被点击后调用
- (void)WiAdFullScreenAdClicked:(WiAdView*)adView {
	[self helperNotifyDelegateOfFullScreenModal];
}
@end