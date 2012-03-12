//
//  File: AdMoGoAdapterGreystripe.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "GreystripeDelegate.h"

/**
 * Banner slot name used to identify the banner ad slot within the Greystripe 
 * SDK.
 */
extern NSString * const kGSBannerSlotName;

extern NSString * const kGSFullScreenSlotName;

extern NSString * const kGSIPadMediumRectangle;
extern NSString * const kGSIPadLeaderboard;

@class GSAdView;

@interface AdMoGoAdapterGreystripe : AdMoGoAdNetworkAdapter <GreystripeDelegate> {
    NSTimer *timer;
}
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
