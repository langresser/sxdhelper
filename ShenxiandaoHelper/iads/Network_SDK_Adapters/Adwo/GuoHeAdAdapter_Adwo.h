//
//  GuoHeAdapter_Adwo.h
//  GuoHeAdDev
//
//  Created by Daniel on 11-6-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "AWAdView.h"

@class AWAdView;
@interface GuoHeAdAdapter_Adwo : GHBaseAdapter <AWAdViewDelegate, UIGestureRecognizerDelegate> {
    AWAdView *_adBannerView;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic, retain) AWAdView *adBannerView;

@end
