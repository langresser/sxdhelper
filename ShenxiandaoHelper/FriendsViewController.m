//
//  FriendsViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation FriendsViewController

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
    scrollView.contentSize = CGSizeMake(320 * PAGE_MAX, scrollView.bounds.size.height);
    
    detailVC = [[FriendDetailViewController alloc]initWithNibName:@"FriendDetailViewController" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateBtn:(int)page
{
    for (int i = 0; i < PAGE_MAX; ++i) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:i + 100];
        if (btn) {
            btn.selected = (i == currentPage);
        }
    }
}

-(IBAction)onClickPro:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if (btn) {
        int page = btn.tag - 100;
        currentPage = page;
        [self updateBtn:page];
        [scrollView scrollRectToVisible:[self rectForPage:currentPage] animated:NO];
        
        scrollView.alpha = 0.1;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.8];
        scrollView.alpha = 1;
        [UIView commitAnimations];
    }
}

-(NSString*)getNameByIndex:(int)page
{
    if (page < 0 || page >= PAGE_MAX) {
        return @"";
    }

    switch (page) {
        case PAGE_JIANLING:
            return @"剑灵";
            break;
        case PAGE_JIANGXING:
            return @"将星";
            break;
        case PAGE_WUSHENG:
            return @"武圣";
            break;
        case PAGE_FEIYU:
            return @"飞羽";
            break;
        case PAGE_SHENMIHUOBAN:
            return @"神秘伙伴";
            break;
        case PAGE_SHUSHI:
            return @"术士";
            break;
        default:
            break;
    }
    
    return @"";
}

-(CGRect)rectForPage:(int)page
{
    CGRect rect = scrollView.bounds;
    rect.origin.x = rect.size.width * page;
    rect.origin.y = 0;
    return rect;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int page = tableView.tag - 200;
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int page = tableView.tag - 200;
    cell.textLabel.text = [self getNameByIndex:page];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView;
{
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;

    if ([rootVC.ghAdView1 superview]) {
        [rootVC.ghAdView1 removeFromSuperview];
    }

    [self.view addSubview: rootVC.ghAdView1];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;
    [rootVC.ghAdView1 removeFromSuperview];
}
@end
