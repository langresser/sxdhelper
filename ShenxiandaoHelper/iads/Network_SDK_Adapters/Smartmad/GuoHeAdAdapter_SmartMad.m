//
//  GuoHeAdAdapter_SmartMad.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 10/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_SmartMad.h"
#import "SmartMadAdView.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_SmartMad
@synthesize keyInfoStr, adviewSize;
@synthesize adBannerView =_adBannerView;

- (void)dealloc
{
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [keyInfoStr release];
    [_adBannerView removeFromSuperview];
    [_adBannerView  setEventDelegate:nil];
    [_adBannerView  set_adEventDelegate:nil];
	[_adBannerView  release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
    self.keyInfoStr = keyInfo;
    self.adviewSize = adsize;
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        [SmartMadAdView setApplicationId:[keyArray objectAtIndex:0]];
        if (_adBannerView) {
            [_adBannerView removeFromSuperview];
            [_adBannerView release];
            _adBannerView = nil;
        }
		SmartMadAdView *smartMadAdView = [[SmartMadAdView alloc] initRequestAdWithDelegate:self];
		[smartMadAdView setEventDelegate:self];
        self.adBannerView = smartMadAdView;
        [smartMadAdView release];
        
        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [self.adBannerView addGestureRecognizer:_nonListenerGR];
        //----------- end

    }
    else{
        [_adBannerView  setEventDelegate:nil];
        [_adBannerView  release];
        GHLogWarn(@"App SmartMad key null..");
    }
}
- (AdCompileMode) compileMode
{
    NSArray *keyArray = [self.keyInfoStr componentsSeparatedByString:@"|;|"];
    if ([keyArray count]>1) {
        NSString *strTest = [keyArray objectAtIndex:2];
        if ([strTest compare:@"true"]==NSOrderedSame) {
            return AdDebug;
        }
    }

    return AdRelease;
}

-(NSString*)adPositionId
{
    NSArray *keyArray = [self.keyInfoStr componentsSeparatedByString:@"|;|"];
    if ([keyArray count]>1) {
        return [keyArray objectAtIndex:1];
    }
    return nil;
}


 //set ad measure type
-(AdMeasureType)adMeasure{
    if (self.adviewSize.width==320&&self.adviewSize.height==50) {
        return PHONE_AD_MEASURE_320X48;
    }else if (self.adviewSize.width==176&&self.adviewSize.height==27) {
        return PHONE_AD_MEASURE_176X27;
    }else if (self.adviewSize.width==240&&self.adviewSize.height==36) {
        return PHONE_AD_MEASURE_240X36;
    }else if (self.adviewSize.width==360&&self.adviewSize.height==54) {
        return PHONE_AD_MEASURE_360X54;
    }else if (self.adviewSize.width==480&&self.adviewSize.height==72) {
        return PHONE_AD_MEASURE_480X72;
    }else if (self.adviewSize.width==640&&self.adviewSize.height==96) {
        return PHONE_AD_MEASURE_640X96;
    }else if (self.adviewSize.width==300&&self.adviewSize.height==250) {
        return TABLET_AD_MEASURE_300X250;
    }else if (self.adviewSize.width==468&&self.adviewSize.height==60) {
        return TABLET_AD_MEASURE_468X60;
    }else if (self.adviewSize.width==728&&self.adviewSize.height==90) {
        return TABLET_AD_MEASURE_728X90;
    }else {
        GHLogWarn(@"App Smartmad size wrong..");
        return -1;
    }

}
-(NSTimeInterval)adInterval{
    return 1000.0;
}

// from adevent delegate
// callback current ad event
- (void)adEvent:(const SmartMadAdView*)adview  adEventCode:(AdEventCodeType)eventCode
{
	if (eventCode==EVENT_NEWAD) {
        if (self) {
            [self.adView setAdContentView:adview];
            [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
        }
        
    }
    else{
        [self.adView adapter:self didFailToLoadAdWithError:nil];
    }
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
