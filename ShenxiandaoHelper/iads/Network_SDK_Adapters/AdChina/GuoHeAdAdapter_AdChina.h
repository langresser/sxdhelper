//
//  GuoHeAdAdapter_AdChina.h
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "AdChinaBannerView.h"

@interface GuoHeAdAdapter_AdChina : GHBaseAdapter <AdChinaBannerDelegate, UIGestureRecognizerDelegate> 
{
    AdChinaBannerView *_adBannerView;
    NSString *theKey;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic,retain) NSString *theKey;
@property (nonatomic, retain) AdChinaBannerView *adBannerView;

@end
