/**
 *	AdChinaVideoDelegateProtocol.h
 *	AdChina iOS SDK publisher code.
 *
 *	Defines the AdChinaVideoDelegate protocol
 */

@class AdChinaVideo;

@protocol AdChinaVideoDelegate <NSObject>

#pragma mark Video Ad
@required
- (NSString *)videoAdSpaceId;
@optional
// If you don't set view controller for ad, the default view controller is the delegate
- (UIViewController *)viewControllerForVideoAd:(AdChinaVideo *)adVideo;

- (void)didGetVideoAd;
- (void)didFailToGetVideoAd;
- (void)didFinishPreloadVideoAd;
- (void)didFinishPlayVideoAd;

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