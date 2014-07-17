//
//  Tweet.h
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, copy) NSString *tweetContent;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *URL;
+(NSMutableArray*)tweetObjects;
+(NSMutableArray*)dateObjects;
+(NSMutableArray*)bareTweetContent;
+(NSMutableArray*)bareTweetDates;
+(NSString*)getURLs;

@end
