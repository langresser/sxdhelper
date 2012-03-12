//
//  SOMAFullPageBannerView.h
//  SOMASource
//
//  Created by Jocelyn Harrington on 11/24/10.
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//
#pragma once
#import <UIKit/UIKit.h>
#import "SOMABannerView.h"

enum {
	kSOMABannerCloseBtnTop      = 0,	//Close Btn on Top , default
	kSOMABannerCloseBtnBottom   = 1		//Close Btn on Bottom
};

@protocol SOMAToasterBannerViewDelegate;
@interface SOMAToasterBannerView : UIView<SOMABannerViewDelegate> {
	SOMABannerView *bannerView;
	id<SOMAToasterBannerViewDelegate> delegate;
	UIButton *CloseButton;
	NSTimer *mRefreshTimer;
	NSTimeInterval mRefreshTime;
	int closeBtnPosition;
}
@property (nonatomic,assign) id<SOMAToasterBannerViewDelegate> delegate;
@property (nonatomic,retain) SOMABannerView *bannerView;
@property (nonatomic,retain) NSTimer *mRefreshTimer;
@property int closeBtnPosition;
+(SOMAToasterBannerView*)bannerViewWithPublisherID:(int)pubID adSpaceID:(int)adSpaceID; /*Banner size 320x60 Close Button on the Top/Bottom Right Corner*/
-(void)refresh;
-(void)refreshWith:(NSTimeInterval)yourTimer;
-(void)stopRefreshTimer;

@end


@protocol SOMAToasterBannerViewDelegate
@required
- (UIViewController *)viewControllerForTBLandingPage;
@optional
-(void)SOMATBwillDisplayLandingPage:(SOMAToasterBannerView *)somaBannerView;		
-(void)SOMATBdidRemoveDisplayLandingPage:(SOMAToasterBannerView *)somaBannerView;
@end