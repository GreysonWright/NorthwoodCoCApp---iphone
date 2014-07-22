//
//  ContactUs.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactUs : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *section;

//+(NSMutableArray*)titleObjects;
+(NSMutableArray*)evangelistEmailObjects;
+(NSMutableArray*)elderEmailObjects;
+(NSMutableArray*)deaconEmailObjects;
+(NSMutableArray*)evangelistObjects;
+(NSMutableArray*)elderObjects;
+(NSMutableArray*)deaconObjects;
+(NSMutableArray*)bareTitleObjects;
+(NSMutableArray*)bareEvangelistEmailObjects;
+(NSMutableArray*)bareElderEmailObjects;
+(NSMutableArray*)bareDeaconEmailObjects;
+(NSMutableArray*)bareEvangelistObjects;
+(NSMutableArray*)bareElderObjects;
+(NSMutableArray*)bareDeaconObjects;

@end
