//
//  ImpressionADColor.h
//  Wooboo iOS SDK 2.0
//
//  Created by wooboo on 2010/1.
//  Updated by Wooboo at 2011/10.
//  Copyright 2011 www.wooboo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImpressionADView.h"

@protocol ImpressionADColorCtrlDelegate;

@interface ImpressionADColor : NSObject {
	
	id <ImpressionADColorCtrlDelegate> delegate;
	ImpressionADView *impressionADView;
	
}

@property(nonatomic,assign) id <ImpressionADColorCtrlDelegate> delegate;
@property(nonatomic,retain) ImpressionADView *impressionADView;


//*****************************************************************************

-(void)delegateDidFinishedForColor;//确认协议后请执行此方法//

@end


@protocol ImpressionADColorCtrlDelegate <NSObject>

@optional

-(UIColor*) setContentLabelColor;//设定广告文字内容颜色//
-(UIColor*) setNameLabelColor;//设定广告提供商名称文字颜色//


@end
