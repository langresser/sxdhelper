//
//  SOMADebugViewController.h
//  SomaLib
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol DebugViewControllerDelegate;

@interface SOMADebugViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UIWebViewDelegate> {
    UITableView *myTable;
	BOOL isTextBanner;
	UIWebView *myImageView;
	UIImageView *myTextBanner;
    id <DebugViewControllerDelegate> delegate;
}
@property (nonatomic, assign) id <DebugViewControllerDelegate> delegate;
@end

@protocol DebugViewControllerDelegate
- (void)debugViewControllerDidFinish:(SOMADebugViewController *)controller;
@end