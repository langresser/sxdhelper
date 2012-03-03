//
//  EquipItemTableViewCell.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EquipItemTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation EquipItemTableViewCell
@synthesize image, itemName, exData, relateItems;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        image = [[UIImageView alloc]initWithFrame:CGRectMake(9, 5, 44, 44)];
        itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 60, 30)];
        exData = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 230, 25)];
        relateItems = [[FTCoreTextView alloc]initWithFrame:CGRectMake(60, 30, 230, 60)];
        UIImageView* cellbg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellbg.png"]];
        CGRect rect = relateItems.frame;
        rect.origin.x -= 5;
        rect.origin.y -= 5;
        rect.size.width += 10;
        rect.size.height += 10;
        cellbg.frame = rect;
        
        itemName.numberOfLines = 0;
        exData.numberOfLines = 0;
        itemName.textAlignment = UITextAlignmentCenter;
        exData.textAlignment = UITextAlignmentCenter;
        
        itemName.font = [UIFont systemFontOfSize:13];
        itemName.adjustsFontSizeToFitWidth = YES;
        exData.font = [UIFont systemFontOfSize:13];

        image.backgroundColor = [UIColor clearColor];
        itemName.backgroundColor = [UIColor clearColor];
        exData.backgroundColor = [UIColor clearColor];
        relateItems.backgroundColor = [UIColor clearColor];
        
        [relateItems addStyles:[self coreTextStyle]];

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

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
	FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc]init];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont systemFontOfSize:12];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
    defaultStyle.underlined = NO;
	[result addObject:defaultStyle];
    
    FTCoreTextStyle* linkStyle = [defaultStyle copy];
    linkStyle.name = FTCoreTextTagLink;
    linkStyle.font = [UIFont systemFontOfSize:13];
    linkStyle.textAlignment = FTCoreTextAlignementJustified;
    linkStyle.underlined = YES;
    linkStyle.color = [UIColor blueColor];
    [result addObject:linkStyle];
    
    return  result;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
