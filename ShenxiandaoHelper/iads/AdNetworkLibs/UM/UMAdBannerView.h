//
//  UMAdBannerView.h
//  UMAds
//
//  Created by luyiyuan on 9/13/11.
//  Copyright (c) 2011 umeng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMAdADBannerViewDelegate;

@interface UMAdBannerView : UIView
{
@private
    id _delegate;
    id _storage;
}
@property (nonatomic, assign) id <UMAdADBannerViewDelegate> delegate;
/** 
 
 获取banner的长和宽
 @return CGSize 当前广告Banner的长宽
 
 */
+ (CGSize)sizeOfBannerContentSize;
/** 
 
 设置banner的广告属性，绑定相关参数
 @return void
 @param viewController  为点击后可能全屏的WebView提供PresentingModalView的父Controller
 @param slotid          当前Banner绑定的广告位id
 
 */
- (void)setProperty:(UIViewController *)viewController slotid:(NSString *)slotid;
/** 
 
 为Banner设定delegate，这样delegate可以监听banner的一些动作，如获取失败，点击等等
 @return void
 @param delegate 实现UMAdADBannerViewDelegate的Class
 
 */
- (void)setDelegate:(id<UMAdADBannerViewDelegate>)delegate;
@end

@protocol UMAdADBannerViewDelegate <NSObject>
@optional
/** 
 
 bannerView已经获取数据，并加载
 @return void
 @param banner 当前事件属于的bannerview
 
 */
- (void)UMADBannerViewDidLoadAd:(UMAdBannerView *)banner;
/** 
 
 bannerView获取内容失败
 @return void
 @param banner 当前事件属于的bannerview
 @param error  出错具体信息，error code可与UMAdManager.h中的UMADError对照
 
 */
- (void)UMADBannerView:(UMAdBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;
/** 
 
 bannerview点击事件即将开始
 @return void
 @param banner 当前事件属于的bannerview
 
 */
- (void)UMADBannerViewActionWillBegin:(UMAdBannerView *)banner;
/** 
 
 bannerview点击事件已经完毕
 @return void
 @param banner 当前事件属于的bannerview
 
 */
- (void)UMADBannerViewActionDidFinish:(UMAdBannerView *)banner;
@end
