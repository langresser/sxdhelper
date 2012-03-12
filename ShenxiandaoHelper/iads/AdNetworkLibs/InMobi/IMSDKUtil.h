/*
 * IMAdError.h
 * @description InMobi SDK Utility class
 * @author: InMobi
 * Copyright 2011 InMobi Technologies Pvt. Ltd.. All rights reserved.
 */

#import <Foundation/Foundation.h>

enum LogLevels {
    /**
     * The default minimal log level.
     */
    IMLogLevelMinimal = 1,
    /**
     * The log level used for debugging purpose.
     */
    IMLogLevelDebug = 2,
    /**
     * The log level used for critical debugging.
     */
    IMLogLevelCritical = 3
};
typedef enum LogLevels LogLevel;

@interface IMSDKUtil : NSObject {
    LogLevel logLevel;
}
/**
 * The LogLevel, for printing console messages
 */
@property (nonatomic, assign) LogLevel logLevel;
/**s
 * @description This method returns the InMobi iOS SDK version.
 * Typically of the format @"2.0.0",@"2.1.3" etc.
 */
- (NSString *)sdkVersion;
/**
 * Returns the singleton instance of this class.
 */
+ (IMSDKUtil *)util;
/**
 * Send the application installed tracker conversion ping to the server. The
 * information will be sent only once and calling multiple times does not
 * have any effect.
 * 
 * @param itunesId Itunes Id of your app, as obtained from Apple.
 * @param advertiserId Advertiser Id.
 */
- (void)startAppTrackerConversion:(NSString *)advertiserId iTunesId:(NSString *)itunesId;

@end
