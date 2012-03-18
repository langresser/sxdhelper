//
//  GameTutorialDetailViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"

@interface GameTutorialDetailViewController : UIViewController<FTCoreTextViewDelegate>
@property (nonatomic, strong)   FTCoreTextView *coreTextView_; 
@property (nonatomic, strong)   IBOutlet UILabel* titleLabel;
@property (nonatomic, strong)   IBOutlet UILabel* subTitleLabel;
@property (nonatomic, strong)   IBOutlet UIScrollView* scrollView_;

@property (nonatomic, strong) NSString* text;
@property(nonatomic, strong) NSString* titleString;
@property(nonatomic, strong) NSString* subTitleString;

-(IBAction)onClickReturn:(id)sender;
@end
