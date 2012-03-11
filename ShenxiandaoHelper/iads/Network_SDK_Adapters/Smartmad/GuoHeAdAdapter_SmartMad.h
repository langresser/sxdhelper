//
//  GuoHeAdAdapter_SmartMad.h
//  GuoHeProiOSDev
//
//  Created by Wulin on 10/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "SmartMadAdView.h"
#import "SmartMadDelegate.h"
#import "SmartMadAdView.h"

@interface GuoHeAdAdapter_SmartMad : GHBaseAdapter <SmartMadAdViewDelegate,SmartMadAdEventDelegate, UIGestureRecognizerDelegate>{
    SmartMadAdView *_adBannerView;
    NSString *keyInfoStr;
    CGSize adviewSize;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic,retain) NSString *keyInfoStr;
@property (nonatomic, assign) CGSize adviewSize;
@property (nonatomic,retain) SmartMadAdView *adBannerView;

@end
