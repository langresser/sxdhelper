//
//  FriendDetailViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDetailViewController : UIViewController
{
    NSDictionary* currentPlayer;

    IBOutlet UILabel* labelTitle;
    IBOutlet UILabel* labelFuben;
    IBOutlet UILabel* labelShengw;
    IBOutlet UILabel* labelFeiyong;
    IBOutlet UILabel* labelWuli;
    IBOutlet UILabel* labelJueji;
    IBOutlet UILabel* labelFali;
    IBOutlet UILabel* labelZhanfa;
    IBOutlet UILabel* labelMiaoshu;
    IBOutlet UILabel* labelMiaoshuTitle;
    IBOutlet UILabel* labelPingjia;
    IBOutlet UILabel* labelPingjiaTitle;
    
    IBOutlet UIImageView* image;
    IBOutlet UIImageView* imageJueji;
    IBOutlet UIScrollView* scrollView;
}
@property(nonatomic, retain) NSDictionary* currentPlayer;
-(IBAction)onClickReturn:(id)sender;
@end
