//
//  GuoHeAdapter_Adwo.m
//  GuoHeAdDev
//
//  Created by Daniel on 11-6-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Adwo.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Adwo
@synthesize adBannerView = _adBannerView;

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	
	if ([keyArray count]>1) {
        NSString *tempID = [keyArray objectAtIndex:0];
        NSString *strTest = [keyArray objectAtIndex:1];
        NSInteger isTest = 1;
        if ([strTest compare:@"true"]==NSOrderedSame) {
            isTest = 0;
        }
        
        SInt8 adBannerSize;
        if (adsize.width==320&&adsize.height==50) {
            adBannerSize = ADWO_ADS_BANNER_SIZE_FOR_IPAD_320x50;
        }else if (adsize.width==728&&adsize.height==90) {
            adBannerSize = ADWO_ADS_BANNER_SIZE_FOR_IPAD_720x110;
        }else{
            NSLog(@"App Adwo size wrong..");
            adBannerSize = -1;
        }
        
        AWAdView *awAdView = [[AWAdView alloc] initWithAdwoPid:tempID adIdType:1 adTestMode:isTest adSizeForPad:adBannerSize];
        awAdView.delegate = self;
        awAdView.adRequestTimeIntervel = 300;
        awAdView.userGpsEnabled = NO;
        [awAdView loadAd];
        self.adBannerView = awAdView;
        [awAdView release];
        
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
        GHLogWarn(@"App Adwo key null..");
    }
}

- (void)dealloc {
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [_adBannerView killTimer];
    _adBannerView.delegate = nil;
    [_adBannerView release];
	[super dealloc];
}

#pragma mark implement AWDelegate method

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self.adView.delegate viewControllerForPresentingModalView];
}

- (void)adViewDidFailToLoadAd:(AWAdView *)view
{
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}
- (void)adViewDidLoadAd:(AWAdView *)view
{
    [self.adView setAdContentView:self.adBannerView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)adViewShouldClose:(AWAdView *)view
{
    [self.adView userWillLeaveApplicationFromAdapter:self];
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
