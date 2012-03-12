//
//  SOMABanner.h
//  SomaLib
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class SOMAAd;
@protocol BannerDelegate;
/* 
 *	A SOMABanner represents a custom data model of Ad Banner response from SOMA server.
 *	SOMABanner handels the XML downloading and parsing. When the Banner download is complete,
 *	delegate will notice SOMABannerView to display the new banner or notice the download error.
 */	 
@interface SOMABanner : NSObject
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
<NSXMLParserDelegate>
#endif
{
	NSMutableArray *beaconURLArray;

	BOOL currentParseString;
	NSMutableString* mParseString;
//    NSString *adType;
    SOMABannerType mAdType;
	BOOL isDownLoading;
	NSURLConnection *mDownloadConnection;
	NSMutableArray *mBeaconConnections;	
	NSMutableData *mAdData;
    NSString *mUserID;
	id delegate;
	SOMAAd *mAd;
}

/* SOMABanner properties */
@property (assign) id<BannerDelegate> delegate;
@property (retain) SOMAAd *mAd;
//@property (readonly) NSString *adTypeFormat;			
@property (readonly) SOMABannerType adType;
@property (nonatomic) SOMABannerType requestType;
@property (nonatomic, retain) NSMutableString* mParseString;

-(SOMABanner*)initWithSOMAAd:(SOMAAd *)ad;
-(void)refresh; 
@end

@protocol BannerDelegate
- (void)bannerDelegateDidFinish:(SOMAAd *)ad;
@end