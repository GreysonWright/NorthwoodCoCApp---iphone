//
//  Bulletin.m
//  NorthwoodCoC
//
//  Created by greyson on 6/16/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "Bulletin.h"
#include "TFHpple.h"
#include "FileDownloader.h"

@implementation Bulletin

@synthesize bulletinContent = _bulletinContent;
@synthesize bulletinLink = _bulletinLink;


+(NSMutableArray*)bulletinObject{
	NSURL *bulletinUrl = [NSURL URLWithString:@"http://justchristians.info/Bulletins/"];
    NSData *bulletinHtmlData = [NSData dataWithContentsOfURL:bulletinUrl];
	
    TFHpple *bulletinParser = [TFHpple hppleWithHTMLData:bulletinHtmlData];
	
    NSString *bulletinXpathQueryString = @"//div[@class='clear']/section/ul/li/a";
    NSArray *bulletinNodes = [bulletinParser searchWithXPathQuery:bulletinXpathQueryString];
	
    NSMutableArray *newbulletin = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in bulletinNodes) {
        
        Bulletin *bulletins = [[Bulletin alloc] init];
        [newbulletin addObject:bulletins];
		
        bulletins.bulletinContent = [[element firstChild] content];
		bulletins.bulletinLink = [element objectForKey:@"href"];
		[FileDownloader downloadPDFWithURL:[@"http://justchristians.info/Bulletins/" stringByAppendingString:bulletins.bulletinLink] withFileName:bulletins.bulletinLink];
    }
	return newbulletin;
}

+(NSMutableArray*)bulletinLink{
	NSURL *bulletinUrl = [NSURL URLWithString:@"http://justchristians.info/Bulletins/"];
    NSData *bulletinHtmlData = [NSData dataWithContentsOfURL:bulletinUrl];
	
    TFHpple *bulletinParser = [TFHpple hppleWithHTMLData:bulletinHtmlData];
	
    NSString *bulletinXpathQueryString = @"//div[@class='clear']/section/ul/li/a";
    NSArray *bulletinNodes = [bulletinParser searchWithXPathQuery:bulletinXpathQueryString];
	
    NSMutableArray *bulletinLinks = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in bulletinNodes) {
        
		
		[bulletinLinks addObject:[element objectForKey:@"href"]];
    }
	return bulletinLinks;
}

+(NSMutableArray*)getBareBulletinObjects{
	NSURL *bulletinUrl = [NSURL URLWithString:@"http://justchristians.info/Bulletins/"];
    NSData *bulletinHtmlData = [NSData dataWithContentsOfURL:bulletinUrl];
	
    TFHpple *bulletinParser = [TFHpple hppleWithHTMLData:bulletinHtmlData];
	
    NSString *bulletinXpathQueryString = @"//div[@class='clear']/section/ul/li/a";
    NSArray *bulletinNodes = [bulletinParser searchWithXPathQuery:bulletinXpathQueryString];
	
    NSMutableArray *newbulletin = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in bulletinNodes) {
		
		NSString *bulletinStuff;
		
        bulletinStuff = [[element firstChild] content];
		
        [newbulletin addObject:bulletinStuff];
    }
	return newbulletin;
}

+(NSMutableArray*)getBulletinPDF{
	NSMutableArray *bulletinPDFs = [[NSMutableArray alloc]init];
	return bulletinPDFs;
}
@end
