//
//  AirADView.h
//  airADKit
//
//  Created by NSXiu on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "airADViewDelegate.h"

@interface airADView : UIView {
  BOOL isActive_;
  NSString * appIdentifier_;
  id delegate_;
}
@property (nonatomic, readonly) BOOL isActive;

// AppIdentifer只需要设置一次,所有airADView共用一个.
@property (nonatomic, copy) NSString * appIdentifier;

// 每个airADView单独设置自己的delegate
@property (nonatomic, assign) id delegate;

 
@end
