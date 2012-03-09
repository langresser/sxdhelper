//
//  FriendDetailViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation FriendDetailViewController
@synthesize currentPlayer;

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
    
    image.layer.masksToBounds=YES;
    image.layer.cornerRadius=10.0;
    image.layer.borderWidth=1.5;
    image.layer.borderColor=[[UIColor darkGrayColor] CGColor];
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

-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark for ads
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    image.image = [UIImage imageNamed:[currentPlayer objectForKey:@"image_big"]];
    
    labelTitle.text = [NSString stringWithFormat:@"%@ · %@", [currentPlayer objectForKey:@"姓名"],
                  [currentPlayer objectForKey:@"职业"]];
    labelFuben.text = [currentPlayer objectForKey:@"副本"];
    labelShengw.text = [currentPlayer objectForKey:@"声望"];
    labelFeiyong.text = [currentPlayer objectForKey:@"费用"];
    labelWuli.text = [currentPlayer objectForKey:@"武力"];
    labelJueji.text = [currentPlayer objectForKey:@"绝技"];
    labelFali.text = [currentPlayer objectForKey:@"法术"];
    labelZhanfa.text = [currentPlayer objectForKey:@"战法"];
    labelZhanfa.frame = CGRectMake(labelZhanfa.frame.origin.x, labelZhanfa.frame.origin.y, 220, 50);
    [labelZhanfa sizeToFit];
    labelMiaoshu.text = [currentPlayer objectForKey:@"伙伴描述"];
    labelMiaoshu.frame = CGRectMake(labelMiaoshu.frame.origin.x, labelMiaoshu.frame.origin.y, 220, 50);
    [labelMiaoshu sizeToFit];
    labelPingjia.text = [currentPlayer objectForKey:@"评价"];
    labelPingjia.frame = CGRectMake(labelPingjia.frame.origin.x, labelPingjia.frame.origin.y, 220, 50);
    [labelPingjia sizeToFit];
    
    labelMiaoshuTitle.frame = CGRectMake(labelMiaoshuTitle.frame.origin.x,
        labelZhanfa.frame.origin.y + labelZhanfa.frame.size.height + 10,
        labelMiaoshuTitle.frame.size.width, labelMiaoshuTitle.frame.size.height);
    labelMiaoshu.frame = CGRectMake(labelMiaoshu.frame.origin.x,
        labelZhanfa.frame.origin.y + labelZhanfa.frame.size.height + 10,
        labelMiaoshu.frame.size.width, labelMiaoshu.frame.size.height);
    labelPingjiaTitle.frame = CGRectMake(labelPingjiaTitle.frame.origin.x,
        labelMiaoshu.frame.origin.y + labelMiaoshu.frame.size.height + 10,
        labelPingjiaTitle.frame.size.width, labelPingjiaTitle.frame.size.height);
    labelPingjia.frame = CGRectMake(labelPingjia.frame.origin.x,
        labelMiaoshu.frame.origin.y + labelMiaoshu.frame.size.height + 10,
        labelPingjia.frame.size.width, labelPingjia.frame.size.height);
    
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width,
                                        labelPingjia.frame.origin.y + labelPingjia.frame.size.height + 80);
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;
    
    if ([rootVC.ghAdView1 superview]) {
        [rootVC.ghAdView1 removeFromSuperview];
    }
    [self.view addSubview: rootVC.ghAdView1];
}
@end
