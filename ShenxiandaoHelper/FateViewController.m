//
//  FateViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FateViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FateViewController

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
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (true) {
        return 10;
    } else {
        return 0;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton* headerView = [UIButton buttonWithType:UIButtonTypeCustom];
    headerView.frame = CGRectMake(0, 0, tableView_.bounds.size.width, 40);
    headerView.tag = section;
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView addTarget:self action:@selector(didSelectSectionHeader:) forControlEvents:UIControlEventTouchUpInside];
    CALayer *layer = headerView.layer;
    layer.borderWidth = 1.5f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    CGRect titleLabelFrame = headerView.bounds;
    titleLabelFrame.origin.x += 35.0;
    titleLabelFrame.size.width -= 35.0;
    CGRectInset(titleLabelFrame, 0.0, 5.0);
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
    
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [headerView addSubview:titleLabel];
    
    
    UIImageView* image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    [headerView addSubview:image];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SectionMemberCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)didSelectSectionHeader:(id)sender
{
}

-(IBAction)onClickBtn:(id)sender
{
    UIButton* btn = sender;
    switch (btn.tag) {
        case 0: // all
            break;
        case 1: // 金色
            break;
        case 2: // 紫色
            break;
        case 3: // 蓝色
            break;
        case 4: // 绿色
            break;
        default:
            break;
    }
}
@end
