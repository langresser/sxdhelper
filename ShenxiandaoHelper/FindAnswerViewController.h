//
//  FindAnswerViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindAnswerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray* allFaqData_;
@property(nonatomic, strong) NSMutableArray* currentSearchData_;
@property(nonatomic, strong) IBOutlet UITableView* tableView_;
@property(nonatomic, strong) IBOutlet UITextField* textField_;

-(IBAction)onClickReturn:(id)sender;
-(IBAction)onClickSearch:(id)sender;
@end
