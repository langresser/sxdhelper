//
//  FindAnswerViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindAnswerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray* allFaqData_;
    NSMutableArray* currentSearchData_;
    
    IBOutlet UITableView* tableView_;
}

-(IBAction)onClickReturn:(id)sender;
@end
