//
//  SettingViewController.h
//  ShakeRand
//
//  Created by 王 佳 on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
{    
    IBOutlet UITableView* tableView_;
}

@property(nonatomic, retain) UITableView* tableView;

-(IBAction)onClickReturn:(id)sender;
@end
