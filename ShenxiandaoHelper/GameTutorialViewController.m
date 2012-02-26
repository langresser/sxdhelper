//
//  GameTutorialViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameTutorialViewController.h"
#import "JSONKit.h"
#import "TutorialData.h"

static NSInteger sortByDate(TutorialData* data1, TutorialData* data2, void* content)
{
    NSArray* array1 = [data1.date componentsSeparatedByString:@"-"];
    NSArray* array2 = [data2.date componentsSeparatedByString:@"-"];
    NSInteger year1 = [[array1 objectAtIndex:0]intValue];
    NSInteger year2 = [[array2 objectAtIndex:0]intValue];
    NSInteger month1 = [[array1 objectAtIndex:1]intValue];
    NSInteger month2 = [[array2 objectAtIndex:1]intValue];
    NSInteger day1 = [[array1 objectAtIndex:2]intValue];
    NSInteger day2 = [[array2 objectAtIndex:2]intValue];

    if (year1 < year2) {
        return NSOrderedAscending;
    } else if (year1 > year2) {
        return NSOrderedDescending;
    }
    
    if (month1 < month2) {
        return NSOrderedAscending;
    } else if (month1 > month2) {
        return  NSOrderedDescending;
    }
    
    if (day1 < day2) {
        return NSOrderedAscending;
    } else if (day1 > day2) {
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

@implementation GameTutorialViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    gameTutorial_ = [[NSMutableArray alloc]init];

    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"tutorial" ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    NSDictionary* tutorialData = [jsonString objectFromJSONString];
    NSEnumerator* iter = [tutorialData keyEnumerator];
    NSString* title = nil;
    while (title = [iter nextObject]) {
        TutorialData* td = [[TutorialData alloc]initWithTitle:title];
        if (td) {
            NSArray* data = [tutorialData objectForKey:title];
            td.text = [data objectAtIndex:0];
            td.author = [data objectAtIndex:1];
            td.date = [data objectAtIndex:2];
        }

        [gameTutorial_ addObject:td];
    }
    
    [gameTutorial_ sortUsingFunction:sortByDate context:nil];
    
    detailVC = [[GameTutorialDetailViewController alloc]initWithNibName:@"GameTutorialDetailViewController" bundle:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gameTutorial_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    TutorialData* td = [gameTutorial_ objectAtIndex:indexPath.row];
    cell.textLabel.text = td.title;
    
    return cell;
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
    TutorialData* td = [gameTutorial_ objectAtIndex:indexPath.row];
    NSString* text = [NSString stringWithFormat:@"<title>%@</title>\n<_bullet>%@  %@</_bullet>\n%@", td.title, td.author, td.date, td.text];
    detailVC.text = text;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
