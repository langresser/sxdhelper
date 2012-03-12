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
@synthesize isPlayingMusic, btnSound, player;
@synthesize gameTutorialVC, friendsVC, findAnswerVC, equipmentVC, adView;

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
    
    self.adView = [AdMoGoView requestAdMoGoViewWithDelegate:self AndAdType:AdViewTypeNormalBanner
                                                ExpressMode:NO];
    [adView setFrame:CGRectMake(0, self.view.bounds.size.height, 0, 0)];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    player = nil;
    self.btnSound = nil;
    
    self.gameTutorialVC = nil;
    self.findAnswerVC = nil;
    self.friendsVC = nil;
    self.equipmentVC = nil;
    
    self.adView = nil;
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
    @autoreleasepool {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"bgmusic" ofType:@"mp3"];
        NSURL *soundURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL: soundURL error: nil];
        [player prepareToPlay];
        player.numberOfLoops = 999999;
        
        [player play];
    }
}

-(void)stopPlay
{
    if (player) {
        [player stop];
    }
}

#pragma mark for ads
- (NSString *)adMoGoApplicationKey {
	return @"321d8211a8e1423d9e75961189a3929d"; // my
//    return @"bb0bf739cd8f4bbabb74bbaa9d2768bf"; // test
    //此字符串为您的App在芒果上的唯一标识
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;//返回的对象为adView的父视图控制器
}

- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView {
	//广告成功展示时调用
    [UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.7];
	CGSize adSize = [adView actualAdSize];
	CGRect newFrame = adView.frame;
	newFrame.size.height = adSize.height;
	newFrame.size.width = adSize.width;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/2;
    newFrame.origin.y = self.view.bounds.size.height - adSize.height;
	adView.frame = newFrame;
    
	[UIView commitAnimations];
}

- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView 
                     usingBackup:(BOOL)yesOrNo {
    //请求广告失败
}

- (void)adMoGoWillPresentFullScreenModal {
    //点击广告后打开内置浏览器时调用
}

- (void)adMoGoDidDismissFullScreenModal {
    //关闭广告内置浏览器时调用 
}
@end
