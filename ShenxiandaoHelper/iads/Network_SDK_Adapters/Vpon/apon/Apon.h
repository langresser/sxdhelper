//
//  Apon.h
//  Apon
//
//  Created by Su Chun Hunag on 11/9/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apon : NSObject{
    
    NSString *licenseKey;
    int Platform;
}
@property(retain) NSString *licenseKey;

+(Apon *)shareInstance;

- (id)initWithCN;
- (id)initWithTW;

-(void)shutdownAponManager;
-(void)startTrack;
-(void)stopTrack;
-(void)latitude:(float)lat;
-(void)longitude:(float)lon;


@end
