//
//  PrayerList.h
//  NorthwoodCoC
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayerList : NSObject

@property (nonatomic, copy) NSString *link;

+(NSMutableArray*)prayerListObjects;

@end
