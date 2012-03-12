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

#import "AppDelegate.h"
#import "ViewController.h"

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
    NSString* nameColor;     // 名字的显示颜色
    NSMutableArray* relateItem;    // 对装备和丹药而言存放的是制作所需材料，对材料而言存放的是可制作的装备或丹药
}

@property(nonatomic, strong) NSString* itemName;
@property(nonatomic, strong) NSString* image;
@property(nonatomic, strong) NSString* exData;
@property(nonatomic) int type;
@property(nonatomic) int level;
@property(nonatomic, strong) NSString* nameColor;
@property(nonatomic, strong) NSMutableArray* relateItem;

-(ItemData*)initWithName:(NSString*)name;
-(void)print;
@end

@implementation ItemData
@synthesize itemName, image, exData, type, level, relateItem, nameColor;

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
@synthesize tableView_, btnMaterial, btnDrug, btnEquip, labelDrug, labelEquip, labelMaterial;
@synthesize searchText, allItems_, equipments_, drugs_, materials_, fontStyles, currentType;

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
-(void)loadFromFile:(NSString*)fileName
{
    NSError* error = nil;
    NSString* filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray* itemData = [jsonString objectFromJSONString];

    for (NSDictionary* each in itemData) {
        ItemData* idata = [[ItemData alloc]initWithName:[each objectForKey:@"name"]];
        if (idata) {
            NSString* type = [each objectForKey:@"type"];
            if ([type isEqualToString:@"equipment"]) {
                idata.type = kItemTypeEquipment;
                NSString* level = [each objectForKey:@"level"];
                idata.level = [level intValue];
                idata.exData = [each objectForKey:@"data"];
                
            } else if ([type isEqualToString:@"material"]) {
                idata.type = kItemTypeMaterial;
                idata.exData = [each objectForKey:@"data"];
                idata.relateItem = [[NSMutableArray alloc]init];
            } else if ([type isEqualToString:@"drug"]) {
                idata.type = kItemTypeDrug;
                NSString* level = [each objectForKey:@"level"];
                idata.level = [level intValue];
            }
            
            idata.image = [each objectForKey:@"image"];
            
            if (idata.type == kItemTypeEquipment || idata.type == kItemTypeDrug) {
                idata.nameColor = [each objectForKey:@"color"];
                idata.relateItem = [each objectForKey:@"items"];

                if (idata.relateItem) {
                    for (NSString* each in idata.relateItem) {
                        if (![each respondsToSelector:@selector(isEqualToString:)]) {
                            continue;
                        }

                        for (ItemData* itemData in allItems_) {
                            if (itemData.type == kItemTypeMaterial
                                && [each isEqualToString:itemData.itemName]) {
//                                if ([itemData.itemName isEqualToString:@"紫幽羽"]) {
//                                    NSLog(@"%@    %@   %d", itemData.itemName, idata.itemName, [itemData.relateItem count]);
//                                }
                                [itemData.relateItem addObject:idata.itemName];
                            }
                        }
                    }
                }
            }
        }
        
        [allItems_ addObject:idata];
        
        switch (idata.type) {
            case kItemTypeMaterial:
                [materials_ addObject:idata];
                break;
            case kItemTypeEquipment:
                [equipments_ addObject:idata];
                break;
            case kItemTypeDrug:
                [drugs_ addObject:idata];
                break;
            default:
                break;
        }
    }
}

