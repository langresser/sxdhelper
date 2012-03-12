//
//  SOMADebugXMLResponse.h
//  SomaLib
//
//  
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface SOMADebugXMLResponse : UIViewController {
	UITextView *myTextView;
	NSString *myText;
}
@property (nonatomic, retain) UITextView *myTextView;
@property (nonatomic, retain) NSString *myText;
@end
