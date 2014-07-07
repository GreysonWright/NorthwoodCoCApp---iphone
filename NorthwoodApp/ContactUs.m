//
//  ContactUs.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "ContactUs.h"
#import "TFhpple.h"

@implementation ContactUs

@synthesize title = _title;
@synthesize name = _name;
@synthesize email = _email;

+(NSMutableArray*)titleObjects{
	
	NSURL *contactUrl = [NSURL URLWithString:@"http://justchristians.info/ContactUs/"];
    NSData *contactHtmlData = [NSData dataWithContentsOfURL:contactUrl];
	
    TFHpple *contactParser = [TFHpple hppleWithHTMLData:contactHtmlData];
	
    NSString *contactXpathQueryString = @"//*[@id='container']/section/table/thead/tr/th[1]";
    NSArray *contactNodes = [contactParser searchWithXPathQuery:contactXpathQueryString];
	
#pragma mark - delete this
	
	/*NSURL *contactUrl2 = [NSURL URLWithString:@"http://justchristians.info/ContactUs/"];
    NSData *contactHtmlData2 = [NSData dataWithContentsOfURL:contactUrl2];
	
    TFHpple *contactParser2 = [TFHpple hppleWithHTMLData:contactHtmlData2];
	
    NSString *contactXpathQueryString2 = @"//tr[@class='dark']/td[1] | //tr[@class='light']/td[1]";
    NSArray *contactNodes2 = [contactParser2 searchWithXPathQuery:contactXpathQueryString2]; */
	
#pragma mark - end delete this
	
    NSMutableArray *newcontact = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in contactNodes) {
        
        ContactUs *contact = [[ContactUs alloc] init];
        [newcontact addObject:contact];
		
		contact.title = [[element firstChild]content];
		
		/*for (TFHppleElement *element2 in contactNodes2) {
			
			ContactUs *contact2 = [[ContactUs alloc] init];
			[newcontact addObject:contact2];
			
			contact2.name = [[element2 firstChild]content];
		} */
    }
	
    return newcontact;
}

+(NSMutableArray*)nameObjects{
	
	NSURL *contactUrl = [NSURL URLWithString:@"http://justchristians.info/ContactUs/"];
    NSData *contactHtmlData = [NSData dataWithContentsOfURL:contactUrl];
	
    TFHpple *contactParser = [TFHpple hppleWithHTMLData:contactHtmlData];
	
    NSString *contactXpathQueryString = @"//tr[@class='dark']/td[1] | //tr[@class='light']/td[1]";
    NSArray *contactNodes = [contactParser searchWithXPathQuery:contactXpathQueryString];
	
    NSMutableArray *newcontact = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in contactNodes) {
        
        ContactUs *contact = [[ContactUs alloc] init];
        [newcontact addObject:contact];
		
		contact.name = [[element firstChild]content];
    }
	
    return newcontact;
}

+(NSMutableArray*)emailObjects{
	
	NSURL *contactUrl = [NSURL URLWithString:@"http://justchristians.info/ContactUs/"];
    NSData *contactHtmlData = [NSData dataWithContentsOfURL:contactUrl];
	
    TFHpple *contactParser = [TFHpple hppleWithHTMLData:contactHtmlData];
	
    NSString *contactXpathQueryString = @"//*[@id='container']/section/table/tbody/tr/td[2]/a";
	
    NSArray *contactNodes = [contactParser searchWithXPathQuery:contactXpathQueryString];
	
    NSMutableArray *newcontact = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in contactNodes) {
        
        ContactUs *contact = [[ContactUs alloc] init];
        [newcontact addObject:contact];
		
		contact.email = [element objectForKey:@"href"];
    }
	
    return newcontact;
}
@end
