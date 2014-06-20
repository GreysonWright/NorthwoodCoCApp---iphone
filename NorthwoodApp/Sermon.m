//
//  Sermon.m
//  NorthwoodApp
//
//  Created by greyson on 6/15/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "Sermon.h"
#import "TFHPPLE.h"

@implementation Sermon

@synthesize link = _link;
@synthesize yearPart = _yearPart;

static NSString *finalURL;

+(NSMutableArray*)sermonObjects{
	
	NSURL *sermonsUrl = [NSURL URLWithString:[Sermon getFinalURL]];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td | //tr[@class='dark']/td";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
        
        Sermon *sermon = [[Sermon alloc] init];
        [newSermons addObject:sermon];
		
		sermon.link = [element objectForKey:@"href"]; //use this to get the url hopefully
    }
	
    return newSermons;
}

+(void)makeFinalURLWith:(NSString*)yearInput{
	NSString *firstString = @"http://justchristians.info/Sermons/";
	NSString *secondString = [firstString stringByAppendingString:yearInput];
	NSString *wholeURL = [secondString stringByAppendingString:@"Sermons/"];
	finalURL = wholeURL;
	NSLog(finalURL);
}

+(NSString*)getFinalURL{
	return finalURL;
}
@end