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
#import "SettingViewController.h"
#import "AdMoGoView.h"

@interface ViewController : UIViewController<AdMoGoDelegate, UIPopoverControllerDelegate>
@property(nonatomic, strong)    GameTutorialViewController* gameTutorialVC;
@property(nonatomic, strong)    FindAnswerViewController* findAnswerVC;
@property(nonatomic, strong)    FriendsViewController* friendsVC;
@property(nonatomic, strong)    EquipmentViewController* equipmentVC;
@property(nonatomic, strong)    UIPopoverController* popoverVC;
@property(nonatomic, strong)    SettingViewController* settingVC;

@property(nonatomic) BOOL isPlayingMusic;
@property(nonatomic, strong) AVAudioPlayer *player;
@property(nonatomic, strong) IBOutlet UIButton* btnSound;
@property (nonatomic, strong) AdMoGoView *adView;
@property(nonatomic) BOOL shouldShowAds;

-(IBAction)onClickGameTutorial:(id)sender;
-(IBAction)onClickFindAnswer:(id)sender;
-(IBAction)onClickFriends:(id)sender;
-(IBAction)onClickEquipment:(id)sender;
-(IBAction)onClickSound:(id)sender;

-(IBAction)onClickAbout:(id)sender;

-(void)loadMusic;
-(void)playSound;
-(void)stopPlay;

-(void)onPurchaseOk;
-(void)onPurchaseFail;
@end
