//
//  File: AdMoGoAdapterJumpTap.m
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdapterJumpTap.h"
#import "AdMoGoView.h"
#import "AdMoGoConfig.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"


@implementation AdMoGoAdapterJumpTap

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeJumpTap;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    [adMoGoView adapter:self didGetAd:@"jumptap"];
    
	JTAdWidget *widget = [[JTAdWidget alloc] initWithDelegate:self
										   shouldStartLoading:YES];
	widget.frame = CGRectMake(0, 0, 320, 50);
	widget.refreshInterval = 0; // do not self-refresh
	self.adNetworkView = widget;

	[widget release];
}

- (void)stopBeingDelegate {
	// no way to set JTAdWidget's delegate to nil
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark JTAdWidgetDelegate methods

- (NSString *)publisherId:(id)theWidget {
	NSString *pubId = networkConfig.pubId;
	if (pubId == nil) {
		NSDictionary *cred = networkConfig.credentials;
		if (cred != nil) {
			pubId = [cred objectForKey:@"publisherID"];
		}
	}
	return pubId;
}

- (NSString *)site:(id)theWidget {
	NSString *siteId = nil;
    NSDictionary *cred = networkConfig.credentials;
    if (cred != nil) {
        siteId = [cred objectForKey:@"siteID"];
    }
	return siteId;
}

- (NSString *)adSpot:(id)theWidget {
	NSString *spotId = nil;
    NSDictionary *cred = networkConfig.credentials;
    if (cred != nil) {
        spotId = [cred objectForKey:@"spotID"];
    }
	return spotId;
}

- (BOOL)shouldRenderAd:(id)theWidget {
	[adMoGoView adapter:self didReceiveAdView:theWidget];
	return YES;
}

- (void)beginAdInteraction:(id)theWidget {
	[self helperNotifyDelegateOfFullScreenModal];
}

- (void)endAdInteraction:(id)theWidget {
	[self helperNotifyDelegateOfFullScreenModalDismissal];
}

- (void)adWidget:(id)theWidget didFailToShowAd:(NSError *)error {
	[adMoGoView adapter:self didFailAd:error];
}

- (void)adWidget:(id)theWidget didFailToRequestAd:(NSError *)error {
	[adMoGoView adapter:self didFailAd:error];
}

- (BOOL)respondsToSelector:(SEL)selector {
	if (selector == @selector(location:)
		&& ![adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return NO;
	}
	else if (selector == @selector(query:)
			 && ![adMoGoDelegate respondsToSelector:@selector(keywords)]) {
		return NO;
	}
	else if (selector == @selector(category:)
			 && ![adMoGoDelegate respondsToSelector:@selector(jumptapCategory)]) {
		return NO;
	}
	else if (selector == @selector(adultContent:)
			 && ![adMoGoDelegate respondsToSelector:@selector(jumptapAdultContent)]) {
		return NO;
	}
	return [super respondsToSelector:selector];
}

#pragma mark JTAdWidgetDelegate methods -Targeting
- (NSString *)query:(id)theWidget {
	return [adMoGoDelegate keywords];
}

#pragma mark JTAdWidgetDelegate methods -General Configuration
- (NSDictionary*)extraParameters:(id)theWidget {
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	if ([adMoGoDelegate respondsToSelector:@selector(dateOfBirth)]) {
		NSInteger age = [self helperCalculateAge];
		if (age >= 0)
			[dict setObject:[NSString stringWithFormat:@"%d",age] forKey:@"mt-age"];
	}
	if ([adMoGoDelegate respondsToSelector:@selector(gender)]) {
		NSString *gender = [adMoGoDelegate gender];
		if (gender != nil)
			[dict setObject:gender forKey:@"mt-gender"];
	}
	if ([adMoGoDelegate respondsToSelector:@selector(incomeLevel)]) {
		NSUInteger income = [adMoGoDelegate incomeLevel];
		NSString *level = nil;
		if (income < 15000) {
			level = @"000_015";
		}
		else if (income < 20000) {
			level = @"015_020";
		}
		else if (income < 30000) {
			level = @"020_030";
		}
		else if (income < 40000) {
			level = @"030_040";
		}
		else if (income < 50000) {
			level = @"040_050";
		}
		else if (income < 75000) {
			level = @"050_075";
		}
		else if (income < 100000) {
			level = @"075_100";
		}
		else if (income < 125000) {
			level = @"100_125";
		}
		else if (income < 150000) {
			level = @"125_150";
		}
		else {
			level = @"150_OVER";
		}
		[dict setObject:level forKey:@"mt-hhi"];
	}
	return dict;
}

- (UIColor *)adBackgroundColor:(id)theWidget {
	return [self helperBackgroundColorToUse];
}

- (UIColor *)adForegroundColor:(id)theWidget {
	return [self helperTextColorToUse];
}

#pragma mark JTAdWidgetDelegate methods -Location Configuration
- (BOOL)allowLocationUse:(id)theWidget {
	return adMoGoConfig.locationOn;
}

- (CLLocation*)location:(id)theWidget {
	if (![adMoGoDelegate respondsToSelector:@selector(locationInfo)]) {
		return [AdMoGoView sharedLocation];
	}
	return [adMoGoDelegate locationInfo];
}
@end