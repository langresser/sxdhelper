//
//  UIDevice_AMAdditions.m
//  TimeDisc
//
//  Created by Andreas on 26.03.10.
//  Copyright 2010 Andreas Mayer. All rights reserved.
//

#import "UIDevice_AMAdditions.h"


@implementation UIDevice (AMAdditions)

- (BOOL)isPad
{
	BOOL result = NO;
	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
		result = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
#endif
	}
	return result;
}


@end
