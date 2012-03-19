//
//  AppDelegate.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice_AMAdditions.h"
#import "MobClick.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, MobClickDelegate, UIAlertViewDelegate>
{
    UIWindow *window;
    ViewController *viewController;
    UINavigationController *navigationController;
}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSString* ignoreUpdateFlag;
@property (nonatomic, strong) NSString* appStoreURL;
@property (nonatomic, strong) NSDictionary* backupInfo;

@end
