//
//  ViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice_AMAdditions.h"

@implementation ViewController
@synthesize isPlayingMusic, ghAdView1;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    gameTutorialVC = [[GameTutorialViewController alloc]initWithNibName:@"GameTutorialViewController" bundle:nil];
    findAnswerVC = [[FindAnswerViewController alloc]initWithNibName:@"FindAnswerViewController" bundle:nil];
    friendsVC = [[FriendsViewController alloc]initWithNibName:@"FriendsViewController" bundle:nil];
    equipmentVC = [[EquipmentViewController alloc]initWithNibName:@"EquipmentViewController" bundle:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //创建广告位1
//    ghAdView1 = [[GHAdView alloc] initWithAdUnitId:@"d9f49db11f39fca8448d75e9fa995ca8" size:CGSizeMake(320.0, 50.0)];
    ghAdView1 = [[GHAdView alloc] initWithAdUnitId:@"ee942c110277be254c5f15e73a61394b" size:CGSizeMake(320.0, 50.0)];
    //设置委托
    ghAdView1.delegate = self;
//    [ghAdView1 loadAd];

    //设置frame并添加到View中
    ghAdView1.frame = CGRectMake(0.0, self.view.bounds.size.height - 50.0, 320.0, 50.0);

    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        NSString* soundFlag = [standardUserDefaults stringForKey:@"sound"];
        if (soundFlag && [soundFlag isEqualToString:@"NO"]) {
            isPlayingMusic = NO;
        } else {
            isPlayingMusic = YES;
        }
        
        btnSound.selected = !isPlayingMusic;
    } else {
        isPlayingMusic = YES;
        btnSound.selected = NO;
    }
    
    if (isPlayingMusic) {
        [self playSound];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}


-(IBAction)onClickGameTutorial:(id)sender
{
    [self.navigationController pushViewController:gameTutorialVC animated:YES];
}

-(IBAction)onClickFindAnswer:(id)sender
{
    [self.navigationController pushViewController:findAnswerVC animated:YES];
}

-(IBAction)onClickFriends:(id)sender
{
    [self.navigationController pushViewController:friendsVC animated:YES];
}


-(IBAction)onClickEquipment:(id)sender
{
    [self.navigationController pushViewController:equipmentVC animated:YES];
}


-(IBAction)onClickSound:(id)sender
{
    isPlayingMusic = !isPlayingMusic;
    btnSound.selected = !isPlayingMusic;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:isPlayingMusic ? @"YES" : @"NO" forKey:@"sound"];
        [standardUserDefaults synchronize];
    }
    
    if (isPlayingMusic) {
        [self playSound];
    } else {
        [self stopPlay];
    }
}

-(void)playSound
{
    if (player == nil) {
        [self performSelectorInBackground:@selector(loadMusic) withObject:nil];
    } else {
        [player play];
    }
}

-(void)loadMusic
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"bgmusic" ofType:@"mp3"];
    NSURL *soundURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL: soundURL error: nil];
    [player prepareToPlay];
    player.numberOfLoops = 999999;
    
    [player play];
}

-(void)stopPlay
{
    if (player) {
        [player stop];
    }
}

#pragma mark for ads
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

//加载广告失败时调用
- (void)adViewDidFailToLoadAd:(GHAdView *)view
{
#ifdef DEBUG
    static int i = 0;
    NSLog(@"adViewDidFailToLoadAd   %d", i++);
#endif
}

//加载广告成功时调用
- (void)adViewDidLoadAd:(GHAdView *)view
{
#ifdef DEBUG
    static int i = 0;
    NSLog(@"adViewDidLoadAd  %d", i++);
#endif
}

//广告点击出现内容窗口时调用
- (void)willPresentModalViewForAd:(GHAdView *)view
{
}

//广告位的关闭按钮被点击时调用
- (void)didClosedAdView:(GHAdView *)view
{
}
@end
