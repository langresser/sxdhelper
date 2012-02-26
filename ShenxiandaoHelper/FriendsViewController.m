//
//  FriendsViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"

@implementation FriendsViewController
@synthesize gridView;

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

    gridView = [[AQGridView alloc] initWithFrame: CGRectMake(10, 100, 300, 300)];
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    gridView.backgroundColor = [UIColor clearColor];
    gridView.opaque = NO;
    gridView.dataSource = self;
    gridView.delegate = self;
    //    gridView.scrollEnabled = YES;
    gridView.scrollEnabled = NO;
    [self.view addSubview:gridView];
    
    [gridView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark gridview
- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    return ( 20 );
}

- (AQGridViewCell *) gridView: (AQGridView *) agridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    AQGridViewCell * cell = (AQGridViewCell *)[agridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        // 这里的大小是cell本身的大小，用于显示
        CGRect rect;
        rect.origin.x = 0;  // 因为最终位置会重新进行排版，所以这里的x,y并没有实际用处
        rect.origin.y = 0;
        rect.size.width = 30;
        rect.size.height = 50;
        cell = [[AQGridViewCell alloc] initWithFrame: rect reuseIdentifier: CellIdentifier];
    }
    
    return cell;
}

// 这里的大小是考虑格子之间间隔的大小，用于排版
- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) agridView
{
    CGSize size;
    size.width = agridView.bounds.size.width / 5;
    size.height = 90;
    return size;
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
}

-(IBAction)onClickPro:(id)sender
{
}

-(IBAction)onClickSkill:(id)sender
{
}
@end
