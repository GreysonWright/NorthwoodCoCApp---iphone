//
//  Tweet.h
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, copy) NSString *tweetContent;
@property (nonatomic, copy) NSString *date;
+(NSMutableArray*)tweetObjects;
+(NSMutableArray*)URLObjects;
+(NSMutableArray*)dateObjects;
+(NSString*)getURLs;

@end
