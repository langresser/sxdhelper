//
//  AdChinaVideoView.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "AdChinaVideoViewDelegateProtocol.h"

#define VideoSizeWithAdViewWidth(width)     CGSizeMake(width, width/4*3)

@interface AdChinaVideoView : UIView

+ (AdChinaVideoView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id<AdChinaVideoViewDelegate>)theDelegate shouldAutoPlay:(BOOL)shouldAutoPlay;

// Set view controller for browser, default view controller is delegate
- (void)setViewController:(UIViewController *)controller;

// If autoPlay is set to NO, use this method to start playing
- (void)startPlaying;

// Stop playing video when user goes to another view, e.g. when popViewController, call this method in viewWillDisappear
- (void)stopPlaying;

@end
