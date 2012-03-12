//
//  MobWinBannerViewDelegate.h
//  MobWinSDK
//
//  Created by Guo Zhao on 10/28/11.
//  Copyright (c) 2011 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MobWinBannerViewDelegate <NSObject>

@optional


// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived;

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived;

// 广告栏被点击后调用
//
// 详解:当接收到广告栏被点击事件后调用该函数
- (void)bannerViewDidClicked;

@end
