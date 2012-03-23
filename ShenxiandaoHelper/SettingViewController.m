//
//  SettingViewController.m
//  ShakeRand
//
//  Created by 王 佳 on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "InAppPurchaseMgr.h"
#import "UIDevice_AMAdditions.h"
#import "UIDevice+IdentifierAddition.h"
#import "UIImageView+WebCache.h"
#import "MobClick.h"

@implementation SettingViewController
@synthesize tableView = tableView_, shouldShowAds, openApps;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView_.layer.cornerRadius = 10.0;
    tableView_.layer.masksToBounds = YES;

    point = [[NSUserDefaults standardUserDefaults]integerForKey:@"Points"];
//    point = 500;

    if (shouldShowAds) {
        openApps = [[NSMutableArray alloc] init];
        wall = [[YouMiWall alloc] initWithAppID:@"2e5d736cae523f35" withAppSecret:@"67fdec5e5dc6bc0a"];
        
        // set delegate
        wall.delegate = self;
        wall.userID = @"wangjiatc@gmail.com";
        
        // 添加应用列表开放源观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestOffersOpenDataSuccess:) name:YOUMI_OFFERS_APP_DATA_RESPONSE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestOffersOpenDataFail:) name:YOUMI_OFFERS_APP_DATA_RESPONSE_NOTIFICATION_ERROR object:nil];
        
#if ENABLE_OFFER_WALL == 1
        // 关于积分查询观察者        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPointSuccess:) name:YOUMI_EARNED_POINTS_RESPONSE_NOTIFICATION object:nil];

        [wall requestOffersAppData:YES pageCount:15];
#else
        [wall requestOffersAppData:NO pageCount:15];
#endif

    } else {
        wall = nil;
        openApps = nil;
    }
    
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    wall.delegate = nil;
    wall = nil;
    openApps = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!shouldShowAds) {
        wall = nil;

        if (openApps) {
            [openApps removeAllObjects];
            [self.tableView reloadData];
        }

        self.openApps = nil;
    } else {
#if ENABLE_OFFER_WALL == 1
        if (wall) {
            // 查询积分
            [wall requestEarnedPoints];
        }
#endif
    }
}

#pragma mark - YouMiWall delegate
// 请求积分墙数据成功
- (void)requestOffersOpenDataSuccess:(NSNotification *)note {
    if (openApps) {
        [openApps removeAllObjects];
        
        NSDictionary *info = [note userInfo];
        NSArray *apps = [info valueForKey:YOUMI_WALL_NOTIFICATION_USER_INFO_OFFERS_APP_KEY];
        [openApps addObjectsFromArray:apps];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)requestOffersOpenDataFail:(NSNotification *)note {
    // do nothing
}

// 请求积分数据成功
- (void)requestPointSuccess:(NSNotification *)note {
    NSDictionary *info = [note userInfo];

#ifdef DEBUG
    NSLog(@"requestPointSuccess: %@", info);
#endif
    NSArray *records = [info valueForKey:YOUMI_WALL_NOTIFICATION_USER_INFO_EARNED_POINTS_KEY];    
    for (NSDictionary *oneRecord in records) {
        NSString *userID = (NSString *)[oneRecord objectForKey:kOneAccountRecordUserIDOpenKey];
        NSString *name = (NSString *)[oneRecord objectForKey:kOneAccountRecordNameOpenKey];
        NSInteger earnedPoint = [(NSNumber *)[oneRecord objectForKey:kOneAccountRecordPoinstsOpenKey] integerValue];
        
        point += earnedPoint;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 新增积分:%d", userID, earnedPoint] message:[NSString stringWithFormat:@"来源于安装了应用[%@]", name] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        [alert show];
    }
    
    if ([records count] > 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:point forKey:@"Points"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (shouldShowAds && wall && openApps) {
        return 2;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"关于我们";
    } else if (section == 1) {
        return @"推荐应用";
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    } else {
        return 60.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
#if ENABLE_OFFER_WALL == 0
        return 3;
#else
        if (shouldShowAds) {
            return 4;
        } else {
            return 3;
        }
#endif
    } else if (section == 1) {
        return [openApps count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;

    if (indexPath.section == 0) {
        static NSString* cellIdent = @"MyCellSetting";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
            cell.textLabel.font = [UIFont systemFontOfSize:17.0];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"永久去除广告";
                cell.detailTextLabel.text = @"";
                break;
            case 1:
                cell.textLabel.text = @"告诉我们您的意见";
                cell.detailTextLabel.text = @"";
                break;
            case 2:
                cell.textLabel.text =  @"给我们打分";
                cell.detailTextLabel.text = @"";
                break;
#if ENABLE_OFFER_WALL == 1
            case 3:
                cell.textLabel.text = @"消耗200积分去除广告";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"当前积分:%d", point];
                break;
#endif
            default:
                break;
        }
    } else {
        static NSString *CellIdentifier = @"Rewarded Cell Identifier";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.imageView.layer.cornerRadius = 10.0;
            cell.imageView.layer.masksToBounds = YES;

#if ENABLE_OFFER_WALL == 1
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 50, 30)];
            label.tag = 100;
            label.textColor = [UIColor orangeColor];
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
#endif
        }
        
        if (!openApps) {
            return cell;
        }

        // Configure the cell...
        if (indexPath.row >= [openApps count]) return cell;
        
        YouMiWallAppModel *model = [openApps objectAtIndex:indexPath.row];

        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.desc;
//        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.smallIconURL]]];
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.smallIconURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
#if ENABLE_OFFER_WALL == 1
        UILabel* label = (UILabel*)[cell.contentView viewWithTag:100];
        if (label) {
            label.text = [NSString stringWithFormat:@"%d积分", model.points];
        }
#endif
    }
    
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
    switch (indexPath.row) {
        case 0:
            [[InAppPurchaseMgr sharedInstance]purchaseProUpgrade];
            break;
        case 1:
            [MobClick showFeedback:self];
            break;
        case 2:
        {
            // 下载 itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=40461254
            // 评价
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=507891307"]]; 
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=500636172"]]; // 易趣玩点名器
        
        }
            break;
#if ENABLE_OFFER_WALL == 1
        case 3:
        {
            if (point < 200) {
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"您当前积分不足:" message:@"下载并安装下列推荐应用可以免费获取积分。下载两到三个应用就可以去除广告了。感谢您的支持>_<" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"去除广告:" message:@"您是否确认消耗200积分去除广告？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                alert.tag = 200;
                [alert show];
            }
        }
#endif
        default:
            break;
    }
    } else {
        if (wall && openApps) {
            if (indexPath.row >= [openApps count]) return;
            
            YouMiWallAppModel *model = [openApps objectAtIndex:indexPath.row];
            [wall userInstallOffersApp:model];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
#if ENABLE_OFFER_WALL == 1
    if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            // 杀广告
            point -= 200;
            if (point < 0) {
                point = 0;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:[UIDevice currentDevice].uniqueDeviceIdentifier forKey:kRemoveAdsFlag];
            [[NSUserDefaults standardUserDefaults] setInteger:point forKey:@"Points"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kIAPSucceededNotification object:self userInfo:nil];
        }
    }
#endif
}

-(IBAction)onClickReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
