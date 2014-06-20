//
//  SermonTitle.m
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "SermonTitle.h"
#import "TFHpple.h"
#import "Sermon.h"

@implementation SermonTitle

@synthesize content = _content;


+(NSMutableArray*)sermonObjects{
	NSURL *sermonsUrl = [NSURL URLWithString:[Sermon getFinalURL]];
    NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonsUrl];
	
    TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
    NSString *sermonsXpathQueryString = @"//tr[@class='light']/td[2] | //tr[@class='dark']/td[2]";
    NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
    NSMutableArray *newSermons = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in sermonsNodes) {
        
        SermonTitle *sermon = [[SermonTitle alloc] init];
        [newSermons addObject:sermon];
		
		 sermon.content = [[element firstChild] content];
    }
	
    return newSermons;
}

@end
