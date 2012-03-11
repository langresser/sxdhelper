//
//  GuoHeAdAdapter_Vpon.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 04/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Vpon.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Vpon
@synthesize theKey;
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
	[_adBannerView removeDelegate];
    [_adBannerView release];
    [theKey release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|"];
	if ([keyArray count]>0) {
        
        self.theKey = [keyArray objectAtIndex:0];
        
		self.adBannerView = [[VponAdOnView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        [_adBannerView requestAdWithSize:ADON_SIZE_320x48 setAdOnDelegate:self];
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
        GHLogWarn(@"App Vpon key null..");
    }
}

- (CGSize) requestAdOfSize {
    return ADON_SIZE_320x48;
}

//return your adon Licenese Key
- (NSString *) adonLicenseKey{
	return self.theKey;
	
}

- (Boolean) autoRefreshAdonAd{	
	return NO;
}

- (void) onRecevieAd:(VponAdOnView *)adView
{
    [self.adView setAdContentView:adView];
	[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

- (void) onFailedToRecevieAd:(VponAdOnView *)adView
{
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (Platform) getPlatform 
{
    return CN;
}

- (double) locationLatitude{
	if ([self.adView.delegate respondsToSelector:@selector(locationInfo)]) {
		return [self.adView.delegate locationInfo].coordinate.latitude;
	}
    
	return 0;
}

- (double) locationLongtitude{
	if ([self.adView.delegate respondsToSelector:@selector(locationInfo)]) {
		return [self.adView.delegate locationInfo].coordinate.longitude;
	}
	return 0;
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
