//
//  SMBannerView.h
//  SmartmadSample
//
//  Created by MadClient on 4/22/11.
//  Copyright 2011 Madhouse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartMadDelegate.h"

@class SmartMadAdView;


@protocol SmartMadAdEventDelegate<NSObject>

- (void)adEvent:(SmartMadAdView*)adview  adEventCode:(AdEventCodeType)eventCode;
- (void)adFullScreenStatus:(BOOL)isFullScreen;

@end


@interface SmartMadAdView : UIView {
	
@public
	
	id<SmartMadAdEventDelegate>  _adEventDelegate;
}

@property(nonatomic,assign)id<SmartMadAdEventDelegate>  _adEventDelegate;

//interface for use
//set some option parameters
+(void)setApplicationId:(NSString *)applicationId;
+(void)setKeyWord:(NSString*)aKeyWord;
+(void)setUserGender:(AdUserGen)aGender;
+(void)setUserAge:(NSInteger)age;
+(void)setBirthDay:(NSString*)aBirthDay;
+(void)setFavorite:(NSString*)aFavorite;
+(void)setCity:(NSString*)aCityName;
+(void)setPostalCode:(NSString*)aPostalCode;
+(void)setWork:(NSString*)aWorkType;
+(void)skipCurrentFullscreenAd;

-(SmartMadAdView*)initRequestAdWithDelegate:(id<SmartMadAdViewDelegate>)adelegate;
-(SmartMadAdView*)initRequestAdWithParameters:(NSString*)posID  compileMode:(AdCompileMode)compileMode;
-(SmartMadAdView*)initRequestAdWithParameters:(NSString*)posID aInterval:(NSTimeInterval)aInterval
									adMeasure:(AdMeasureType)adMeasure adBannerAnimation:(AdBannerTransitionAnimationType)adBannerAnimation compileMode:(AdCompileMode)compileMode;
-(void)setEventDelegate:(id<SmartMadAdEventDelegate>)aEventDelegate;

@end
