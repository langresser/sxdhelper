//
//  MyClass.h
//  WQMobileDemo
//
//  Created by Topsun on 3/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQAdSDK : NSObject 
/**
 * 初始化sdk, 在创建控件之前调用
 * @param appID 应用程序ID 从网站获得
 * @param pubID 发布者ID 从网站获得
 * @param refreshRate 广告刷新时间
 * @param isTestMode 是否启用测试模式
 **/
+(void) init: (NSString*) appID withPubID:(NSString*) pubID withRefreshRate:(int) refreshRate isTestMode:(BOOL) isTestMode;

@end

