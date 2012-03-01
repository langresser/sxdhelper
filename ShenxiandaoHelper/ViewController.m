//
//  ViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

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
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
    
}
@end
