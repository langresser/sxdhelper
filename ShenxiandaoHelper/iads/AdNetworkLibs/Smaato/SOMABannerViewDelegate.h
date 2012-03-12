//
//  SOMABannerViewDelegate.h
//  SOMASDK
//
//  Created by Jocelyn Harrington on 2/17/11.
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <UIKit/UIKit.h>

@class SOMABannerView;
@protocol SOMABannerViewDelegate <NSObject>
@required
-(void)SOMABannerView:(SOMABannerView *)somaBannerView displayLandingPage:(UIViewController *)controller;
-(void)SOMABannerView:(SOMABannerView *)somaBannerView dismiss:(UIViewController *)controller;
@optional
-(void) SOMAdidReceiveAd:(SOMABannerView *)somaBannerView;
-(void) SOMAdidFailToReceiveAd:(SOMABannerView *)somaBannerView;
-(void) willShowDefaultWebView:(SOMABannerView *)somaBannerView;		//Simple notification when the default web view is shown
-(void) didHideDefaultWebView:(SOMABannerView *)somaBannerView;			//Simple notification when the default web view disappears
@end
