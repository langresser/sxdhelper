//
//  File: AdMoGoAdapterVponCN.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//Vpon v3.0.4

#import "AdMoGoAdNetworkAdapter.h"
#import "AdOnDelegate.h"
#import "VponAdOnView.h"

@interface AdMoGoAdapterVponCN: AdMoGoAdNetworkAdapter<VponAdOnDelegate>{
	NSTimer *timer;
    VponAdOnView *adOnView;
}

+ (AdMoGoAdNetworkType)networkType;
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
