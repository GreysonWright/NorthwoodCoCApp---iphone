//
//  Sermon.h
//  NorthwoodApp
//
//  Created by greyson on 6/15/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sermons2010ViewController.h"

@interface Sermon : NSObject

@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic, copy) NSString *dateContent;
@property (nonatomic, copy) NSString *preacherContent;
@property NSString *yearPart;

+(NSMutableArray*)sermonObjects;
+(void)makeFinalURLWith:(NSString*)yearInput;
+(NSString*)getFinalURL;
+(NSMutableArray*)sermonTitleObjects;
+(NSMutableArray*)sermonDateObjects;
+(NSMutableArray*)sermonPreacherObjects;
+(NSString*)getSermonYear;

@end
