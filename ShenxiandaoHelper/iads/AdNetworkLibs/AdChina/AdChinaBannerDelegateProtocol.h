/**
 *	AdChinaBannerDelegateProtocol.h
 *	AdChina iOS SDK publisher code.
 *
 *	Defines the AdChinaBannerDelegate protocol
 */

#import <UIKit/UIKit.h>

@class AdChinaBannerView;

@protocol AdChinaBannerDelegate <NSObject>

#pragma mark Banner Ad
@required
- (NSString *)adSpaceId:(AdChinaBannerView *)adView;
@optional
// If you don't set view controller for ad, the default view controller is the delegate
- (UIViewController *)viewControllerForBannerAd:(AdChinaBannerView *)adView;

- (void)didGetBannerAd:(AdChinaBannerView *)adView;
- (void)didFailedToGetBannerAd:(AdChinaBannerView *)adView;

#pragma mark Begin/Finish Browsing Ads
/* Browsing Ad Web */
- (void)didBeginBrowsingAd:(AdChinaBannerView *)adView;
- (void)didFinishBrowsingAd:(AdChinaBannerView *)adView;

#pragma mark User Info
/* User Info 
 * If you could get user info, return it here to get the ads more attractive to the user.
 */
- (NSString *)phoneNumber;		// user's phone number
- (NSString *)gender;			// user's gender (@"1" for male, @"2" for female)
- (NSString *)postalCode;		// user's postal code, e.g. @"200040"
- (NSString *)dateOfBirth;		// user's date of birth, e.g. @"19820101"
- (NSString *)keyword;			// keyword about the type of your app, e.g. @"Business"

@end
