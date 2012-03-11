/**
 *	AdChinaFullScreenView.h
 *	AdChina iOS SDK publisher code.
 *
 *	The entry point for request AdChina full-screen ad
 */

#import <UIKit/UIKit.h>
#import "AdChinaFullScreenViewDelegateProtocol.h"

#define kScreenWidth		[UIScreen mainScreen].bounds.size.width
#define FullsreenAdSize		(CGSize){kScreenWidth, kScreenWidth}

@interface AdChinaFullScreenView : UIView

+ (AdChinaFullScreenView *)requestFullScreenAdWithDelegate:(id<AdChinaFullScreenViewDelegate>)theDelegate;

@end
