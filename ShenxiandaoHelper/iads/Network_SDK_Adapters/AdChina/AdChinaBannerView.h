/**
 *	AdChinaBannerView.h
 *	AdChina iOS SDK publisher code.
 *
 *	The entry point for request AdChina banner ad
 */

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AdChinaBannerDelegateProtocol.h"

#define BannerSizeiPhone	((CGSize){320, 48})
#define BannerSizeiPad		((CGSize){728, 90})

enum {
    AnimationMaskRandom				= -1,
	AnimationMaskNone				= 0,
    AnimationMaskRushAndBreak		= 1 << 0,
	AnimationMaskDropDown			= 1 << 1,
	AnimationMaskAlert				= 1 << 2,
	AnimationMaskChangeAlpha		= 1 << 3,
	AnimationMaskFlipFromRight		= 1 << 4,
	AnimationMaskFlipFromLeft		= 1 << 5
};
typedef NSInteger AnimationMask;


@interface AdChinaBannerView : UIView 

// Returns newly created banner ad, use random animation type
+ (AdChinaBannerView *)requestAdWithDelegate:(id<AdChinaBannerDelegate>)theDelegate;
// Returns newly created banner ad and set allowed animation types
+ (AdChinaBannerView *)requestAdWithDelegate:(id <AdChinaBannerDelegate>)theDelegate animationMask:(AnimationMask)mask;

// Set position for banner ad
- (void)setAdFrame:(CGRect)theFrame;

@end
