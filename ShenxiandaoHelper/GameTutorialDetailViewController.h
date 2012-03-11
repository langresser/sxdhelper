//
//  GameTutorialDetailViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
#import "WebBrowserViewController.h"

@interface GameTutorialDetailViewController : UIViewController<FTCoreTextViewDelegate>
{
    FTCoreTextView *coreTextView_;
    NSString* text;
    
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* subTitleLabel;
    
    NSString* titleString;
    NSString* subTitleString;
    
    IBOutlet UIScrollView* scrollView_;
    WebBrowserViewController* webBrowerVC;
}

@property (nonatomic, retain) NSString* text;
@property(nonatomic, retain) NSString* titleString;
@property(nonatomic, retain) NSString* subTitleString;

-(IBAction)onClickReturn:(id)sender;
@end
