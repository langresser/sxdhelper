//
//  FindAnswerViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHAdView.h"
#import "GHAdViewDelegate.h"

@interface FindAnswerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, GHAdViewDelegate>
{
    NSMutableArray* allFaqData_;
    NSMutableArray* currentSearchData_;
    
    IBOutlet UITableView* tableView_;
    
    GHAdView *ghAdView1;
}

-(IBAction)onClickReturn:(id)sender;
@end
