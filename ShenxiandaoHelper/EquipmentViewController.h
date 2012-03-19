//
//  EquipmentViewController.h
//  ShenxiandaoHelper
//
//  Created by 王 佳 on 12-2-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"

@interface EquipmentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, FTCoreTextViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView* tableView_;
@property(nonatomic, strong) IBOutlet UIButton* btnMaterial;
@property(nonatomic, strong) IBOutlet UIButton* btnEquip;
@property(nonatomic, strong) IBOutlet UIButton* btnDrug;
@property(nonatomic, strong) IBOutlet UILabel* labelMaterial;
@property(nonatomic, strong) IBOutlet UILabel* labelEquip;
@property(nonatomic, strong) IBOutlet UILabel* labelDrug;
@property(nonatomic, strong) IBOutlet UITextField* searchText;
@property(nonatomic, strong) NSMutableArray* allItems_;
@property(nonatomic, strong) NSMutableArray* equipments_;
@property(nonatomic, strong) NSMutableArray* drugs_;
@property(nonatomic, strong) NSMutableArray* materials_;
@property(nonatomic, strong) NSArray* fontStyles;
@property(nonatomic) int currentType;

-(IBAction)onClickMaterial:(id)sender;
-(IBAction)onClickEquipment:(id)sender;
-(IBAction)onClickDrug:(id)sender;
-(IBAction)onClickReturn:(id)sender;
-(IBAction)onClickSearch:(id)sender;

-(void)search:(NSString*)text;
-(void)loadFromFile:(NSString*)fileName;
-(void)selectType:(int)type;
-(void)updateLabelTitle;

-(void)checkData;
- (NSArray *)coreTextStyle;
@end
