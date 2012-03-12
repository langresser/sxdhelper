//
//  SOMABannerView.h
//  SomaLib
//
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#pragma once
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SOMAAd.h"
#import "SOMADebugViewController.h"
#import "SOMAWebViewController.h"
#import "SOMASettingController.h"
#import "SOMABannerViewDelegate.h"
#import "SOMABanner.h"
@class SOMAWebUA;
@class SOMABanner;

/* Control of animation */
enum {
	kSOMAAnimationRandom   = 0,		//Random
	kSOMAAnimationMoveIn   = 1,		//Move
	kSOMAAnimationPush     = 2,		//Push
	kSOMAAnimationReveal   = 3,		//Reveal
	kSOMAAnimationFade     = 4,		//Fade
	kSOMAAnimationNone     = 5,     //Turn off animation
};
/* Control of animation Direction */
enum {
	kSOMAAnimationRandomDirection = 0,	//Random
    kSOMAAnimationLeft     = 1,		//From Left
	kSOMAAnimationRight    = 2,		//From Right
	kSOMAAnimationTop      = 3,		//From Top
	kSOMAAnimationBottom   = 4		//From Bottom
};
/* 
 *	A SOMABannerView is the easiest way to integrate and advertisement banner inside an iOS application. It has following
 *	characteristics
 *		- holds a SOMABanner representing the advertising element inside the view
 *		- Can be made invisible if an error occurs in the download of SOMABAnner
 *		- when clicked on will present a web view displaying the content of the SOMABanner targetURL
 *		- Allow full customization of the SOMABannerView display through a SOMABannerViewDelegate delegate
 */	 
@interface SOMABannerView : UIView<UIWebViewDelegate,DebugViewControllerDelegate,SOMAWebViewControllerDelegate,SOMASettingControllerDelegate, BannerDelegate> {
    int somaAnimationControl;
	int somaAnimationDirection;
	id<SOMABannerViewDelegate> delegate;
	BOOL mBegin;
	BOOL isActive;
	BOOL showBadge;
    CGFloat intDistance;
	UIWebView *imageView;
	UIImage *mTextImage;
	BOOL isLoadingImage;
	BOOL preImage;
	NSTimer *mRefreshTimer;
	NSTimeInterval mRefreshTime;
    BOOL loadingVideo;
    BOOL playingVideo;
    MPMoviePlayerController* moviePlayer;
    UIActivityIndicatorView *activityIndicator;
    UIView *touchedView;
}

/* SOMABannerView Properties */
@property (assign) id<SOMABannerViewDelegate> delegate;
@property (assign) int somaAnimationControl;
@property (assign) int somaAnimationDirection;
@property (assign) BOOL showBadge;									//Default:ON. For text ads, is the Smaato badge shown
@property (assign) SOMABannerType bannerFormat;
/* Commidity creators for SOMABannerView the result is autoreleased */
+(SOMABannerView*)bannerView;
+(SOMABannerView*)bannerViewWithPublisherID:(int)pubId withAdspaceID:(int)adspaceId;
/*Fast class method to create a banner view instance*/
+(SOMABannerView*)medRectBannerViewWithPublisherID:(int)pubId adSpaceID:(int)adspaceId userID:(NSString*)userId;
+(SOMABannerView*)leaderBannerViewWithPublisherID:(int)pubId adSpaceID:(int)adspaceId userID:(NSString*)userId;
+(SOMABannerView*)skyBannerViewWithPublisherID:(int)pubId adSpaceID:(int)adspaceId userID:(NSString*)userId;
+(SOMABannerView*)bannerViewWithPublisherID:(int)pubId adSpaceID:(int)adspaceId userID:(NSString*)userId;
/* set the Publisher ID*/
-(void)setSOMAPubID:(int)pubId;
/* set the Adspace ID*/
-(void)setSOMAAdspaceID:(int)adspaceId;
/* Will trigger a single refresh call of the SOMABanner by querying a new SOMAAd. */
-(void)refresh;
/* Triggers an asynchronous refresh of the banner by your set of time. It can be 30seconds, 45seconds and so on. */
-(void)refreshWith:(NSTimeInterval)yourTimer;
/* Let you stop the refresh timer*/
-(void)stopRefreshTimer;
/* show the user profile settingView */
-(void)SOMACollectData;
-(void)stopVideoPlayback;

@end
