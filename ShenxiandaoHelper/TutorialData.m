//
//  TutorialData.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TutorialData.h"


@implementation TutorialData
@synthesize author = author_;
@synthesize title = title_;
@synthesize date = date_;
@synthesize text = text_;

-(TutorialData*)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    
    return self;
}

@end
