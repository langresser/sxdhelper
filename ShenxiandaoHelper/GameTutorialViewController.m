//
//  GameTutorialViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameTutorialViewController.h"
#import "JSONKit.h"
#import "UIDevice_AMAdditions.h"
#import <QuartzCore/QuartzCore.h>

static NSInteger sortByDate(NSDictionary* data1, NSDictionary* data2, void* content)
{
    NSArray* array1 = [[data1 objectForKey:@"date"] componentsSeparatedByString:@"-"];
    NSArray* array2 = [[data2 objectForKey:@"date"] componentsSeparatedByString:@"-"];
    NSInteger year1 = [[array1 objectAtIndex:0]intValue];
    NSInteger year2 = [[array2 objectAtIndex:0]intValue];
    NSInteger month1 = [[array1 objectAtIndex:1]intValue];
    NSInteger month2 = [[array2 objectAtIndex:1]intValue];
    NSInteger day1 = [[array1 objectAtIndex:2]intValue];
    NSInteger day2 = [[array2 objectAtIndex:2]intValue];

    if (year1 > year2) {
        return NSOrderedAscending;
    } else if (year1 < year2) {
        return NSOrderedDescending;
    }
    
    if (month1 > month2) {
        return NSOrderedAscending;
    } else if (month1 < month2) {
        return  NSOrderedDescending;
    }
    
    if (day1 > day2) {
        return NSOrderedAscending;
    } else if (day1 < day2) {
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

@implementation GameTutorialViewController
@synthesize tableView_, gameTutorial_, currentTutorial, detailVC, textField_;

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
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"tutorial" ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    NSArray* data = [jsonString objectFromJSONString];
    gameTutorial_ = [[NSMutableArray alloc]initWithArray:data];
//    [gameTutorial_ sortUsingFunction:sortByDate context:nil];
    
    currentTutorial = [[NSMutableArray alloc]initWithArray:gameTutorial_];
    
    detailVC = [[GameTutorialDetailViewController alloc]initWithNibName:@"GameTutorialDetailViewController" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView_ = nil;
    self.detailVC = nil;
    self.currentTutorial = nil;
    self.gameTutorial_ = nil;
    self.textField_ = nil;
}

-(IBAction)onClickSearch:(id)sender
{
    if (![textField_ isFirstResponder]) {
        textField_.text = @"";
        [textField_ becomeFirstResponder];
    }
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
    
    [currentTutorial removeAllObjects];

    if ([text length] <= 0) {
        [currentTutorial addObjectsFromArray:gameTutorial_];
    } else {
        for (NSDictionary* dict in gameTutorial_) {
            NSString* title = [dict objectForKey:@"title"];
            if ([title rangeOfString:text].location != NSNotFound) {
                [currentTutorial addObject:dict];
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
    return [currentTutorial count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        float kLabelWidth = 290;
        float fontSize = 15;
        float leftPadding = 5;
        if ([[UIDevice currentDevice]isPad]) {
            kLabelWidth = 705;
            fontSize = 20;
            leftPadding = 10;
        }
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding, 5, kLabelWidth, 40)];
        title.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:fontSize];
        title.tag = 100;
        
        UILabel* detail = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding, 40, kLabelWidth, 20)];
        detail.numberOfLines = 1;
        detail.font = [UIFont systemFontOfSize:fontSize - 2];
        detail.textColor = [UIColor lightGrayColor];
        detail.textAlignment = UITextAlignmentRight;
        detail.tag = 101;

        [cell.contentView addSubview:title];
        [cell.contentView addSubview:detail];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        //为视图增加边框
        cell.contentView.layer.masksToBounds=YES;
        cell.contentView.layer.cornerRadius=10.0;
        cell.contentView.layer.borderWidth=1.5;
        cell.contentView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    }

    if (indexPath.row >= [currentTutorial count]) {
        return cell;
    }

    NSDictionary* dict = [currentTutorial objectAtIndex:indexPath.row];
    UILabel* title = (UILabel*)[cell.contentView viewWithTag:100];
    UILabel* detail = (UILabel*)[cell.contentView viewWithTag:101];
    title.text = [dict objectForKey:@"title"];
    detail.text = [NSString stringWithFormat:@"%@      %@", [dict objectForKey:@"author"], [dict objectForKey:@"date"]];

    title.backgroundColor = [UIColor clearColor];
    detail.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
    NSDictionary* dict = [currentTutorial objectAtIndex:indexPath.row];
    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle]pathForResource:[dict objectForKey:@"text"] ofType:@"txt"];
    NSString* data = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

//    NSString* text = [NSString stringWithFormat:@"<title>%@</title>\n<subtitle>%@    %@</subtitle>\n原始地址:<_link>%@</_link>\n%@", [dict objectForKey:@"title"], [dict objectForKey:@"author"], [dict objectForKey:@"date"], [dict objectForKey:@"link"], data];
    NSString* text = [NSString stringWithFormat:@"原始地址:<_link>%@</_link>\n\n%@", [dict objectForKey:@"link"], data];
    detailVC.text = text;
    detailVC.titleString = [dict objectForKey:@"title"];
    detailVC.subTitleString = [NSString stringWithFormat:@"%@  %@", [dict objectForKey:@"author"], [dict objectForKey:@"date"]];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
