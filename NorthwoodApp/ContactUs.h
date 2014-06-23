//
//  ContactUs.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactUs : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;

+(NSMutableArray*)titleObjects;
+(NSMutableArray*)emailObjects;
+(NSMutableArray*)nameObjects;

@end
