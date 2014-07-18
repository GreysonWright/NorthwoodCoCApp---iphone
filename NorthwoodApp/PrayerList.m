//
//  PrayerList.m
//  NorthwoodCoC
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "PrayerList.h"
#import "TFhpple.h"
#import "FileDownloader.h"

@implementation PrayerList

@synthesize link = _link;

+(NSMutableArray*)prayerListObjects{
	NSURL *prayerListUrl = [NSURL URLWithString:@"http://justchristians.info/"];
    NSData *prayerListHtmlData = [NSData dataWithContentsOfURL:prayerListUrl];
	
    TFHpple *prayerListParser = [TFHpple hppleWithHTMLData:prayerListHtmlData];
	
    NSString *prayerListXpathQueryString = @"//*[@id='header']/nav/ul/li[5]/ul/li[3]/a";
    NSArray *prayerListNodes = [prayerListParser searchWithXPathQuery:prayerListXpathQueryString];
	
    NSMutableArray *newprayerList = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in prayerListNodes) {
        
        PrayerList *prayerLists = [[PrayerList alloc] init];
        [newprayerList addObject:prayerLists];
		
		prayerLists.link = [element objectForKey:@"href"];
		[FileDownloader downloadPDFWithURL:@"http://justchristians.info/Bulletins/PrayerList.pdf"  withFileName:@"PrayerList.pdf"];
    }
    return newprayerList;
}

@end
