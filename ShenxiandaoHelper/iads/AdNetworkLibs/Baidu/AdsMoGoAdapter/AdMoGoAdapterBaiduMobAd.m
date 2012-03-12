//
//  File: AdMoGoAdapterBaiduMobAd.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterBaiduMobAd.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkConfig.h"

@implementation AdMoGoAdapterBaiduMobAd


+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeBaiduMobAd;
}

+ (void)load{
    [[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd{
    NSLog(@"%s",__FUNCTION__);
    [adMoGoView adapter:self didGetAd:@"baidu"];
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    BaiduMobAdView *adView = [BaiduMobAdView sharedAdViewWithDelegate:self];
    adView.frame = CGRectMake(0, 0, 320, 50);
    //[view addSubview:adView];
    self.adNetworkView = adView;
    //[view release];
}

- (void)stopBeingDelegate{
    NSLog(@"%@",[self.adNetworkView subviews]);
    //BaiduMobAdView *adView = (BaiduMobAdView *)[[self.adNetworkView subviews] objectAtIndex:0];
	//if (adView != nil) {
	//	adView.delegate = nil;
	//}
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
	[super dealloc];
}


- (NSString *)publisherId {
    NSLog(@"%s",__FUNCTION__);
    return @"debug";//networkConfig.pubId;
}

- (NSString*) appSpec {
    return @"debug";//temp
}

-(int) displayInterval {
    return adMoGoConfig.refreshInterval;
}


-(BOOL) enableLocation {
    return NO;
}

/**
 *  广告将要被载入
 */
-(void) willDisplayAd:(BaiduMobAdView*) adview {
    NSLog(@"%s",__FUNCTION__);
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didReceiveAdView:adview];
}

-(void)didAdImpressed {
    NSLog(@"%s",__FUNCTION__);
}



/**
 *  广告载入失败
 */
-(void) failedDisplayAd:(BaiduMobFailReason) reason {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didFailAd:nil];
    NSLog(@"%d",reason);
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",[[[[self.adMoGoView.delegate viewControllerForPresentingModalView].view subviews] objectAtIndex:0] subviews]);
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didFailAd:nil];
}
@end