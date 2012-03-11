//
//  GuoHeAdAdapter_MobiSage.m
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 26/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_MobiSage.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_MobiSage
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MobiSageAdView_Start_Show_AD object:_adBannerView];
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [_adBannerView release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        MobiSageManager *adViewManager = [MobiSageManager getInstance];
        [adViewManager setPublisherID:[keyArray objectAtIndex:0]];
        
        int adBannerSize;
        if (adsize.width==320&&adsize.height==50) {
            adBannerSize = Ad_320X40;
        }else if (adsize.width==728&&adsize.height==90) {
            adBannerSize = Ad_748X110;
        }else if (adsize.width==300&&adsize.height==250) {
            adBannerSize = Ad_320X270;
        }else if (adsize.width==468&&adsize.height==60) {
            adBannerSize = Ad_480X40;
        }
        
        MobiSageAdView *mobiSage = [[MobiSageManager getInstance] createMobiSageAdView:adBannerSize]; 
        self.adBannerView = mobiSage;
        [mobiSage release];
        self.adBannerView.frame = CGRectMake (0, 0, 320, 40); 
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAdViewStartShow:) name:MobiSageAdView_Start_Show_AD object:_adBannerView]; 
        
        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [_adBannerView addGestureRecognizer:_nonListenerGR];
        //----------- end

	}
    else{
        GHLogWarn(@"App MobiSage key null..");
    }
}

-(void) onAdViewStartShow:(NSNotification*)notify
{
    [self.adView setAdContentView:[notify object]];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

///ad click gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return  YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return  YES;
}

@end
