//
//  SOMAWebViewController.h
//  
//
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//
#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class SOMAWaitingTextView;

@protocol SOMAWebViewControllerDelegate;
@interface SOMAWebViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>{
	id<SOMAWebViewControllerDelegate> delegate;
	UIWebView* mWebView;
	UIActivityIndicatorView *mActivityIndicator;
	UIAlertView *appIDAlert;
	SOMAWaitingTextView *mWaitingTextView;
	NSString *textContent;
	NSURL *targetURL;
    NSString *requestURL;
    bool isRichMedia;
}
@property (nonatomic, assign) id<SOMAWebViewControllerDelegate> delegate;
@property (nonatomic, retain) NSURL *targetURL;
@property (nonatomic, retain) NSString *textContent;

-(id)initWithWebView:(UIWebView*) webView;
@end


@protocol SOMAWebViewControllerDelegate
- (void)webViewControllerDismiss:(SOMAWebViewController *)controller;
@end

