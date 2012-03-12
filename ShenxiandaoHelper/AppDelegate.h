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

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end
