//
//  Bulletin.h
//  NorthwoodApp
//
//  Created by greyson on 6/16/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bulletin : NSObject

@property NSString *bulletinContent;
@property NSString *bulletinLink;
+(NSMutableArray*)bulletinObject;
+(NSMutableArray*)bulletinLink;
@end
