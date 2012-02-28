//
//  FAQTableViewCell.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FAQTableViewCell.h"

@implementation FAQTableViewCell
@synthesize question, answer1, price1, answer2, price2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        self.contentView.backgroundColor = [UIColor redColor];
        question = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 295, 50)];
        answer1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 190, 30)];
        price1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 50, 95, 30)];
        answer2 =  [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 190, 30)];
        price2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 80, 95, 30)];
        
        question.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.1 alpha:0.5];
        answer1.backgroundColor = [UIColor colorWithRed:0 green:0.1 blue:0 alpha:0.5];
        price1.backgroundColor = [UIColor colorWithRed:0 green:0.1 blue:0 alpha:0.5];
        
        answer2.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0 alpha:0.5];
        price2.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0 alpha:0.5];

        question.numberOfLines = 0;
        answer1.numberOfLines = 0;
        price1.numberOfLines = 0;
        answer2.numberOfLines = 0;
        price2.numberOfLines = 0;
        
        price1.textAlignment = UITextAlignmentRight;
        price2.textAlignment = UITextAlignmentRight;

        question.font = [UIFont systemFontOfSize:13];
        answer1.font = [UIFont systemFontOfSize:13];
        answer2.font = [UIFont systemFontOfSize:13];
        price1.font = [UIFont systemFontOfSize:13];
        price2.font = [UIFont systemFontOfSize:13];

        price1.textColor = [UIColor orangeColor];
        price2.textColor = [UIColor orangeColor];
        
        [self.contentView addSubview:question];
        [self.contentView addSubview:answer1];
        [self.contentView addSubview:price1];
        [self.contentView addSubview:answer2];
        [self.contentView addSubview:price2];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
