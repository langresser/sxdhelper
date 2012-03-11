//
//  GuoHeAdAdapter_Vpon.h
//  GuoHeProiOSDev
//
//  Created by Wulin on 04/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "VponAdOnView.h"
#import "AdOnDelegate.h"
#import "AdOnPlatform.h"

@interface GuoHeAdAdapter_Vpon : GHBaseAdapter <VponAdOnDelegate,UIGestureRecognizerDelegate> {
    VponAdOnView *_adBannerView;
    NSString *theKey;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic,retain) NSString *theKey;
@property (nonatomic, retain) VponAdOnView *adBannerView;

@end
