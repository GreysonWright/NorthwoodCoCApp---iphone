//
//  Directory.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Directory : NSObject

@property (nonatomic, copy) NSString* nameValue;
@property (nonatomic, copy) NSString* titleValue;
@property (nonatomic, copy) NSString* phoneValue;
@property (nonatomic, copy) NSString* emailValue;
@property (nonatomic, copy) NSString* addressValue;

+(NSMutableArray*)nameObjects;
+(NSMutableArray*)titleObjects;
+(NSMutableArray*)phoneObjects;
+(NSMutableArray*)emailObjects;
+(NSMutableArray*)adressObjects;

@end
