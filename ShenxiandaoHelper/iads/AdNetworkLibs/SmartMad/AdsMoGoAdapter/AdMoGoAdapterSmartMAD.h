//
//  File: AdMoGoAdapterSmartMAD.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//SmartMad v2.0.2

#import "AdMoGoAdNetworkAdapter.h"
#import "SmartMadAdView.h"

@interface AdMoGoAdapterSmartMAD : AdMoGoAdNetworkAdapter <SmartMadAdEventDelegate,SmartMadAdViewDelegate>{
    NSTimer *timer;
    
    UIView *myView;
    SmartMadAdView *adView;
}
- (void)loadAdTimeOut:(NSTimer*)theTimer;
@end
