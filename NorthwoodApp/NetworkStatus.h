//
//  NetworkStatus.h
//  NorthwoodCoC
//
//  Created by greyson on 7/15/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkStatus : NSObject

+(BOOL)networkExists;
+(void)setSlowNetwork:(BOOL)slow;

@end
