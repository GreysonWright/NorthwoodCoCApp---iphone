//
//  NetworkStatus.m
//  NorthwoodCoC
//
//  Created by greyson on 7/15/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "NetworkStatus.h"
#import "TFHpple.h"

@implementation NetworkStatus

+(BOOL)networkExists{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='ProfileTweet-contents']/p";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	if(tweetsNodes.count == 0)
		return NO;
	
	else
		return YES;
}

@end
