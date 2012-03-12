//
//  WebBrowserViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface WebBrowserViewController : UIViewController

@property(nonatomic, strong)    IBOutlet UIWebView* webView_;
@property(nonatomic, strong)    IBOutlet UIBarButtonItem* back;
@property(nonatomic, strong)    IBOutlet UIBarButtonItem* forward;
@property(nonatomic, strong)    IBOutlet UILabel* titleLabel;

@property(nonatomic, strong)    UIActivityIndicatorView* activity;
@property(nonatomic, strong) NSString* url;

-(IBAction)onClickOpen:(id)sender;
-(IBAction)onClickClose:(id)sender;
@end
