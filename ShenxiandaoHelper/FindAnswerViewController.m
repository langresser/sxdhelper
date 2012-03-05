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
    NSDictionary* faqData = [jsonString objectFromJSONString];
    
    allFaqData_ = [[NSMutableArray alloc]init];
    
    NSEnumerator* iter = [faqData keyEnumerator];
    NSString* title = nil;
    while (title = [iter nextObject]) {
        FAQData* faqd = [[FAQData alloc]initWithQuestion:title];
        if (faqd) {
            NSArray* data = [faqData objectForKey:title];
            faqd.answer1 = [data objectAtIndex:0];
            faqd.price1 = [data objectAtIndex:1];
            faqd.answer2 = [data objectAtIndex:2];
            faqd.price2 = [data objectAtIndex:3];
        }
        
        [allFaqData_ addObject:faqd];
    }
    
    currentSearchData_ = [[NSMutableArray alloc]initWithArray:allFaqData_];
    
    //创建广告位1
    ghAdView1 = [[GHAdView alloc] initWithAdUnitId:@"b3c61a9d3ca184f19a56b7998e439672" size:CGSizeMake(320.0, 50.0)];
    //设置委托
    ghAdView1.delegate = self;
    
    //请求广告
    [ghAdView1 loadAd];
    //设置frame并添加到View中
    ghAdView1.frame = CGRectMake(0.0, self.view.bounds.size.height - 50.0, 320.0, 50.0);
    [self.view addSubview:ghAdView1];
}

#pragma mark -GHAdViewDelegate required method

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
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
        for (FAQData* each in allFaqData_) {
            if ([each.question rangeOfString:text].location != NSNotFound) {
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
    
    FAQData* faqd = [currentSearchData_ objectAtIndex:indexPath.row];
    if (faqd) {
        cell.question.text = faqd.question;
        cell.answer1.text = [NSString stringWithFormat:@"选择1:%@", faqd.answer1];
        cell.price1.text = [NSString stringWithFormat:@"奖励:%@", faqd.price1];
        cell.answer2.text = [NSString stringWithFormat:@"选择2:%@", faqd.answer2];
        cell.price2.text = [NSString stringWithFormat:@"奖励:%@", faqd.price2];
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

//加载广告失败时调用
- (void)adViewDidFailToLoadAd:(GHAdView *)view
{
}

//加载广告成功时调用
- (void)adViewDidLoadAd:(GHAdView *)view
{
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
