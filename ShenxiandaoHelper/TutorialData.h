//
//  TutorialData.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TutorialData : NSObject
{
    NSString* title_;
    NSString* author_;
    NSString* date_;
    NSString* text_;
}
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* author;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* text;

-(TutorialData*)initWithTitle:(NSString*)title;
@end
