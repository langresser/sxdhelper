//
//  FAQTableViewCell.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQTableViewCell : UITableViewCell
{
    UILabel* question;
    UILabel* answer1;
    UILabel* price1;
    UILabel* answer2;
    UILabel* price2;
}

@property(nonatomic, retain) UILabel* question;
@property(nonatomic, retain) UILabel* answer1;
@property(nonatomic, retain) UILabel* price1;
@property(nonatomic, retain) UILabel* answer2;
@property(nonatomic, retain) UILabel* price2;
@end
