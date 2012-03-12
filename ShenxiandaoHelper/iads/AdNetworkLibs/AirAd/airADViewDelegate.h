//
//  airADViewDelegate.h
//  airADKit
//
//  Created by NSXiu on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class airADView;

@protocol airADViewDelegate

@optional

#pragma mark airAD Connection

//当遇到以下情况,会发送此请求:
//1.IP地址非法.在一些无法访问airAD广告的地区,会返回此信息.
//2.网络无相应.
//3.传输参数非法,比如,非正确的App_ID.
- (void)airADConnectFailed:(NSError*)error;

#pragma mark Ad Request Lifecycle Notifications

// 当接收到一个广告的时候，会发送该请求。广告在后台会自动刷新。
- (void)adViewDidReceiveAd:(airADView *)view;

// 当接收广告失败的时候，会发送该请求。 通常是由于网络原因，或者是没有广告填充。
- (void)adView:(airADView *)view
didFailToReceiveAdWithError:(NSError *)error;

#pragma mark Ad Banner Lifecycle Notifications


- (void)adBannerWillShow:(airADView *)adView;
- (void)adBannerDidShow:(airADView *)adView;
- (void)adBannerWillDismiss:(airADView *)adView;
- (void)adBannerDidDismiss:(airADView *)adView;
- (void)adBannerClicked:(airADView *)adView;

#pragma mark Ad Content Lifecycle Notifications

- (void)adContentWillShow:(airADView *)adView;
- (void)adContentDidShow:(airADView *)adView;

//当广告载入完毕时,发送此请求.也以此作为广告完成一次点击.
- (void)adContentDidLoaded:(airADView *)adView;

- (void)adContentWillDismiss:(airADView *)adView;
- (void)adContentDidDismiss:(airADView *)adView;


@end
