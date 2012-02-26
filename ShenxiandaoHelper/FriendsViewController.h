//
//  FriendsViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface FriendsViewController : UIViewController<AQGridViewDelegate, AQGridViewDataSource>
@property(nonatomic, retain) AQGridView *gridView;

-(IBAction)onClickPro:(id)sender;
-(IBAction)onClickSkill:(id)sender;
@end
