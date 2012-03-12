//
//  SOMAAd.h
//  SOMASDK
//
//  Created by Jocelyn Harrington on 2/17/11.
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
	kSOMAAllBanner,     ///Banner size is 320x50
	kSOMAImageBanner,   ///Banner size is 320x50
	kSOMATextBanner,    ///Banner size is 320x50
	kSOMAMedRect,		///Banner size is 300x250
	kSOMAFormatLeader,  ///Banner size is 728x90
    kSOMAFormatVideo,   ///Banner is video
	kSOMAFormatSky,      ///Banner size is 120x600
    kSOMAFormatRichMedia
} SOMABannerType;
@interface SOMAAd : NSObject {
	SOMABannerType bannerType;
	NSString *requestURL;
	NSString *bannerText;
	NSString *imageURL;
    NSString *videoURL;
	NSString *targetURL;
	int pubId;
	int adsId;
	BOOL downloadError;
}

@property int pubId;
@property int adsId;
@property BOOL downloadError;
@property (retain) NSString *bannerText;
@property (retain) NSString *imageURL;
@property (retain) NSString *videoURL;
@property (retain) NSString *targetURL;
@property SOMABannerType bannerType;
@property (readonly) NSString *requestURL;

-(CGSize)getSOMAAdFrame;
@end
