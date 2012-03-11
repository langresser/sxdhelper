//
//  WebBrowserViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface WebBrowserViewController : UIViewController
{
    IBOutlet UIWebView* webView_;
    IBOutlet UIBarButtonItem* back;
    IBOutlet UIBarButtonItem* forward;
    IBOutlet UILabel* titleLabel;
    NSString* url;
    
    
    UIActivityIndicatorView* activity;
}
@property(nonatomic, retain) NSString* url;
-(IBAction)onClickOpen:(id)sender;
-(IBAction)onClickClose:(id)sender;
@end
