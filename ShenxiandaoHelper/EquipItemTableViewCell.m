//
//  EquipItemTableViewCell.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EquipItemTableViewCell.h"

@implementation EquipItemTableViewCell
@synthesize image, itemName, exData, relateItems;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 30)];
        exData = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 250, 25)];
        relateItems = [[FTCoreTextView alloc]initWithFrame:CGRectMake(50, 30, 250, 60)];
        
        itemName.numberOfLines = 0;
        exData.numberOfLines = 0;
        
        itemName.font = [UIFont systemFontOfSize:15];
        exData.font = [UIFont systemFontOfSize:15];

        image.backgroundColor = [UIColor blueColor];
        itemName.backgroundColor = [UIColor yellowColor];
        exData.backgroundColor = [UIColor greenColor];
        relateItems.backgroundColor = [UIColor purpleColor];

        [self.contentView addSubview:image];
        [self.contentView addSubview:itemName];
        [self.contentView addSubview:exData];
        [self.contentView addSubview:relateItems];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
