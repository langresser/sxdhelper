//
//  File: AdMoGoAdapterWooboo.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//Wooboo v2.1

#import "AdMoGoAdNetworkAdapter.h"
#import "CommonADColor.h"

@interface AdMoGoAdapterWooboo : AdMoGoAdNetworkAdapter <CommonADColorCtrlDelegate,ADCommonListenerDelegate> {
	
}
+ (AdMoGoAdNetworkType)networkType;
@end
