//
//  AdFractaView.h
//  ADS
//
//  Created by jack on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

#define AD_SIZE_320x48     CGSizeMake(320,48)
#define AD_SIZE_320x270    CGSizeMake(320,270)
#define AD_SIZE_488x80     CGSizeMake(488,80)
#define AD_SIZE_748x110    CGSizeMake(748,110)

typedef enum MCAD_TYPE{
	
	MCAD_TOP = 1,
	MCAD_BOTTOM,
	MCAD_RECTANGLE
	
}MCAdViewType;

typedef enum AD_ANIMATION_TYPE{
	
	ADAnimationNone = 1,
	ADAnimationFromTopOrBottom,
	ADAnimationFadeOutIn
	
}ADAnimtionType;

typedef enum AD_OPEN_TYPE{
	
	ADOpenInSafari = 1,
	ADOpenInViewController    //requeir rootViewController
	
}AdOpenType;


@class AdFractaView;
@class AdContent;

@protocol AdFractaViewDelegate<NSObject>


@required
- (NSString *)publisherid;


@optional
- (CGSize)adSize;
- (int)refreshTime;
- (void)didFailToReceiveAd:(AdFractaView *)adView;
- (void)didReceiveAd:(AdFractaView *)adView;

- (BOOL) shouldCloseAdFractaView:(AdFractaView *)adView;

- (void) willAdViewClosed:(AdFractaView *)adView;

@end

@interface AdFractaView : UIView<CLLocationManagerDelegate>{
	id<AdFractaViewDelegate> delegate_;
	id					rootViewController_;
	
	ADAnimtionType		animtionType_;
	AdOpenType			adOpenType_;
}
@property (nonatomic, assign) id <AdFractaViewDelegate> delegate_;
@property (nonatomic, assign) id rootViewController_;
@property (nonatomic) ADAnimtionType animtionType_;
@property (nonatomic) AdOpenType adOpenType_;
@property (nonatomic) BOOL startAd;
@property (nonatomic) BOOL isLocation;

-(void)testByAdContent:(AdContent*)testContent;

+ (AdFractaView*)photoAdWithFrame:(CGRect)frame delegate:(id<AdFractaViewDelegate>)delegate adType:(MCAdViewType)adType;

- (void) startRequest;

@end
