//
//  File: AdMoGoAdapterJumpTap.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "JTAdWidget.h"

@interface AdMoGoAdapterJumpTap : AdMoGoAdNetworkAdapter <JTAdWidgetDelegate> {
	
}

+ (AdMoGoAdNetworkType)networkType;

@end
