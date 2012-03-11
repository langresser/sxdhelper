/**
 *	AdChinaFullScreenViewDelegateProtocol.h
 *	AdChina iOS SDK publisher code.
 *
 *	Defines the AdChinaFullScreenViewDelegate protocol
 */

@class AdChinaFullScreenView;

@protocol AdChinaFullScreenViewDelegate <NSObject>

#pragma mark Full-Screen Ad
@required
- (NSString *)fullScreenAdSpaceId;
@optional
// If you don't set view controller for ad, the default view controller is the delegate
- (UIViewController *)viewControllerForFullScreenAd:(AdChinaFullScreenView *)fsView;

- (void)didGetFullScreenAd:(AdChinaFullScreenView *)fsView;
- (void)didFailedToGetFullScreenAd:(AdChinaFullScreenView *)fsView;
- (void)didCloseFullScreenAd:(AdChinaFullScreenView *)fsView;

#pragma mark Begin/Finish Browsing Ad Web
- (void)didBeginBrowsingAdWeb:(AdChinaFullScreenView *)fsView;
- (void)didFinishBrowsingAdWeb:(AdChinaFullScreenView *)fsView;

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
