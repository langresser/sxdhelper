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
@property(nonatomic, strong) UIImageView* image;
@property(nonatomic, strong) UILabel* itemName;
@property(nonatomic, strong) UILabel* exData;
@property(nonatomic, strong) FTCoreTextView* relateItems;
@end
