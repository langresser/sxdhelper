//
//  AppDelegate.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice_AMAdditions.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    ViewController *viewController;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
