//
//  WebBrowserViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebBrowserViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebBrowserViewController
@synthesize url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [webView_ addSubview:activity];
    activity.center = webView_.center;
    
    titleLabel.layer.masksToBounds=YES;
    titleLabel.layer.cornerRadius=3.0;
    titleLabel.layer.borderWidth=1.5;
    titleLabel.layer.borderColor=[[UIColor darkGrayColor] CGColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    NSURL* urlString = [[NSURL alloc]initWithString:url];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:urlString];
    [webView_ loadRequest:request];
    
    back.enabled = NO;
    forward.enabled = NO;

    [activity startAnimating];
}

-(IBAction)onClickOpen:(id)sender
{
    [[UIApplication sharedApplication]openURL:[[NSURL alloc]initWithString:url]];
}

-(IBAction)onClickClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    back.enabled = [webView canGoBack];
    forward.enabled = [webView canGoForward];
    [activity stopAnimating];
    titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activity stopAnimating];
}
@end
