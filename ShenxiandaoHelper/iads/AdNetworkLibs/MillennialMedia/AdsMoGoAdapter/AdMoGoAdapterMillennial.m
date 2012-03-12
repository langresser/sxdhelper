//
//  File: AdMoGoAdapterMillennial.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterMillennial.h"
#import "AdMoGoView.h"
#import "AdMoGoConfig.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"

#define kMillennialAdFrame (CGRectMake(0, 0, 320, 53))

@interface AdMoGoAdapterMillennial ()

- (CLLocationDegrees)latitude;

- (CLLocationDegrees)longitude;

- (NSInteger)age;

- (NSString *)zipCode;

- (NSString *)sex;

@end


@implementation AdMoGoAdapterMillennial

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeMillennial;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"millennial"];
    
	NSString *apID = networkConfig.pubId;
	
	requestData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
				   @"adMoGo", @"vendor",
				   nil];
	if ([self respondsToSelector:@selector(zipCode)]) {
		[requestData setValue:[self zipCode] forKey:@"zip"];
	}
	if ([self respondsToSelector:@selector(age)]) {
		[requestData setValue:[NSString stringWithFormat:@"%d",[self age]] forKey:@"age"];
	}
	if ([self respondsToSelector:@selector(sex)]) {
		[requestData setValue:[self sex] forKey:@"sex"];
	}
	if ([self respondsToSelector:@selector(latitude)]) {
		[requestData setValue:[NSString stringWithFormat:@"%lf",[self latitude]] forKey:@"lat"];
	}
	if ([self respondsToSelector:@selector(longitude)]) {
		[requestData setValue:[NSString stringWithFormat:@"%lf",[self longitude]] forKey:@"long"];
	}
    
    AdViewType type = adMoGoView.adType;
    savedType = type;
    if (type == AdViewTypeFullScreen) {
        fullAdView = [[MMAdView interstitialWithType:MMFullScreenAdTransition apid:apID delegate:self loadAd:NO] retain];
        [fullAdView refreshAd];
    }
    else {
        CGSize size = CGSizeMake(320, 50);
        MMAdType adType;
        switch (type) {
            case AdViewTypeNormalBanner:
            case AdViewTypeMediumBanner:
            case AdViewTypeLargeBanner:
            case AdViewTypeiPadNormalBanner:
                size = CGSizeMake(320, 50);
                adType = MMBannerAdTop;
                break;
            case AdViewTypeRectangle:
                size = CGSizeMake(300, 250);
                adType = MMBannerAdRectangle;
                break;
            default:
                break;
        }
        MMAdView *adView = [MMAdView adWithFrame:CGRectMake(0, 0, size.width, size.height)
                                            type:adType
                                            apid:apID
                                        delegate:self
                                          loadAd:YES
                                      startTimer:NO];
        self.adNetworkView = adView;
    }
}

- (void)stopBeingDelegate {
	MMAdView *adView = (MMAdView *)adNetworkView;
	if (adView != nil) {
		[adView disableAdRefresh];
		adView.delegate = nil;
	}
    if (fullAdView) {
        [fullAdView disableAdRefresh];
        fullAdView.delegate = nil;
    }
}

- (void)dealloc {
    [super dealloc];
    [fullAdView release];
	[requestData release];
}

#pragma mark MMAdDelegate methods
- (NSDictionary *)requestData {
	return requestData;
}

- (void)adRequestSucceeded:(MMAdView *)adView {
	// millennial ads are slightly taller than default frame, at 53 pixels.
    if (savedType == AdViewTypeFullScreen) {
        [adMoGoView adapter:self didReceiveAdView:nil];
    }
    else {
        [adMoGoView adapter:self didReceiveAdView:adNetworkView];
    }
}

- (void)adRequestFailed:(MMAdView *)adView {
    if (savedType == AdViewTypeFullScreen) {
        [adMoGoView adapter:self didFailAd:nil];
    }
    else {
        [adMoGoView adapter:self didFailAd:nil];
    }
}

- (void)adModalWillAppear {
    if (savedType == AdViewTypeFullScreen) {
        [self helperNotifyDelegateOfFullScreenAdModal];
    }
    else {
        [self helperNotifyDelegateOfFullScreenModal];
    }
}

- (void)adModalWasDismissed {
    if (savedType == AdViewTypeFullScreen) {
        [self helperNotifyDelegateOfFullScreenAdModalDismissal];
    }
    else {
        [self helperNotifyDelegateOfFullScreenModalDismissal];
    }
}

#pragma mark requestData optional methods
- (BOOL)respondsToSelector:(SEL)selector {
	if (selector == @selector(latitude)
		&& ![adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return NO;
	}
	else if (selector == @selector(longitude)
			 && ![adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return NO;
	}
	else if (selector == @selector(age)
			 && (!([adMoGoDelegate respondsToSelector:@selector(millennialMediaAge)]
				   || [adMoGoDelegate respondsToSelector:@selector(dateOfBirth)])
				 || [self age] < 0)) {
				 return NO;
			 }
	else if (selector == @selector(zipCode)
			 && ![adMoGoDelegate respondsToSelector:@selector(postalCode)]) {
		return NO;
	}
	else if (selector == @selector(sex)
			 && ![adMoGoDelegate respondsToSelector:@selector(gender)]) {
		return NO;
	}
	else if (selector == @selector(householdIncome)
			 && ![adMoGoDelegate respondsToSelector:@selector(incomeLevel)]) {
		return NO;
	}
	else if (selector == @selector(educationLevel)
			 && ![adMoGoDelegate respondsToSelector:@selector(millennialMediaEducationLevel)]) {
		return NO;
	}
	else if (selector == @selector(ethnicity)
			 && ![adMoGoDelegate respondsToSelector:@selector(millennialMediaEthnicity)]) {
		return NO;
	}
	return [super respondsToSelector:selector];
}

- (CLLocationDegrees)latitude {
	CLLocation *loc = [adMoGoDelegate locationInfo];
	if (loc == nil) return [AdMoGoView sharedLocation].coordinate.latitude;
	return loc.coordinate.latitude;
}

- (CLLocationDegrees)longitude {
	CLLocation *loc = [adMoGoDelegate locationInfo];
	if (loc == nil) return [AdMoGoView sharedLocation].coordinate.longitude;
	return loc.coordinate.longitude;
}

- (NSInteger)age {
	return [self helperCalculateAge];
}

- (NSString *)zipCode {
	return [adMoGoDelegate postalCode];
}

- (NSString *)sex {
	NSString *gender = [adMoGoDelegate gender];
	NSString *sex = @"";
	if (gender == nil)
		return sex;
	if ([gender compare:@"m"] == NSOrderedSame) {
		sex = @"M";
	}
	else if ([gender compare:@"f"] == NSOrderedSame) {
		sex = @"F";
	}
	return sex;
}
@end