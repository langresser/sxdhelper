//
//  SmartMadDelegate.h
//  SmartMad2Beta
//
//  Created by derek lix on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	PHONE_AD_MEASURE_176X27=1,
	PHONE_AD_MEASURE_240X36=2,
	PHONE_AD_MEASURE_320X48=3,
	PHONE_AD_MEASURE_360X54=4,
	PHONE_AD_MEASURE_480X72=5,
	PHONE_AD_MEASURE_640X96=6,
	TABLET_AD_MEASURE_300X250=7,
	TABLET_AD_MEASURE_468X60=8,
	TABLET_AD_MEASURE_728X90=9,
	
} AdMeasureType; 

typedef enum
{
	BANNER_ANIMATION_TYPE_NONE = 0,
	BANNER_ANIMATION_TYPE_RANDOM = 1,
	BANNER_ANIMATION_TYPE_FADEINOUT = 2,
	BANNER_ANIMATION_TYPE_FLIPFROMLEFT = 3,
	BANNER_ANIMATION_TYPE_FLIPFROMRIGHT = 4,
	BANNER_ANIMATION_TYPE_CURLUP = 5,
	BANNER_ANIMATION_TYPE_CURLDOWN = 6,
	BANNER_ANIMATION_TYPE_SLIDEFROMLEFT = 7,
	BANNER_ANIMATION_TYPE_SLIDEFROMRIGHT = 8,
	
} AdBannerTransitionAnimationType;

typedef enum
{
	UFemale=1,
	UMale=2   
	
} AdUserGen;

typedef enum
{
	AdRelease=0,   
	AdDebug=1
	
} AdCompileMode;

typedef enum
{
	EVENT_NEWAD = 1,
	EVENT_INVALIDAD = 2
	
} AdEventCodeType;


@protocol SmartMadAdViewDelegate<NSObject>

#pragma mark required
@required

-(NSString*)adPositionId;

@optional

-(NSTimeInterval)adInterval;
-(AdMeasureType)adMeasure;
-(AdBannerTransitionAnimationType)adBannerAnimation;
-(AdCompileMode)compileMode;

@end

