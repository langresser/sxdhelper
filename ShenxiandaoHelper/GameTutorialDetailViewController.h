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
{
    UIScrollView *scrollView_;
    FTCoreTextView *coreTextView_;
    NSString* text;
}

@property (nonatomic, retain) NSString* text;
@end
