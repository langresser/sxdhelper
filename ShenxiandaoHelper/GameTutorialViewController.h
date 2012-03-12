//
//  GameTutorialViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameTutorialDetailViewController.h"

@interface GameTutorialViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray* gameTutorial_;
@property(nonatomic, strong) GameTutorialDetailViewController* detailVC;
@property(nonatomic, strong) NSMutableArray* currentTutorial;
@property(nonatomic, strong) IBOutlet UITableView* tableView_;

-(IBAction)onClickReturn:(id)sender;
@end
