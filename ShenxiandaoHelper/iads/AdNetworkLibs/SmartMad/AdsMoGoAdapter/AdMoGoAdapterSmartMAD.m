//
//  File: AdMoGoAdapterSmartMAD.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterSmartMAD.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"

#define kAdMoGoSmartMADAppIDKey @"AppID"
#define kAdMoGoSmartMADAdPosKey @"AdSpaceID"

@implementation AdMoGoAdapterSmartMAD

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeSmartMAD;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {	
	NSString *SmartMad_AppId = [networkConfig.credentials objectForKey:kAdMoGoSmartMADAppIDKey];
    NSString *SmartMad_AdPos = [networkConfig.credentials objectForKey:kAdMoGoSmartMADAdPosKey];
	
	if (SmartMad_AppId!=nil && ![SmartMad_AppId isEqualToString:@""]
		&& SmartMad_AdPos!=nil && ![SmartMad_AdPos isEqualToString:@""]) {
        [SmartMadAdView setApplicationId:SmartMad_AppId];
        
        if ([adMoGoDelegate respondsToSelector:@selector(dateOfBirth)]) {
            NSUInteger age = [self helperCalculateAge];
            [SmartMadAdView setUserAge:age];
            
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [adMoGoDelegate dateOfBirth];
            [dataFormatter setDateFormat:@"YYYYMMdd"];
            NSString *dateString = [[NSString alloc] initWithFormat:@"%@",[dataFormatter stringFromDate:date]];
            [SmartMadAdView setBirthDay:dateString];
            [dateString release];
            [dataFormatter release];
        }
        
        if ([adMoGoDelegate respondsToSelector:@selector(gender)]) {
            NSString *genderStr = [adMoGoDelegate gender];
            if ([genderStr isEqualToString:@"f"]) {
                [SmartMadAdView setUserGender:UFemale];
            }
            if ([genderStr isEqualToString:@"m"]) {
                [SmartMadAdView setUserGender:UMale];
            }
        }
        
        if ([adMoGoDelegate respondsToSelector:@selector(keywords)]) {
            NSString *keywords = [adMoGoDelegate keywords];
            [SmartMadAdView setKeyWord:keywords];
        }
        
        if ([adMoGoDelegate respondsToSelector:@selector(postalCode)]) {
            NSString *postalCode = [adMoGoDelegate postalCode];
            [SmartMadAdView setPostalCode:postalCode];
        }

        timer = [[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        
        adView = [[SmartMadAdView alloc] initRequestAdWithDelegate:self];
        [adView setEventDelegate:self];
        
        myView = [[UIView alloc] init];
        AdViewType type = adMoGoView.adType;
        if (type == AdViewTypeNormalBanner) {
            myView.frame = CGRectMake(0, 0, 320, 48);
        }
        else if (type == AdViewTypeLargeBanner) {
            myView.frame = CGRectMake(0, 0, 728, 90);
        }
        else if (type == AdViewTypeMediumBanner) {
            myView.frame = CGRectMake(0, 0, 468, 60);
        }
        else if (type == AdViewTypeRectangle) {
            myView.frame = CGRectMake(0, 0, 300, 250);
        }
        [myView addSubview:adView];
        self.adNetworkView = myView;
	}
}

- (void)stopBeingDelegate {
//    if (myView) {
//        //SmartMadAdView *adView = (SmartMadAdView *)[[myView subviews] objectAtIndex:0];
//        if (adView != nil) {
//            //[adView removeFromSuperview];
//            adView._adEventDelegate = nil;
//            [adView setEventDelegate:nil];
//        }
//        //[myView release];
//        myView = nil;
//    }
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
    adView._adEventDelegate = nil;
    [adView setEventDelegate:nil];
    [adView removeFromSuperview];
    [adView release],adView = nil;
    [myView release],myView = nil;
	[super dealloc];
}
#pragma mark - 
-(NSString*)adPositionId {
    NSString *SmartMad_AdPos = [networkConfig.credentials objectForKey:kAdMoGoSmartMADAdPosKey];
    return SmartMad_AdPos;
}

-(NSTimeInterval)adInterval {
    return 120;
}

// set ad measure type
-(AdMeasureType)adMeasure {
    AdViewType type = adMoGoView.adType;
    if (type == AdViewTypeNormalBanner) {
        return PHONE_AD_MEASURE_320X48;
    }
    else if (type == AdViewTypeLargeBanner) {
        return TABLET_AD_MEASURE_728X90;
    }
    else if (type == AdViewTypeMediumBanner) {
        return TABLET_AD_MEASURE_468X60;
    }
    else if (type == AdViewTypeRectangle) {
        return TABLET_AD_MEASURE_300X250;
    }
    return PHONE_AD_MEASURE_320X48;
}

// set ad switch animation type
-(AdBannerTransitionAnimationType)adBannerAnimation {
    return BANNER_ANIMATION_TYPE_NONE;
}

// set debug/release mode
-(AdCompileMode)compileMode {
    if (networkConfig.testMode) {
        return AdDebug;
    }
    return AdRelease;
}

#pragma mark -
- (void)adEvent:(SmartMadAdView*)adview  adEventCode:(AdEventCodeType)eventCode {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    if (eventCode == EVENT_NEWAD) {
        [adMoGoView adapter:self didGetAd:@"smartmad"];
        [adMoGoView adapter:self didReceiveAdView:myView];
    }
    else {
        [adMoGoView adapter:self didGetAd:@"smartmad"];
        [adMoGoView adapter:self didFailAd:nil];
    }
}

- (void)adFullScreenStatus:(BOOL)isFullScreen {
    if (isFullScreen) {
        [self helperNotifyDelegateOfFullScreenModal];
    }
    else {
        [self helperNotifyDelegateOfFullScreenModalDismissal];
    }
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [adMoGoView adapter:self didGetAd:@"smartmad"];
    [adMoGoView adapter:self didFailAd:nil];
}
@end
