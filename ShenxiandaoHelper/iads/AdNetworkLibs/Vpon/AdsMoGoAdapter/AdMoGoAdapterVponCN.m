//
//  File: AdMoGoAdapterVponCN.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterVponCN.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

@implementation AdMoGoAdapterVponCN

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeAdOnCN;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
	[adMoGoView adapter:self didGetAd:@"vpon"];
    CGSize size;
    switch (adMoGoView.adType) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            size = CGSizeMake(320, 48);
            break;
        case AdViewTypeRectangle:
            size = CGSizeMake(320, 270);
            break;
        case AdViewTypeMediumBanner:
            size = CGSizeMake(488, 80);
            break;
        case AdViewTypeLargeBanner:
            size = CGSizeMake(748, 110);
            break;
        default:
            break;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    adOnView = [[VponAdOnView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [adOnView requestAdWithSize:size setAdOnDelegate:self];
	self.adNetworkView = adOnView;
}

-(void) onRecevieAd:(VponAdOnView*) view{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didReceiveAdView:view];
}

-(void) onFailedToRecevieAd:(VponAdOnView*) view{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [adMoGoView adapter:self didFailAd:nil];
}

- (NSString *) adonLicenseKey{
	return networkConfig.pubId;
}

- (Boolean) autoRefreshAdonAd{
	return NO;
}

- (double) locationLatitude{
	if ([adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return [adMoGoDelegate locationInfo].coordinate.latitude;
	}
    return [AdMoGoView sharedLocation].coordinate.latitude;
}

- (double) locationLongtitude{
	if ([adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return [adMoGoDelegate locationInfo].coordinate.longitude;
	}
    return [AdMoGoView sharedLocation].coordinate.longitude;
}

- (Platform) getPlatform {	
	return CN;
}

- (CGSize) requestAdOfSize{
    switch (adMoGoView.adType) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            return ADON_SIZE_320x48;
        case AdViewTypeRectangle:
            return ADON_SIZE_320x270;
        case AdViewTypeMediumBanner:
            return ADON_SIZE_488x80;
        case AdViewTypeLargeBanner:
            return ADON_SIZE_748x110;
        default:
            break;
    }
    return ADON_SIZE_320x48;
}

- (void)stopBeingDelegate {
    VponAdOnView *adView = (VponAdOnView *)adNetworkView;
    if (adView != nil) {
        [adView removeDelegate];
    }
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

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didFailAd:nil];
}

@end