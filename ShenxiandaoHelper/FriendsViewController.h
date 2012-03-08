//
//  FriendsViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDetailViewController.h"

enum {
    PAGE_JIANLING = 0,
    PAGE_JIANGXING,
    PAGE_WUSHENG,
    PAGE_FEIYU,
    PAGE_SHUSHI,
    PAGE_SHENMIHUOBAN,
    PAGE_MAX,
};

@interface FriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    IBOutlet UIScrollView* scrollView;
    
    int currentPage;
    
    FriendDetailViewController* detailVC;
    
    NSArray* allPlayers;
    NSMutableArray* currentPlayers[PAGE_MAX];
}

-(CGRect)rectForPage:(int)page;

-(void)updateBtn:(int)page;
-(IBAction)onClickReturn:(id)sender;
-(IBAction)onClickPro:(id)sender;
@end
