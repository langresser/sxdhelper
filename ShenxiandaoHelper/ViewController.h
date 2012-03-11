//
//  ViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "GameTutorialViewController.h"
#import "FindAnswerViewController.h"
#import "FriendsViewController.h"
#import "EquipmentViewController.h"

#import "GHAdView.h"
#import "GHAdViewDelegate.h"

@interface ViewController : UIViewController<GHAdViewDelegate>
{
    GameTutorialViewController* gameTutorialVC;
    FindAnswerViewController* findAnswerVC;
    FriendsViewController* friendsVC;
    EquipmentViewController* equipmentVC;

    AVAudioPlayer *player;
    BOOL isPlayingMusic;
    
    IBOutlet UIButton* btnSound;
    
    GHAdView *ghAdView1;
}

-(IBAction)onClickGameTutorial:(id)sender;
-(IBAction)onClickFindAnswer:(id)sender;
-(IBAction)onClickFriends:(id)sender;
-(IBAction)onClickEquipment:(id)sender;
-(IBAction)onClickSound:(id)sender;

@property(nonatomic) BOOL isPlayingMusic;
@property(nonatomic, retain) GHAdView* ghAdView1;

-(void)loadMusic;
-(void)playSound;
-(void)stopPlay;
@end
