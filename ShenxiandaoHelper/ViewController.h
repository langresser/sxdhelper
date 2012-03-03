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
#import "FateViewController.h"
#import "EquipmentViewController.h"
#import "ToolsViewController.h"

@interface ViewController : UIViewController
{
    GameTutorialViewController* gameTutorialVC;
    FindAnswerViewController* findAnswerVC;
    FriendsViewController* friendsVC;
    FateViewController* fateVC;
    EquipmentViewController* equipmentVC;
    ToolsViewController* toolsVC;

    AVAudioPlayer *player;
    BOOL isPlayingMusic;
}

-(IBAction)onClickGameTutorial:(id)sender;
-(IBAction)onClickFindAnswer:(id)sender;
-(IBAction)onClickFriends:(id)sender;
-(IBAction)onClickFate:(id)sender;
-(IBAction)onClickEquipment:(id)sender;
-(IBAction)onClickTools:(id)sender;
-(IBAction)onClickRemove:(id)sender;
-(IBAction)onClickAbout:(id)sender;
-(IBAction)onClickSound:(id)sender;

@property(nonatomic) BOOL isPlayingMusic;

-(void)loadMusic;
-(void)playSound;
-(void)stopPlay;
@end
