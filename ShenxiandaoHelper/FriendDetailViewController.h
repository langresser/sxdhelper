//
//  FriendDetailViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDetailViewController : UIViewController
@property(nonatomic, strong)    IBOutlet UILabel* labelTitle;
@property(nonatomic, strong)    IBOutlet UILabel* labelFuben;
@property(nonatomic, strong)    IBOutlet UILabel* labelShengw;
@property(nonatomic, strong)    IBOutlet UILabel* labelFeiyong;
@property(nonatomic, strong)    IBOutlet UILabel* labelWuli;
@property(nonatomic, strong)    IBOutlet UILabel* labelJueji;
@property(nonatomic, strong)    IBOutlet UILabel* labelFali;
@property(nonatomic, strong)    IBOutlet UILabel* labelZhanfa;
@property(nonatomic, strong)    IBOutlet UILabel* labelMiaoshu;
@property(nonatomic, strong)    IBOutlet UILabel* labelMiaoshuTitle;
@property(nonatomic, strong)    IBOutlet UILabel* labelPingjia;
@property(nonatomic, strong)    IBOutlet UILabel* labelPingjiaTitle;
@property(nonatomic, strong)    IBOutlet UIImageView* image;
@property(nonatomic, strong)    IBOutlet UIImageView* imageJueji;
@property(nonatomic, strong)    IBOutlet UIScrollView* scrollView;

@property(nonatomic, strong) NSDictionary* currentPlayer;

-(IBAction)onClickReturn:(id)sender;
@end
