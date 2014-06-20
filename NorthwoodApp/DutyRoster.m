//
//  DutyRoster.m
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "DutyRoster.h"
#import "TFhpple.h"

@implementation DutyRoster

@synthesize link = _link;

+(NSMutableArray*)dutyRosterObjects{
	NSURL *dutyRosterUrl = [NSURL URLWithString:@"http://justchristians.info/"];
    NSData *dutyRosterHtmlData = [NSData dataWithContentsOfURL:dutyRosterUrl];
	
    TFHpple *dutyRosterParser = [TFHpple hppleWithHTMLData:dutyRosterHtmlData];
	
    NSString *dutyRosterXpathQueryString = @"//*[@id='header']/nav/ul/li[5]/ul/li[4]/a";
    NSArray *dutyRosterNodes = [dutyRosterParser searchWithXPathQuery:dutyRosterXpathQueryString];
	
    NSMutableArray *newdutyRoster = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in dutyRosterNodes) {
        
        DutyRoster *dutyRoster = [[DutyRoster alloc] init];
        [newdutyRoster addObject:dutyRoster];
		
		dutyRoster.link = [element objectForKey:@"href"];
    }
    return newdutyRoster;
}

@end
