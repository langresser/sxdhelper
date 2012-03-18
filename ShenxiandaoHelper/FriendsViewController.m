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
#import "JSONKit.h"

@implementation FriendsViewController
@synthesize scrollView, allPlayers, detailVC, currentPage;
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

    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * PAGE_MAX, scrollView.bounds.size.height);    
    
    detailVC = [[FriendDetailViewController alloc]initWithNibName:@"FriendDetailViewController" bundle:nil];
    
    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"huoban" ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    allPlayers = [jsonString objectFromJSONString];
    for (int i = 0; i < PAGE_MAX; ++i) {
        currentPlayers[i] = [[NSMutableArray alloc]init];
    }
    
    for (NSDictionary* each in allPlayers) {
        NSString* type = [each objectForKey:@"职业"];
        if ([type isEqualToString:@"剑灵"]) {
            [currentPlayers[PAGE_JIANLING] addObject:each];
        } else if ([type isEqualToString:@"将星"]) {
            [currentPlayers[PAGE_JIANGXING] addObject:each];
        } else if ([type isEqualToString:@"武圣"]) {
            [currentPlayers[PAGE_WUSHENG] addObject:each];
        } else if ([type isEqualToString:@"飞羽"]) {
            [currentPlayers[PAGE_FEIYU] addObject:each];
        } else if ([type isEqualToString:@"术士"]) {
            [currentPlayers[PAGE_SHUSHI] addObject:each];
        } else if ([type isEqualToString:@"术士(神秘伙伴)"]) {
            [currentPlayers[PAGE_SHUSHI] addObject:each];
        } else if ([type isEqualToString:@"武圣(神秘伙伴)"]) {
            [currentPlayers[PAGE_WUSHENG] addObject:each];
        }
        
        [currentPlayers[PAGE_ALL] addObject:each];
    }
    
    currentPage = PAGE_ALL;
    [self updateBtn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.allPlayers = nil;
    
    detailVC = nil;
    
    for (int i = 0; i < PAGE_MAX; ++i) {
        currentPlayers[i] = nil;
    }
}


-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateBtn
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
        [self updateBtn];
        [scrollView scrollRectToVisible:[self rectForPage:currentPage] animated:NO];
        
        UITableView* tableView = (UITableView*)[self.view viewWithTag:200 + page];
        if (tableView && [tableView numberOfRowsInSection:0] > 0) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }

        scrollView.alpha = 0.1;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.8];
        scrollView.alpha = 1;
        [UIView commitAnimations];
    }
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
    if (page < 0 || page >= PAGE_MAX) {
        return 0;
    }

    return [currentPlayers[page] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        CGRect rectImage = CGRectMake(2, 10, 56, 56);
        CGRect rectName = CGRectMake(60, 5, 110, 20);
        CGRect rectShengw = CGRectMake(180, 5, 120, 20);
        CGRect rectJueji = CGRectMake(60, 25, 250, 55);
        float fontSize = 14;
        
        if ([[UIDevice currentDevice]isPad]) {
            rectImage = CGRectMake(5, 15, 100, 100);
            rectName = CGRectMake(120, 10, 200, 40);
            rectShengw = CGRectMake(310, 5, 200, 40);
            rectJueji = CGRectMake(120, 50, 585, 90);
            fontSize = 24;
        }
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView* image = [[UIImageView alloc]initWithFrame:rectImage];
        image.backgroundColor = [UIColor clearColor];
        image.tag = 300;
        UILabel* name = [[UILabel alloc]initWithFrame:rectName];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:fontSize];
        name.tag = 301;
        UILabel* shengw = [[UILabel alloc]initWithFrame:rectShengw];
        shengw.backgroundColor = [UIColor clearColor];
        shengw.font = [UIFont systemFontOfSize:fontSize];
        shengw.tag = 302;
        UILabel* jueji = [[UILabel alloc]initWithFrame:rectJueji];
        jueji.backgroundColor = [UIColor clearColor];
        jueji.numberOfLines = 0;
        jueji.font = [UIFont systemFontOfSize:fontSize];
        jueji.tag = 303;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell.contentView addSubview:image];
        [cell.contentView addSubview:name];
        [cell.contentView addSubview:shengw];
        [cell.contentView addSubview:jueji];
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:1.0 green:0.94 blue:0.96 alpha:0.8];

        //为视图增加边框
        image.layer.masksToBounds=YES;
        image.layer.cornerRadius=10.0;
        image.layer.borderWidth=1.5;
        image.layer.borderColor=[[UIColor darkGrayColor] CGColor];

        cell.contentView.layer.masksToBounds=YES;
        cell.contentView.layer.cornerRadius=10.0;
        cell.contentView.layer.borderWidth=1.5;
        cell.contentView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    }
    
    int page = tableView.tag - 200;
    if (page < 0 || page >= PAGE_MAX) {
        return cell;
    }

    UIImageView* image = (UIImageView*)[cell.contentView viewWithTag:300];
    UILabel* name = (UILabel*)[cell.contentView viewWithTag:301];
    UILabel* shengw = (UILabel*)[cell.contentView viewWithTag:302];
    UILabel* jueji = (UILabel*)[cell.contentView viewWithTag:303];
    NSDictionary* data = [currentPlayers[page] objectAtIndex:indexPath.row];
    image.image = [UIImage imageNamed:[data objectForKey:@"image_small"]];
    name.text = [NSString stringWithFormat:@"姓名:%@", [data objectForKey:@"姓名"]];
    shengw.text = [NSString stringWithFormat:@"声望要求:%@", [data objectForKey:@"声望"]];
    jueji.text = [NSString stringWithFormat:@"战法:%@", [data objectForKey:@"战法"]];
    
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentPage < 0 || currentPage >= PAGE_MAX) {
        return;
    }
    
    if (indexPath.row >= [currentPlayers[currentPage] count]) {
        return;
    }

    detailVC.currentPlayer = [currentPlayers[currentPage] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView;
{
    if (ascrollView == scrollView) {
        currentPage = ascrollView.contentOffset.x / ascrollView.bounds.size.width;
        [self updateBtn];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;
    
    if (rootVC.shouldShowAds && rootVC.adView) {
        if ([rootVC.adView superview]) {
            [rootVC.adView removeFromSuperview];
        }
        [self.view addSubview:rootVC.adView];
    }
}
@end
