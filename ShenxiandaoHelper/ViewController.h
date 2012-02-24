//
//  ViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameTutorialViewController.h"
#import "FindAnswerViewController.h"
#import "FriendsViewController.h"
#import "FateViewController.h"

@interface ViewController : UIViewController
{
    GameTutorialViewController* gameTutorialVC;
    FindAnswerViewController* findAnswerVC;
    FriendsViewController* friendsVC;
    FateViewController* fateVC;
}

-(IBAction)onClickGameTutorial:(id)sender;
-(IBAction)onClickFindAnswer:(id)sender;
-(IBAction)onClickFriends:(id)sender;
-(IBAction)onClickFate:(id)sender;
@end
