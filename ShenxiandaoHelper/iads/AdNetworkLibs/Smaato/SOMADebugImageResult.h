//
//  SOMADebugImageResult.h
//  SomaLib
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <UIKit/UIKit.h>


@interface SOMADebugImageResult : UIViewController <UIWebViewDelegate> {
	UIWebView *myImageView;
	NSString *myImageLink;
	NSString *myTargetLink;
	UITextView *myTextView;
	NSMutableString *myText;
}
@property (nonatomic, retain) NSString *myImageLink;
@property (nonatomic, retain) NSString *myTargetLink;
@property (nonatomic, retain) NSMutableString *myText;

@end
