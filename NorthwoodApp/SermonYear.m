//
//  SermonYear.m
//  NorthwoodCoC
//
//  Created by greyson on 12/3/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SermonYear.h"

@implementation SermonYear

@synthesize year = _year;

+(NSMutableArray*)getSermonYearObjects{
	
	NSURL *sermonYearsUrl = [NSURL URLWithString:@"http://justchristians.info/"];
	NSData *sermonsHtmlData = [NSData dataWithContentsOfURL:sermonYearsUrl];
	
	TFHpple *sermonsParser = [TFHpple hppleWithHTMLData:sermonsHtmlData];
	
	NSString *sermonsXpathQueryString = @"//*[@id='header']/nav/ul/li[3]/strong/span";
	NSArray *sermonsNodes = [sermonsParser searchWithXPathQuery:sermonsXpathQueryString];
	
	NSMutableArray *newSermonYears = [[NSMutableArray alloc] initWithCapacity:0];
	
	for (TFHppleElement *element in sermonsNodes) {
		
		//SermonYear *sermonYear = [[SermonYear alloc] init];
		NSString *sermonYear = [[[element firstChild] firstChildWithTagName:@"strong"]content];
		[newSermonYears addObject:sermonYear];
		//sermonYear.year = [[[element firstChild] firstChildWithTagName:@"strong"]content];
	}
	
	return newSermonYears;
}

@end
