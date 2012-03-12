//
//  EquipItemTableViewCell.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EquipItemTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIDevice_AMAdditions.h"

@implementation EquipItemTableViewCell
@synthesize image, itemName, exData, relateItems;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        float bgpadding = 5;

        if ([[UIDevice currentDevice]isPad]) {
            bgpadding = 10;

            image = [[UIImageView alloc]initWithFrame:CGRectMake(9, 5, 80, 80)];
            itemName = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, 90, 50)];
            exData = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 600, 30)];
            relateItems = [[FTCoreTextView alloc]initWithFrame:CGRectMake(100, 40, 600, 125)];
            
            itemName.font = [UIFont systemFontOfSize:22];
            exData.font = [UIFont systemFontOfSize:22];
        } else {
            image = [[UIImageView alloc]initWithFrame:CGRectMake(9, 5, 44, 44)];
            itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 60, 50)];
            exData = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 230, 20)];
            relateItems = [[FTCoreTextView alloc]initWithFrame:CGRectMake(60, 20, 230, 100)];
            
            itemName.font = [UIFont systemFontOfSize:16];
            exData.font = [UIFont systemFontOfSize:14];
        }
        
        UIImageView* cellbg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellbg.png"]];
        CGRect rect = relateItems.frame;
        rect.origin.x -= bgpadding;
        rect.origin.y -= bgpadding;
        rect.size.width += bgpadding * 2;
        rect.size.height += bgpadding * 2;
        cellbg.frame = rect;
        
        itemName.numberOfLines = 0;
        exData.numberOfLines = 0;
        itemName.textAlignment = UITextAlignmentCenter;
        exData.textAlignment = UITextAlignmentCenter;

        itemName.adjustsFontSizeToFitWidth = YES;

        image.backgroundColor = [UIColor clearColor];
        itemName.backgroundColor = [UIColor clearColor];
        exData.backgroundColor = [UIColor clearColor];
        relateItems.backgroundColor = [UIColor clearColor];

        [self.contentView addSubview:image];
        [self.contentView addSubview:itemName];
        [self.contentView addSubview:exData];
        [self.contentView addSubview:cellbg];
        [self.contentView addSubview:relateItems];
        
        //为视图增加边框
        self.contentView.layer.masksToBounds=YES;
        self.contentView.layer.cornerRadius=10.0;
        self.contentView.layer.borderWidth=1.5;
        self.contentView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    self.image = nil;
    self.itemName = nil;
    self.exData = nil;
    self.relateItems = nil;
}

@end
