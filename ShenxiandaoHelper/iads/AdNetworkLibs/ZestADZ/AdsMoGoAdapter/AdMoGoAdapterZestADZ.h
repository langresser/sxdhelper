//
//  File: AdMoGoAdapterZestADZ.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "ZestadzDelegateProtocal.h"

@class ZestadzView;

@interface AdMoGoAdapterZestADZ : AdMoGoAdNetworkAdapter <ZestadzDelegate> {
	
}
+ (AdMoGoAdNetworkType)networkType;
@end
