//
//  File: AdMoGoAdapterCasee.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "CaseeAdView.h"
#import "CaseeAdDelegate.h"

@interface AdMoGoAdapterCasee : AdMoGoAdNetworkAdapter <CaseeAdDelegate>{
	NSTimer *timer;
    CaseeAdView* caseeView;
}

+ (AdMoGoAdNetworkType)networkType;
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
