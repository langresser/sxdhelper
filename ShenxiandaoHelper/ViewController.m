//
//  ViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize isPlayingMusic;

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
    fateVC = [[FateViewController alloc]initWithNibName:@"FateViewController" bundle:nil];
    equipmentVC = [[EquipmentViewController alloc]initWithNibName:@"EquipmentViewController" bundle:nil];
    toolsVC = [[ToolsViewController alloc]initWithNibName:@"ToolsViewController" bundle:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        NSString* soundFlag = [standardUserDefaults stringForKey:@"sound"];
        if (soundFlag && [soundFlag isEqualToString:@"NO"]) {
            isPlayingMusic = NO;
        } else {
            isPlayingMusic = YES;
        }
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

-(IBAction)onClickFate:(id)sender
{
    [self.navigationController pushViewController:fateVC animated:YES];
}


-(IBAction)onClickEquipment:(id)sender
{
    [self.navigationController pushViewController:equipmentVC animated:YES];
}

-(IBAction)onClickTools:(id)sender
{
    [self.navigationController pushViewController:toolsVC animated:YES];
}

-(IBAction)onClickRemove:(id)sender
{

}

-(IBAction)onClickAbout:(id)sender
{
    
}

-(IBAction)onClickSound:(id)sender
{
    isPlayingMusic = !isPlayingMusic;
    
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
@end
