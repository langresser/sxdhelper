//
//  SettingViewController.h
//  ShakeRand
//
//  Created by 王 佳 on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iads/AdNetworklibs/YouMi/YouMiWall.h"

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, YouMiWallDelegate, UIAlertViewDelegate>
{    
    IBOutlet UITableView* tableView_;

    YouMiWall* wall;
    
    NSInteger point;  // 用户的积分
    NSMutableArray *openApps;
    
    BOOL shouldShowAds;
}

@property(nonatomic, retain) UITableView* tableView;
@property(nonatomic, strong) NSMutableArray* openApps;
@property(nonatomic) BOOL shouldShowAds;

-(IBAction)onClickReturn:(id)sender;
@end
