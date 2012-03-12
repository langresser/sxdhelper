

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMAdInterstitial.h"
#import "IMAdRequest.h"
#import "IMAdError.h"
#import "IMAdInterstitialDelegate.h"

enum InterstitialStates
{
    /**
     * The default state of an interstitial.
     * If an interstitial ad request fails, or if the user dismisses the interstitial,
     * the state will be changed back to init.
     */
	kIMInterstitialAdStateInit,
    /**
     * Indicates an interstitial ad request is in progress.
     */
    kIMInterstitialAdStateLoading,
    /**
     * Indicates an interstitial is ready to be displayed.
     * An interstitial can be displayed only if the state is ready.     
     * You can call presentFromRootViewController: to display this ad.
     */
    kIMInterstitialAdStateReady,
    /**
     * Indicates an interstitial is displayed on the user's screen.
     */
    kIMInterstitialAdStateActive
};
typedef enum InterstitialStates InterstitialState;
/*
 * IMAdInterstitial.h
 * @description An interstitial ad.  This is a full-screen advertisement shown at natural
 * transition points in your application such as between game levels or news stories.
 * @note Interstitials are shown sparingly.  Expect low to no fill.
 * @author: InMobi
 * Copyright 2011 InMobi Technologies Pvt. Ltd.. All rights reserved.
 */

@interface IMAdInterstitial : NSObject
    

/**
 * You can obtain your AppId under publisher section by logging into inmobi.com . 
 * @description must be not-null.
 */
@property ( nonatomic, copy) NSString *imAppId;
/**
 * Optional delegate object that receives state change notifications from this interstitial object.
 * Typically this is a UIViewController instance.
 * Set the delegate property of this object to nil in the dealloc method of your UIViewController.
 - (void)dealloc {
 imAdInterstitial.delegate = nil;
 [imAdInterstitial release]; imAdInterstitial = nil;
 [super dealloc];
 *   }
 */
@property ( nonatomic, assign) id<IMAdInterstitialDelegate> delegate;

#pragma mark Ad Request methods

/**
 * Makes an interstitial ad request.
 * This is best to do several seconds before the interstitial is needed to
 * preload its content.  
 * @param request The ad request which will be loaded. Additional targeting options can be supplied with a request object.
 * @note show the interstitial by calling presentFromRootViewController: method.
 */

- (void)loadRequest:(IMAdRequest *)request;

#pragma mark Post-Request

/**
 * Returns the state of the interstitial ad.  The delegate's
 * interstitialDidFinishRequest: will be called when this switches from kIMInterstitialAdStateInit state to 
 * kIMInterstitialAdStateReady state.
 * 
 */

@property (nonatomic,assign,readonly) InterstitialState state;

/**
 * Presents the interstitial ad which takes over the entire screen until the
 * user dismisses it.  
 * This has no effect unless interstitialState returns kIMInterstitialAdStateReady and/or the delegate's interstitialDidReceiveAd: has been received.
 * @param _rootViewController The current view controller at the time this method is called.
 * @note After the interstitial has been removed, the delegate's
 * interstitialDidDismissScreen: will be called.
 */

- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end

