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

@interface FAQData : NSObject
{
    NSString* question;
    NSString* answer1;
    NSString* price1;
    NSString* answer2;
    NSString* price2;
}
@property(nonatomic, retain) NSString* question;
@property(nonatomic, retain) NSString* answer1;
@property(nonatomic, retain) NSString* price1;
@property(nonatomic, retain) NSString* answer2;
@property(nonatomic, retain) NSString* price2;

-(FAQData*)initWithQuestion:(NSString*)quest;
@end

@implementation FAQData
@synthesize question, answer1, price1, answer2, price2;

-(FAQData*)initWithQuestion:(NSString*)quest
{
    self = [super init];
    if (self) {
        self.question = quest;
    }
    return self;
}
@end

@implementation FindAnswerViewController

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

    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"xianlvqiyuan" ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    allFaqData_  = [jsonString objectFromJSONString];
    currentSearchData_ = [[NSMutableArray alloc]initWithArray:allFaqData_];
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
    
    NSInteger count = [tableView_ numberOfRowsInSection:0];
    if (count > 0) {
        [tableView_ scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    [tableView_ reloadData];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kQuestionHeight + kAnswerHeight * 4 + 5;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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

    if ([rootVC.ghAdView1 superview]) {
        [rootVC.ghAdView1 removeFromSuperview];
    }

    [self.view addSubview: rootVC.ghAdView1];
}

@end
