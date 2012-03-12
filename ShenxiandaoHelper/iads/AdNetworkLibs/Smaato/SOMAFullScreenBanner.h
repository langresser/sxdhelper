//
//  SOMAFullScreenBanner.h
//  SOMASource
//
//  Created by Jocelyn Harrington on 12/1/10.
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//
#pragma once
#import <UIKit/UIKit.h>
#import "SOMABannerView.h"
@protocol SOMAFullScreenDelegate;
@interface SOMAFullScreenBanner : UIView<SOMABannerViewDelegate> {
	id<SOMAFullScreenDelegate> delegate;
	SOMABannerView *bannerView;
	NSTimer *timer;
	UIButton *skipButton;
	UIButton *moreButton;
	UIActivityIndicatorView *spinner;
}
@property (nonatomic, retain) SOMABannerView *bannerView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id<SOMAFullScreenDelegate> delegate;
+(SOMAFullScreenBanner*)bannerViewWithPublisherID:(int)pubID adSpaceID:(int)adSpaceID; /*Banner size is full screen for iPhone*/
-(void)dismissBanner;
@end

@protocol SOMAFullScreenDelegate
-(UIViewController *)viewControllerForMoreInfo;
-(void)dismissFullScreenBannerView:(SOMAFullScreenBanner *)somaBannerView;
-(void)willDisplayMoreInfo:(SOMAFullScreenBanner *)somaBannerView;		
-(void)didReturnDisplayLandingPage:(SOMAFullScreenBanner *)somaBannerView;
@end