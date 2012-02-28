//
//  EquipmentViewController.m
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EquipmentViewController.h"
#import "EquipItemTableViewCell.h"
#import "JSONKit.h"

enum {
    kItemTypeEquipment,     // 装备
    kItemTypeDrug,          // 丹药
    kItemTypeMaterial,      // 材料
};
@interface ItemData : NSObject {
    NSString* itemName;
    NSString* image;
    NSString* exData;      // 装备物品此处存放的是职业信息，材料物品此处存放的是掉落地点
    int type;
    int level;          // 装备和材料物品有用
    NSDictionary* relateItem;    // 对装备和丹药而言存放的是制作所需材料，对材料而言存放的是可制作的装备或丹药
}

@property(nonatomic, retain) NSString* itemName;
@property(nonatomic, retain) NSString* image;
@property(nonatomic, retain) NSString* exData;
@property(nonatomic) int type;
@property(nonatomic) int level;
@property(nonatomic, retain) NSDictionary* relateItem;

-(ItemData*)initWithName:(NSString*)name;
-(void)print;
@end

@implementation ItemData
@synthesize itemName, image, exData, type, level, relateItem;

-(ItemData*)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.itemName = name;
    }
    
    return self;
}

-(void)print
{
#ifdef DEBUG
    NSLog(@"name:%@  data:%@  type:%d   level:%d   items:%@", itemName, exData, type, level, relateItem);
#endif
}
@end

@implementation EquipmentViewController

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
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"item" ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSDictionary* itemData = [jsonString objectFromJSONString];
    
    NSEnumerator* iter = [itemData keyEnumerator];
    NSString* title = nil;
    while (title = [iter nextObject]) {
        ItemData* idata = [[ItemData alloc]initWithName:title];
        if (idata) {
            NSDictionary* dict = [itemData objectForKey:title];
            NSString* type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"equipment"]) {
                idata.type = kItemTypeEquipment;
            } else if ([type isEqualToString:@"material"]) {
                idata.type = kItemTypeMaterial;
            } else if ([type isEqualToString:@"drug"]) {
                idata.type = kItemTypeDrug;
            }

            idata.image = [dict objectForKey:@"image"];
            idata.exData = [dict objectForKey:@"data"];
            NSString* level = [dict objectForKey:@"level"];
            idata.level = [level intValue];
            idata.relateItem = [dict objectForKey:@"items"];
            
//            [idata print];
        }
        
        [allItems_ addObject:idata];
    }
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString* text = textField.text;
    
//    [currentSearchData_ removeAllObjects];
//    
//    if ([text length] <= 0) {
//        [currentSearchData_ addObjectsFromArray:allFaqData_];
//    } else {
//        for (FAQData* each in allFaqData_) {
//            if ([each.question rangeOfString:text].location != NSNotFound) {
//                [currentSearchData_ addObject:each];
//            }
//        }
//    }
    
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    EquipItemTableViewCell *cell = (EquipItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EquipItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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

@end