-(void)checkImage
{
    for (ItemData* each in allItems_) {
        UIImage* image = [UIImage imageNamed:each.image];
        if (!image) {
            NSLog(@"%@ for %@ not found!!!!", each.image, each.itemName);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    allItems_ = [[NSMutableArray alloc]init];
    equipments_ = [[NSMutableArray alloc]init];
    drugs_ = [[NSMutableArray alloc]init];
    materials_ = [[NSMutableArray alloc]init];

    // 先加载材料，后面加载装备和丹药时会修正材料的关联物品数据
    [self loadFromFile:@"material"];

    [self loadFromFile:@"drug"];
    [self loadFromFile:@"equip"];

    [self selectType:kItemTypeMaterial];
    [self updateLabelTitle];
    
    fontStyles = [self coreTextStyle];
#ifdef DEBUG
//    [self checkData];
#endif
}

-(void)checkData
{
    for (ItemData* each in allItems_) {
        bool checkOk = NO;
        // 遍历每一个物品的所有相关物品，注意有的物品如降魔弓是没有关联物品的
        if (!each.relateItem || [each.relateItem count] == 0) {
            continue;
        }

        for (NSString* eachItem in each.relateItem) {
            // 这个是NSNumber，不用查询
            if (![eachItem respondsToSelector:@selector(isEqualToString:)]) {
                continue;
            }

            for (ItemData* findItem in allItems_) {
                // 先找到这个相关物品的数据
                if ([eachItem isEqualToString:findItem.itemName]) {
                    // 遍历找到的这个物品的相关物品，看看是否有要校验的物品，如果有则正常，否则可能不正常，打印出物品名称以便确认
                    if (!findItem.relateItem || [findItem.relateItem count] == 0) {
                        continue;
                    }

                    for (NSString* findItemRelate in findItem.relateItem) {
                        if (![findItemRelate respondsToSelector:@selector(isEqualToString:)]) {
                            continue;
                        }

                        if ([findItemRelate isEqualToString:each.itemName]) {
                            checkOk = YES;
                        }
                    }
                }
            }
        }
        
        if (!checkOk) {
            NSLog(@"error:   %@", each.itemName);
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView_ = nil;
    self.btnEquip = nil;
    self.btnMaterial = nil;
    self.btnDrug = nil;
    self.labelMaterial = nil;
    self.labelEquip = nil;
    self.labelDrug = nil;
    self.searchText = nil;
    self.allItems_ = nil;
    self.equipments_ = nil;
    self.materials_ = nil;
    self.drugs_ = nil;
    self.fontStyles = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

-(void)search:(NSString *)text
{
    [materials_ removeAllObjects];
    [drugs_ removeAllObjects];
    [equipments_ removeAllObjects];
    
    for (ItemData* each in allItems_) {
        if ([each.itemName rangeOfString:text].location != NSNotFound) {
            switch (each.type) {
                case kItemTypeMaterial:
                    [materials_ addObject:each];
                    break;
                case kItemTypeEquipment:
                    [equipments_ addObject:each];
                    break;
                case kItemTypeDrug:
                    [drugs_ addObject:each];
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString* text = textField.text;
    
    if ([text length] <= 0) {
        [materials_ removeAllObjects];
        [drugs_ removeAllObjects];
        [equipments_ removeAllObjects];
        
        for (ItemData* each in allItems_) {
            switch (each.type) {
                case kItemTypeMaterial:
                    [materials_ addObject:each];
                    break;
                case kItemTypeEquipment:
                    [equipments_ addObject:each];
                    break;
                case kItemTypeDrug:
                    [drugs_ addObject:each];
                    break;
                default:
                    break;
            }
        }
    } else {
        [self search:text];
    }
    
    if ([materials_ count] > 0) {
        [self selectType:kItemTypeMaterial];
    } else if ([equipments_ count] > 0) {
        [self selectType:kItemTypeEquipment];
    } else if ([drugs_ count] > 0) {
        [self selectType:kItemTypeDrug];
    } else {
        // nothing
        [self selectType:kItemTypeMaterial];
    }
    
    [self updateLabelTitle];

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

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    float fontSize = 14;
    float minLineHeight = 20;
    if ([[UIDevice currentDevice]isPad]) {
        fontSize = 22;
        minLineHeight = 32;
    }
	FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc]init];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
    defaultStyle.underlined = NO;
    defaultStyle.minLineHeight = minLineHeight;
	[result addObject:defaultStyle];
    
    FTCoreTextStyle* linkStyle = [defaultStyle copy];
    linkStyle.name = FTCoreTextTagLink;
    linkStyle.font = [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];//STHeitiSC-Medium
    linkStyle.textAlignment = FTCoreTextAlignementJustified;
    linkStyle.underlined = YES;
    linkStyle.color = [UIColor blueColor];
    linkStyle.minLineHeight = minLineHeight;
    [result addObject:linkStyle];
    
    return  result;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (currentType) {
        case kItemTypeDrug:
            return [drugs_ count];
            break;
        case kItemTypeEquipment:
            return [equipments_ count];
            break;
        case kItemTypeMaterial:
            return [materials_ count];
            break;
        default:
            break;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    EquipItemTableViewCell *cell = (EquipItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EquipItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.relateItems.delegate = self;
        [cell.relateItems addStyles:fontStyles];
    }
    
    ItemData* idata = nil;
    
    switch (currentType) {
        case kItemTypeMaterial:
            idata = [materials_ objectAtIndex:indexPath.row];
            break;
        case kItemTypeEquipment:
            idata = [equipments_ objectAtIndex:indexPath.row];
            break;
        case kItemTypeDrug:
            idata = [drugs_ objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    if (idata) {
        cell.image.image = [UIImage imageNamed:idata.image];
        cell.itemName.text = idata.itemName;
        if (!idata.nameColor || [idata.nameColor length] <= 0) {
            cell.itemName.textColor = [UIColor blackColor];
        } else {
            if ([idata.nameColor isEqualToString:@"purple"]) {
                cell.itemName.textColor = [UIColor purpleColor];
            } else if ([idata.nameColor isEqualToString:@"blue"]) {
                cell.itemName.textColor = [UIColor colorWithRed:0.03 green:0.48 blue:0.86 alpha:1];
            } else if ([idata.nameColor isEqualToString:@"green"]) {
                cell.itemName.textColor = [UIColor colorWithRed:0.15 green:0.55 blue:0.35 alpha:1];
            }
        }
        
        switch (idata.type) {
            case kItemTypeEquipment:
                cell.exData.text = [NSString stringWithFormat:@"职业:%@\t\t使用等级:%d", idata.exData, idata.level];
                break;
            case kItemTypeMaterial:
                cell.exData.text = [NSString stringWithFormat:@"掉落地点: %@", idata.exData];
                break;
            case kItemTypeDrug:
                cell.exData.text = [NSString stringWithFormat:@"使用等级: %d", idata.level];
                break;
            default:
                break;
        }

        if (!idata.relateItem || [idata.relateItem count] <= 0) {
            if (idata.type == kItemTypeEquipment || idata.type == kItemTypeDrug) {
                cell.relateItems.text = @"所需材料:  无";
            } else {
                cell.relateItems.text = @"可制作物品:  无";
            }
        } else {
            if (idata.type == kItemTypeEquipment || idata.type == kItemTypeDrug) {
                NSString* text = @"<_default>所需材料: </_default>";
                int amount = [idata.relateItem count];
                NSString* name;
                NSNumber* number;
                for (int i = 0; i < amount; ++i) {
                    if (i % 2 == 0) {
                        name = [idata.relateItem objectAtIndex:i];
                    } else {
                        number = [idata.relateItem objectAtIndex:i];
                        text = [text stringByAppendingFormat:@"<_link>%@</_link>x%@    ", name, number];
                    }
                }
                
                cell.relateItems.text = text;//[NSString stringWithFormat:@"<_link>%@</_link>", text];
            } else {
                NSString* text = @"<_default>可制作物品: </_default>";
                int amount = [idata.relateItem count];
                for (int i = 0; i < amount; ++i) {
                    text = [text stringByAppendingFormat:@"<_link>%@</_link>   ", [idata.relateItem objectAtIndex:i]];
                }
                
                cell.relateItems.text = text;
//                NSLog(@"%@     %@", idata.itemName, text);
            }
        }
       
    }
    
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
}

-(IBAction)onClickMaterial:(id)sender
{
    if (currentType == kItemTypeMaterial) {
        return;
    }

    [self selectType:kItemTypeMaterial];
}

-(IBAction)onClickEquipment:(id)sender
{
    if (currentType == kItemTypeEquipment) {
        return;
    }

    [self selectType:kItemTypeEquipment];
}

-(IBAction)onClickDrug:(id)sender
{
    if (currentType == kItemTypeDrug) {
        return;
    }

    [self selectType:kItemTypeDrug];
}

-(void)selectType:(int)type
{
    switch (type) {
        case kItemTypeMaterial:
            currentType = kItemTypeMaterial;
            btnDrug.selected = NO;
            labelDrug.textColor = [UIColor blackColor];
            btnEquip.selected = NO;
            labelEquip.textColor = [UIColor blackColor];
            btnMaterial.selected = YES;
            labelMaterial.textColor = [UIColor yellowColor];
            break;
        case kItemTypeEquipment:
            currentType = kItemTypeEquipment;
            btnDrug.selected = NO;
            labelDrug.textColor = [UIColor blackColor];
            btnEquip.selected = YES;
            labelEquip.textColor = [UIColor yellowColor];
            btnMaterial.selected = NO;
            labelMaterial.textColor = [UIColor blackColor];
            break;
        case kItemTypeDrug:
            currentType = kItemTypeDrug;
            btnDrug.selected = YES;
            labelDrug.textColor = [UIColor yellowColor];
            btnEquip.selected = NO;
            labelEquip.textColor = [UIColor blackColor];
            btnMaterial.selected = NO;
            labelMaterial.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    
    [tableView_ reloadData];

    NSInteger count = [tableView_ numberOfRowsInSection:0];
    if (count > 0) {
        [tableView_ scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

    tableView_.alpha = 0.2;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    tableView_.alpha = 1;
    [UIView commitAnimations];
}

-(void)updateLabelTitle
{
    labelMaterial.text = [NSString stringWithFormat:@"材料(%d)", [materials_ count]];
    labelEquip.text = [NSString stringWithFormat:@"装备(%d)", [equipments_ count]];
    labelDrug.text = [NSString stringWithFormat:@"丹药(%d)", [drugs_ count]];
}


-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)coreTextView:(FTCoreTextView *)coreTextView receivedTouchOnData:(NSDictionary *)data
{
    NSString* text = [data objectForKey:FTCoreTextDataURL];
    
    // 点选到空白的地方了，直接返回
    if (!text) {
        return;
    }
    
    [self search:text];

    if ([materials_ count] > 0) {
        [self selectType:kItemTypeMaterial];
    } else if ([equipments_ count] > 0) {
        [self selectType:kItemTypeEquipment];
    } else if ([drugs_ count] > 0) {
        [self selectType:kItemTypeDrug];
    } else {
        // nothing
        [self selectType:kItemTypeMaterial];
    }

    searchText.text = text;
    [self updateLabelTitle];

    tableView_.alpha = 0;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    tableView_.alpha = 1;
    [UIView commitAnimations];
}

#pragma mark for ads
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    ViewController* rootVC = appDelegate.viewController;
    
    if ([rootVC.adView superview]) {
        [rootVC.adView removeFromSuperview];
    }
    [self.view addSubview:rootVC.adView];
}
@end
