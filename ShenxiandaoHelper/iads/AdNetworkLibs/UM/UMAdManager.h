//
//  UMAdManager.h
//  UMAds
//
//  Created by luyiyuan on 9/3/11.
//  Copyright (c) 2011 umeng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMWebViewDelegate;
@class UMAdBannerView;

enum {
    //未知错误
    UMADErrorUnknown = 0,
    //网络异常
    UMADErrorNetWorkError = 1,
    //服务器异常
    UMADErrorServerFailure = 2,
    //获取广告清单失败
    UMADErrorInventoryUnavailable = 3,
};
typedef NSUInteger UMADError;

@protocol UMADAppDelegate <NSObject>
@required
/** 
 
 用于SDK获取当前App的媒体ID
 @return ClientId 当前App的媒体ID
 
 */
-(NSString *)UMADClientId;
@end

@protocol UMWebViewDelegate <NSObject>
@optional
/** 
 
 webview将要加载的回调
 @return void
 
 @param slotid 当前webview对应的广告位id
 
 */
- (void)UMWebAdWillLoad:(NSString *)slotid;
/** 
 
 webview加载完毕
 @return void
 
 @param slotid 当前webview对应的广告位id
 
 */
- (void)UMWebAdDidLoad:(NSString *)slotid;
/** 
 
 webview加载失败，并返回具体错误信息
 @return void
 
 @param slotid 当前webview对应的广告位id 
 @param error error code 参看 UMADError
 
 */
- (void)UMWebAd:(NSString *)slotid didFailToReceiveAdWithError:(NSError *)error;
/** 
 
 webview的退出动作
 @return void
 
 @param slotid 当前webview对应的广告位id 
 
 */
- (void)UMWebAdViewQuitAction:(NSString *)slotid;
@end

@interface UMAdManager : NSObject
{
    id _internal;
}
/** 
 
 设置SDK的AppDelegate，用于SDK获取APP实现的UMADClientId
 @warning 请在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption中先调用此函数，接着调用appLaunched，再执行其他操作
 @return void
 
 @param delegate 实现UMADAppDelegate的Class
 
 */
+ (void)setAppDelegate:(id<UMADAppDelegate>)delegate;
/** 
 
 SDK启动，请在setAppDelegate后调用
 @return void
 
 */
+ (void)appLaunched;
/** 
 
 SDK退出，请在applicationWillTerminate中调用
 @return void
 
 */
+ (void)appTerminated;
/** 
 
 请求入口型广告，注:入口型广告都是以webView全屏的形式展示的
 @return void
 @param controller 为了全屏的WebView提供PresentingModalView的父Controller
 @param delegate   实现UMWebViewDelegate的class,可以获取request的动作细节，如：获取广告失败，关闭webview等等
 @param slotid     当前webview对应的广告位id
 
 */
+ (void)requestWebAd:(UIViewController *)controller  delegate:(id<UMWebViewDelegate>)delegate slotid:(NSString *)slotid;

@end

