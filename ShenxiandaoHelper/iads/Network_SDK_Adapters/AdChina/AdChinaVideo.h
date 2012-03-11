/**
 *	AdChinaVideo.h
 *	AdChina iOS SDK publisher code.
 *
 *	The entry point for request AdChina video ad
 */

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "AdChinaVideoDelegateProtocol.h"


@interface AdChinaVideo : NSObject 

// Request video ad, default size is full-screen
+ (AdChinaVideo *)requestVideoAdWithDelegate:(id<AdChinaVideoDelegate>)theDelegate;
// Request video ad with customized size
+ (AdChinaVideo *)requestVideoAdWithDelegate:(id<AdChinaVideoDelegate>)theDelegate size:(CGSize)videoSize;

// Close video ad when user close the view, e.g. when popViewController
- (void)closeVideoAd;

@end
