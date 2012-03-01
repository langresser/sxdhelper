//
//  FAQTableViewCell.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FAQTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation FAQTableViewCell
@synthesize question, answer1, price1, answer2, price2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        self.contentView.backgroundColor = [UIColor redColor];
        question = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kTableViewWidth, kQuestionHeight)];
        answer1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + kQuestionHeight, kTableViewWidth - 10, kAnswerHeight)];
        price1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5 + kQuestionHeight + kAnswerHeight, kTableViewWidth - 15, kPriceHeight)];
        answer2 =  [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + kQuestionHeight + kAnswerHeight + kPriceHeight, kTableViewWidth - 10, kAnswerHeight)];
        price2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5 + kQuestionHeight + kAnswerHeight * 2 + kPriceHeight, kTableViewWidth - 15, kPriceHeight)];
        
        question.backgroundColor = [UIColor clearColor];
        question.adjustsFontSizeToFitWidth = YES;
        answer1.backgroundColor = [UIColor clearColor];
        answer1.adjustsFontSizeToFitWidth = YES;
        price1.backgroundColor = [UIColor clearColor];
        
        answer2.backgroundColor = [UIColor clearColor];
        answer2.adjustsFontSizeToFitWidth = YES;
        price2.backgroundColor = [UIColor clearColor];

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

@end
