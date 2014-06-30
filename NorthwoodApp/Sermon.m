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
@synthesize titleContent = _titleContent;
@synthesize dateContent = _dateContent;
@synthesize preacherContent = _preacherContent;

static NSString *finalURL;
static NSString *sermonYear;

+(NSMutableArray*)sermonObjects{
	
	NSURL *sermonsUrl = [NSURL URLWithString:[Sermon getFinalURL]];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td[4]/a | //tr[@class='dark']/td[4]/a";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
        
        Sermon *sermon = [[Sermon alloc] init];
        [newSermons addObject:sermon];
		
		sermon.link = [element objectForKey:@"href"];
		//NSLog(sermon.link);
    }
	
    return newSermons;
}

+(void)makeFinalURLWith:(NSString*)yearInput{
	NSString *firstString = @"http://justchristians.info/Sermons/";
	NSString *secondString = [firstString stringByAppendingString:yearInput];
	NSString *wholeURL = [secondString stringByAppendingString:@"Sermons/"];
	finalURL = wholeURL;
	sermonYear = yearInput;
	//NSLog(finalURL);
}

+(NSString*)getFinalURL{
	return finalURL;
}

+(NSMutableArray*)sermonTitleObjects{
	NSURL *sermonsUrl = [NSURL URLWithString:finalURL];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td[2] | //tr[@class='dark']/td[2]";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
        
        Sermon *sermon = [[Sermon alloc] init];
        [newSermons addObject:sermon];
		
		sermon.titleContent = [[element firstChild] content];
    }
	
    return newSermons;
}

+(NSMutableArray*)sermonDateObjects{
	NSURL *sermonsUrl = [NSURL URLWithString:finalURL];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td[1] | //tr[@class='dark']/td[1]";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
        
        Sermon *sermon = [[Sermon alloc] init];
        [newSermons addObject:sermon];
		
		sermon.dateContent = [[element firstChild] content];
    }
	
    return newSermons;
}


+(NSMutableArray*)sermonPreacherObjects{
	NSURL *sermonsUrl = [NSURL URLWithString:finalURL];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td[3] | //tr[@class='dark']/td[3]";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
		
        Sermon *sermon = [[Sermon alloc] init];
        [newSermons addObject:sermon];
		
		sermon.preacherContent = [[element firstChild] content];
    }
	
    return newSermons;
}

+(NSString*)getSermonYear{
	NSString  *returnThis = [sermonYear stringByAppendingString:@"Sermons/"];
	return returnThis;
}
@end