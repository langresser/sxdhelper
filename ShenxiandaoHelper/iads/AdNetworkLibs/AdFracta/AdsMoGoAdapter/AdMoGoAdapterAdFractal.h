//
//  File: AdMoGoAdapterAdFractal.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.3
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import "AdFractaView.h"

@interface AdMoGoAdapterAdFractal : AdMoGoAdNetworkAdapter <AdFractaViewDelegate>{
}
+ (AdMoGoAdNetworkType)networkType;
@end
