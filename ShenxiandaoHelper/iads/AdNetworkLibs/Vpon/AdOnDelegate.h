 //
//  AdOnDelegate.h
//  iphone-sdk
//
//  Created by Shark on 2010/7/12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdOnPlatform.h"
@class VponAdOnView;

/** 
 *實作這個Protocol，當有從伺服器上接收到廣告，將會呼叫以下的方法。
 * @author Vpon
 */

@protocol VponAdOnDelegate <NSObject>

/**
 * 當請求一個廣告，成功時會執行onRecevieAd
 */

- (void) onRecevieAd:(VponAdOnView *)adView;


/**
 * 當請求一個廣告失敗時，會執行onFailedToRecevieAd
 * 
 */

- (void) onFailedToRecevieAd:(VponAdOnView *)adView;


/**
 * 輸入LicenseKey，將會回傳LicenseKey給伺服器
 */

- (NSString *) adonLicenseKey;

/**
 * 設定是否自動更新廣告
 */

- (Boolean) autoRefreshAdonAd;

/**
 * 回傳Latitude的值給Vpon Ad，當沒值時要設定回傳0
 *
 */
- (double) locationLatitude;

/**
 * 回傳Longtitude的值給Vpon Ad，當沒值時要設定回傳0
 *
 */
- (double) locationLongtitude;

/**
 *設定回傳的廣告給iphone 或是ipad
 *
 */

- (CGSize) requestAdOfSize;
/*
 *設定廣告投放的區域
 */
- (Platform) getPlatform;

@end
