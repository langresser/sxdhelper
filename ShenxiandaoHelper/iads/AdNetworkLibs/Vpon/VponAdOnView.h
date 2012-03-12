//
//  AdView.h
//  AdOn
//
//  Created by Shark on 2010/6/2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AdOnDelegate.h"

///< Traditional size for an AdOn Ad, 320x48 pixels, used in older AdMob SDKs.
#define ADON_SIZE_320x48     CGSizeMake(320,48)

///< Medium Rectangle size for an AdOn Ad, 320x270 pixels, designed for iPad's screen size,
///< especially in a UISplitView's left pane. 
#define ADON_SIZE_320x270    CGSizeMake(320,270)

///< Full Banner size for an AdOn Ad, 488x80 pixels, designed for iPad's screen size,
///< especially in a UIPopoverController or in UIModalPresentationFormSheet placement.
#define ADON_SIZE_488x80     CGSizeMake(488,80)

///< Leaderboard size for an AdOn Ad, 748x110 pixels, designed for iPad's screen size.
#define ADON_SIZE_748x110    CGSizeMake(748,110)

///<#define ADON_SIZE_748x110    CGSizeMake(0, 0)

@interface VponAdOnView : UIView <VponAdOnDelegate>{
	id<VponAdOnDelegate> adOnDelegate;
}

@property (nonatomic, assign) id<VponAdOnDelegate> adOnDelegate;

/**
 *建立Vpon廣告的實體
 */

- (void) requestAdWithSize:(CGSize)size setAdOnDelegate:(id<VponAdOnDelegate>) delegate;

/**
 * 暫停目前畫面中的自動更新廣告的功能 
 * 
 */

-(void) pauseAdAutoRefresh;

/**
 * 重新啟動自動更新的功能
 * 
 */

-(void) restartAdAutoRefresh;

/**
 * 更新目前畫面中的廣告，使用refreshAd的功能將會忽略掉autoRefreshAd中設定為True的值。
 *  
 */

-(void) refreshAd;

/**
 * 目前SDK的版本
 * @return SDK Version
 */

-(NSString*) getVersion;

/**
 *當不使用廣告時移除VponAdOnDelegate.
 */
-(void) removeDelegate;


@end
