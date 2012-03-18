//
//  FindAnswerViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FindAnswerViewController.h"
#import "JSONKit.h"
#import "FAQTableViewCell.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation FindAnswerViewController
@synthesize currentSearchData_, allFaqData_, tableView_;

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

    @autoreleasepool {
        NSString* filePath = [[NSBundle mainBundle]pathForResource:@"xianlvqiyuan" ofType:@"json"];
        NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        allFaqData_  = [jsonString objectFromJSONString];
        currentSearchData_ = [[NSMutableArray alloc]initWithArray:allFaqData_];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.allFaqData_ = nil;
    self.currentSearchData_ = nil;
    self.tableView_ = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString* text = textField.text;
    
    [currentSearchData_ removeAllObjects];

    if ([text length] <= 0) {
        [currentSearchData_ addObjectsFromArray:allFaqData_];
    } else {
        for (NSDictionary* each in allFaqData_) {
            NSString* question = [each objectForKey:@"question"];
            if ([question rangeOfString:text].location != NSNotFound) {
                [currentSearchData_ addObject:each];
            }
        }
    }
    
    [tableView_ reloadData];

    NSInteger count = [tableView_ numberOfRowsInSection:0];
    if (count > 0) {
        [tableView_ scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    tableView_.alpha = 0;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    tableView_.alpha = 1;
    [UIView commitAnimations];
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
    return [currentSearchData_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FAQTableViewCell *cell = (FAQTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FAQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSDictionary* faqd = [currentSearchData_ objectAtIndex:indexPath.row];
    if (faqd) {
        cell.question.text = [faqd objectForKey:@"question"];
        cell.answer1.text = [NSString stringWithFormat:@"选择1:%@", [faqd objectForKey:@"answer1"]];
        cell.price1.text = [NSString stringWithFormat:@"奖励:%@", [faqd objectForKey:@"price1"]];
        cell.answer2.text = [NSString stringWithFormat:@"选择2:%@", [faqd objectForKey:@"answer2"]];
        cell.price2.text = [NSString stringWithFormat:@"奖励:%@", [faqd objectForKey:@"price2"]];
    }

    faqd = nil;

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
