//
//  EquipItemTableViewCell.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"

@interface EquipItemTableViewCell : UITableViewCell
{
    UIImageView* image;
    UILabel* itemName;
    UILabel* exData;
    FTCoreTextView* relateItems;
}

@property(nonatomic, retain) UIImageView* image;
@property(nonatomic, retain) UILabel* itemName;
@property(nonatomic, retain) UILabel* exData;
@property(nonatomic, retain) FTCoreTextView* relateItems;
@end
