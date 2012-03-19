//
//  FriendDetailViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "UIDevice_AMAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation FriendDetailViewController
@synthesize currentPlayer, labelTitle, labelFuben, labelShengw, labelFeiyong, labelWuli, labelJueji;
@synthesize labelFali, labelZhanfa, labelMiaoshu, labelMiaoshuTitle, labelPingjia, labelPingjiaTitle;
@synthesize image, imageJueji, scrollView;

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
    self.labelTitle = nil;
    self.labelFuben = nil;
    self.labelShengw = nil;
    self.labelFeiyong = nil;
    self.labelWuli = nil;
    self.labelJueji = nil;
    self.labelFali = nil;
    self.labelZhanfa = nil;
    self.labelMiaoshu = nil;
    self.labelMiaoshuTitle = nil;
    self.labelPingjia = nil;
    self.labelPingjiaTitle = nil;
    
    self.image = nil;
    self.imageJueji = nil;
    self.scrollView = nil;
    
    self.currentPlayer = nil;
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    image.image = nil;
    self.currentPlayer = nil;
    
    self.labelTitle.text = nil;
    self.labelFuben.text = nil;
    self.labelShengw.text = nil;
    self.labelFeiyong.text = nil;
    self.labelWuli.text = nil;
    self.labelJueji.text = nil;
    self.labelFali.text = nil;
    self.labelZhanfa.text = nil;
    self.labelMiaoshu.text = nil;
    self.labelPingjia.text = nil;
    imageJueji.image = nil;;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString* imageName = [currentPlayer objectForKey:@"image_big"];
    NSString* path = [[NSBundle mainBundle]pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]];
    image.image = [[UIImage alloc]initWithContentsOfFile:path];
    imageJueji.image = [UIImage imageNamed:[currentPlayer objectForKey:@"绝技标签"]];
    
    labelTitle.text = [NSString stringWithFormat:@"%@ · %@", [currentPlayer objectForKey:@"姓名"],
                  [currentPlayer objectForKey:@"职业"]];
    labelFuben.text = [currentPlayer objectForKey:@"副本"];
    labelShengw.text = [currentPlayer objectForKey:@"声望"];
    labelFeiyong.text = [currentPlayer objectForKey:@"费用"];
    labelWuli.text = [currentPlayer objectForKey:@"武力"];
    labelJueji.text = [currentPlayer objectForKey:@"绝技"];
    labelFali.text = [currentPlayer objectForKey:@"法术"];
    labelZhanfa.text = [currentPlayer objectForKey:@"战法"];
    float labelWidth = 230;
    float padding = 10;
    if ([[UIDevice currentDevice]isPad]) {
        labelWidth = 600;
        padding = 20;
    }
    labelZhanfa.frame = CGRectMake(labelZhanfa.frame.origin.x, labelZhanfa.frame.origin.y, labelWidth, 50);
    [labelZhanfa sizeToFit];
    labelMiaoshu.text = [currentPlayer objectForKey:@"伙伴描述"];
    labelMiaoshu.frame = CGRectMake(labelMiaoshu.frame.origin.x, labelMiaoshu.frame.origin.y, labelWidth, 50);
    [labelMiaoshu sizeToFit];
    labelPingjia.text = [currentPlayer objectForKey:@"评价"];
    labelPingjia.frame = CGRectMake(labelPingjia.frame.origin.x, labelPingjia.frame.origin.y, labelWidth, 50);
    [labelPingjia sizeToFit];
    
    labelMiaoshuTitle.frame = CGRectMake(labelMiaoshuTitle.frame.origin.x,
        labelZhanfa.frame.origin.y + labelZhanfa.frame.size.height + padding,
        labelMiaoshuTitle.frame.size.width, labelMiaoshuTitle.frame.size.height);
    labelMiaoshu.frame = CGRectMake(labelMiaoshu.frame.origin.x,
        labelZhanfa.frame.origin.y + labelZhanfa.frame.size.height + padding,
        labelMiaoshu.frame.size.width, labelMiaoshu.frame.size.height);
    labelPingjiaTitle.frame = CGRectMake(labelPingjiaTitle.frame.origin.x,
        labelMiaoshu.frame.origin.y + labelMiaoshu.frame.size.height + padding,
        labelPingjiaTitle.frame.size.width, labelPingjiaTitle.frame.size.height);
    labelPingjia.frame = CGRectMake(labelPingjia.frame.origin.x,
        labelMiaoshu.frame.origin.y + labelMiaoshu.frame.size.height + padding,
        labelPingjia.frame.size.width, labelPingjia.frame.size.height);
    
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width,
                                        labelPingjia.frame.origin.y + labelPingjia.frame.size.height + 80);
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

@end
