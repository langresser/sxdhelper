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

@implementation GameTutorialDetailViewController
@synthesize text, titleString, subTitleString;

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];

    float fontSize = 14;
    if ([[UIDevice currentDevice]isPad]) {
        fontSize = 20;
    }

	FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc]init];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
    
	defaultStyle.font = [UIFont systemFontOfSize:fontSize];
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
	
	FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
	subtitleStyle.font = [UIFont italicSystemFontOfSize:fontSize];
    subtitleStyle.textAlignment = FTCoreTextAlignementCenter;
    subtitleStyle.color = [UIColor lightGrayColor];
	[result addObject:subtitleStyle];
	
	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
	bulletStyle.name = FTCoreTextTagBullet;
	bulletStyle.bulletFont = [UIFont systemFontOfSize:fontSize];
	bulletStyle.bulletColor = [UIColor orangeColor];
	bulletStyle.bulletCharacter = @"❧";
	[result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont systemFontOfSize:fontSize];
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
    blueColor.font = [UIFont systemFontOfSize:fontSize];
	[result addObject:blueColor];
    
    FTCoreTextStyle *purpleColor = [defaultStyle copy];
    [purpleColor setName:@"purplecolor"];
    [purpleColor setColor:[UIColor purpleColor]];
    purpleColor.font = [UIFont systemFontOfSize:fontSize];
	[result addObject:purpleColor];
    
    return  result;
}

- (void)coreTextView:(FTCoreTextView *)coreTextView receivedTouchOnData:(NSDictionary *)data {
    NSString *urlString = [data objectForKey:FTCoreTextDataURL];
    if (!urlString) {
        return;
    }
//    [[UIApplication sharedApplication] openURL:url];
    webBrowerVC.url = urlString;
    [self presentModalViewController:webBrowerVC animated:YES];
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
    
    webBrowerVC = [[WebBrowserViewController alloc]initWithNibName:@"WebBrowserViewController" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    if ([rootVC.ghAdView1 superview]) {
        [rootVC.ghAdView1 removeFromSuperview];
    }
    
    [self.view addSubview: rootVC.ghAdView1];
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
