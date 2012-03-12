//
//  File: AdMoGoAdapterAirAd.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "airADView.h"

@interface AdMoGoAdapterAirAd : AdMoGoAdNetworkAdapter <airADViewDelegate> {
    NSTimer *timer;
}
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
