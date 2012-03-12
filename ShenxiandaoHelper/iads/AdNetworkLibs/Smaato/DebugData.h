//
//  DebugData.h
//  SomaLib
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface DebugData : NSObject {
	NSString *bannerType;
	NSString *imageURL;
	NSString *targetURL;
	NSString *requestURL;
	NSString *xmlData;
	NSString *userAgent;
	NSString *otherVars;
	NSString *bannerText;
	int height;
}
@property (nonatomic, retain) NSString *bannerType;
@property (nonatomic, retain) NSString *requestURL;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *targetURL;
@property (nonatomic, retain) NSString *xmlData;
@property (nonatomic, retain) NSString *userAgent;
@property (nonatomic, retain) NSString *otherVars;
@property (nonatomic, retain) NSString *bannerText;
@property int height;
@end
