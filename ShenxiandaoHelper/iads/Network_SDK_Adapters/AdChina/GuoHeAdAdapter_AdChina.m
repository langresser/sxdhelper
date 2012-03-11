//
//  GuoHeAdAdapter_AdChina.m
//  GuoHeProiOSDev
//
//  Created by Mike Peng on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_AdChina.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_AdChina
@synthesize theKey;
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [_adBannerView release];
    [theKey release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        self.theKey = [keyArray objectAtIndex:0];
        self.adBannerView = [AdChinaBannerView requestAdWithDelegate:self];
        if (adsize.width==320&&adsize.height==50) {
            [_adBannerView setAdFrame:CGRectMake(0, 0, 320, 50)];
        } else if (adsize.width==728&&adsize.height==90) {
            [_adBannerView setAdFrame:CGRectMake(0, 0, 728, 90)];
        } 
        
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
        self.theKey = nil;
        GHLogWarn(@"App AdChina key null..");
    }
}

#pragma mark -
#pragma mark AdChina Banner Delegate
- (NSString *)adSpaceId:(AdChinaBannerView *)adView {
	//return kBannerAdSpaceId;
	return self.theKey;
}

- (UIViewController *)viewControllerForBannerAd:(AdChinaBannerView *)adView{
    return [self.adView.delegate viewControllerForPresentingModalView];
}

- (void)didGetBannerAd:(AdChinaBannerView *)adView {
    [self.adView setAdContentView:adView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void)didFailedToGetBannerAd:(AdChinaBannerView *)adView {
    [self.adView adapter:self didFailToLoadAdWithError:nil];
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
