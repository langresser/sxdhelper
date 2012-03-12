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
    PAGE_ALL = 0,
    PAGE_JIANLING,
    PAGE_JIANGXING,
    PAGE_WUSHENG,
    PAGE_FEIYU,
    PAGE_SHUSHI,
    PAGE_MAX,
};

@interface FriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    NSMutableArray* currentPlayers[PAGE_MAX];
}

@property(nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property(nonatomic, strong) NSArray* allPlayers;
@property(nonatomic, strong) FriendDetailViewController* detailVC;
@property(nonatomic) int currentPage;

-(CGRect)rectForPage:(int)page;

-(void)updateBtn;
-(IBAction)onClickReturn:(id)sender;
-(IBAction)onClickPro:(id)sender;
@end
