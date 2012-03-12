//
//  MobiSageSDK.h
//  MobiSageSDK
//
//  Created by Ryou Zhang on 10/25/11.
//  Copyright (c) 2011 mobiSage. All rights reserved.
//

#define Track_Server_System_Launching            @"In"                      // 程序启动
#define Track_Server_System_Teminating           @"Out"                     // 程序退出


#pragma Ad_Size_List
#define Ad_480X40                               1   //ipad
#define Ad_320X270                              2   //ipad
#define Ad_748X110                              4   //ipad
#define Ad_256X192                              11  //ipad
#define Ad_748X60                               12  //ipad
#define Ad_120X480                              13  //ipad
#define Ad_210X177                              14  //ipad
#define Ad_48X48                                15  //iphone & ipad
#define Ad_320X40                               16  //iphone


typedef enum SYSTEM_EVENT_ENUM
{
    CustomerEvent         = 0,      //    0 非系统事件，即用户事件
    AppLaunchingEvent     = 1,      //    1 程序启动事件
    AppTerminatingEvent   = 2,      //    2 程序退出事件
}SystemEventEnum;

#define MobiSageAdView_Start_Show_AD    @"MobiSageAdView_Start_Show_AD"
#define MobiSageAdView_Pause_Show_AD    @"MobiSageAdView_Pause_Show_AD"

#define MobiSageAdView_Pop_AD_Window    @"MobiSageAdView_Pop_AD_Window"
#define MobiSageAdView_Hide_AD_Window   @"MobiSageAdView_Hide_AD_Window"

typedef enum
{
    Random      = 1,	//随机动画
    Fade        = 2,	//淡入淡出
    FlipL2R     = 3,	//水平翻转从左到右
    FlipT2B     = 4,	//水平翻转从上到下
    CubeT2B     = 5,	//立方体翻转从上到下
    CubeL2R     = 6,	//立方体翻转从左到右
    Ripple      = 7,	//水波纹效果 (注意：在120x480的广告条上使用水波纹的效果不够理想)
    PageCurl    = 8,	//翻页效果从下到上
    PageUnCurl  = 9,	//翻页效果从上到下
} MobiSageAnimeType;

@class MobiSagePackage;

@interface MobiSageAdView : UIView<UIWebViewDelegate,UIActionSheetDelegate>
{
}
//public
-(void)setSwitchAnimeType:(MobiSageAnimeType)switchAnimeType;
-(void)setKeyword:(NSString*)keyword;
-(void)setCustomData:(NSString*)customData;
@end

@interface MobiSageManager : NSObject
{
}
+(MobiSageManager*)getInstance;

-(void)setPublisherID:(NSString*)publisherID;

-(void)setDeployChannel:(NSString*)deployChannel;

-(MobiSageAdView*)createMobiSageAdView:(NSUInteger)adSize;

-(void)trackSystemEvent:(SystemEventEnum)event; 
-(void)trackSystemEvent:(SystemEventEnum)event WithObject:(NSString*)object; 

-(void)trackCustomerEvent:(NSString*)event WithObject:(NSString*)object; 

-(void)pushMobiSagePackage:(MobiSagePackage*)package;
-(void)pushMobiSagePackageArray:(NSArray *)packageArray;
-(void)cancelMobiSagePackage:(MobiSagePackage*)package;
-(void)cancelMobiSagePackageArray:(NSArray*)packageArray;
@end;

@interface MobiSageBaiduBar : UISearchBar<UISearchBarDelegate>
{
}
@end