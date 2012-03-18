//
//  GameTutorialDetailViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameTutorialDetailViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "SVWebViewController.h"

@implementation GameTutorialDetailViewController
@synthesize text, titleString, subTitleString;
@synthesize coreTextView_, titleLabel, subTitleLabel, scrollView_;
- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];

    float fontSize = 14;
    if ([[UIDevice currentDevice]isPad]) {
        fontSize = 20;
    }

	FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc]init];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
    
	defaultStyle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
	[result addObject:defaultStyle];
	
	FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
	imageStyle.paragraphInset = UIEdgeInsetsMake(0,0,0,0);
	imageStyle.name = FTCoreTextTagImage;
	imageStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:imageStyle];
	
	FTCoreTextStyle *linkStyle = [defaultStyle copy];
	linkStyle.name = FTCoreTextTagLink;
	linkStyle.color = [UIColor blueColor];
	[result addObject:linkStyle];
	
	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
	bulletStyle.name = FTCoreTextTagBullet;
	bulletStyle.bulletFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:fontSize];
	bulletStyle.bulletColor = [UIColor orangeColor];
	bulletStyle.bulletCharacter = @"*";
	[result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont italicSystemFontOfSize:fontSize];
	[result addObject:italicStyle];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
	boldStyle.name = @"bold";
    boldStyle.font = [UIFont boldSystemFontOfSize:fontSize];
	[result addObject:boldStyle];
    
    FTCoreTextStyle *redColor = [defaultStyle copy];
    [redColor setName:@"redcolor"];
    [redColor setColor:[UIColor redColor]];
	[result addObject:redColor];
    
    FTCoreTextStyle *blueColor = [defaultStyle copy];
    [blueColor setName:@"bluecolor"];
    [blueColor setColor:[UIColor blueColor]];
	[result addObject:blueColor];
    
    FTCoreTextStyle *purpleColor = [defaultStyle copy];
    [purpleColor setName:@"purplecolor"];
    [purpleColor setColor:[UIColor purpleColor]];
	[result addObject:purpleColor];
    
    return  result;
}

- (void)coreTextView:(FTCoreTextView *)coreTextView receivedTouchOnData:(NSDictionary *)data {
    NSString *urlString = [data objectForKey:FTCoreTextDataURL];
    if (!urlString) {
        return;
    }

    NSURL *URL = [NSURL URLWithString:urlString];
	SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
	webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
	[self presentModalViewController:webViewController animated:YES];
}


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

    //add coretextview
	scrollView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView_ = [[FTCoreTextView alloc] initWithFrame:CGRectMake(0, 0, scrollView_.bounds.size.width, 0)];
	coreTextView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView_.backgroundColor = [UIColor clearColor];
    coreTextView_.delegate = self;
    scrollView_.backgroundColor = [UIColor clearColor];

    [scrollView_ addSubview:coreTextView_];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.coreTextView_ = nil;
    self.titleLabel = nil;
    self.subTitleLabel = nil;
    self.scrollView_ = nil;
    self.text = nil;
    self.titleString = nil;
    self.subTitleString = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    titleLabel.text = titleString;
    subTitleLabel.text = subTitleString;

    // set styles
    [coreTextView_ setText:text];
    [coreTextView_ addStyles:[self coreTextStyle]];
	[coreTextView_ fitToSuggestedHeight];
    
    [scrollView_ setContentSize:CGSizeMake(CGRectGetWidth(scrollView_.bounds), CGRectGetHeight(coreTextView_.frame) + 40)];
    [scrollView_ setContentOffset:CGPointMake(0, 0)];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;
    
    if (rootVC.shouldShowAds && rootVC.adView) {
        if ([rootVC.adView superview]) {
            [rootVC.adView removeFromSuperview];
        }
        [self.view addSubview:rootVC.adView];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    self.titleString = nil;
    self.subTitleString = nil;
    self.text = nil;
    self.titleLabel.text = nil;
    self.subTitleLabel.text = nil;
    self.coreTextView_.text = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[scrollView_ setContentSize:CGSizeMake(CGRectGetWidth(scrollView_.bounds), CGRectGetHeight(coreTextView_.frame) + 40)];
}

-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
