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
    IBOutlet UITableView* tableJianLing;
    IBOutlet UITableView* tableJiangXing;
    IBOutlet UITableView* tableWuSheng;
    IBOutlet UITableView* tableFeiYu;
    IBOutlet UITableView* tableShuShi;
    IBOutlet UITableView* tableShenMiHuoBan;
    
    IBOutlet UIButton* btnJianLing;
    IBOutlet UIButton* btnJiangXing;
    IBOutlet UIButton* btnWuSheng;
    IBOutlet UIButton* btnFeiYu;
    IBOutlet UIButton* btnShuShi;
    IBOutlet UIButton* btnShenMiHuoBan;
    
    int currentPage;
    
    FriendDetailViewController* detailVC;
    
    NSArray* allPlayers;
    NSMutableArray* currentPlayers[PAGE_MAX];
}

-(void)scrollToPage:(int)page;
-(NSString*)getNameByIndex:(int)page;
-(CGRect)rectForPage:(int)page;

-(void)updateBtn:(int)page;
-(IBAction)onClickReturn:(id)sender;
-(IBAction)onClickPro:(id)sender;
@end
