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
{
    NSMutableArray* gameTutorial_;
    GameTutorialDetailViewController* detailVC;
    NSMutableArray* currentTutorial;
    
    IBOutlet UITableView* tableView_;
}

-(IBAction)onClickReturn:(id)sender;
@end
