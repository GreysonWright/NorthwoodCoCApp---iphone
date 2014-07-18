//
//  Tweet.m
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "Tweet.h"
#import "TFHpple.h"

@implementation Tweet

@synthesize tweetContent = _tweetContent;
@synthesize date = _date;
@synthesize URL = _URL;

static NSString *tweetURL;
int tweetCount;

+(NSMutableArray*)tweetObjects{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='ProfileTweet-contents']/p";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	tweetCount = tweetsNodes.count;
	
    NSMutableArray *newtweets = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (int i = 0; i<tweetsNodes.count; i++) {
        TFHppleElement *element = [tweetsNodes objectAtIndex:i];
        Tweet *tweet = [[Tweet alloc] init];
        [newtweets addObject:tweet];
		
		tweet.tweetContent = [[element firstTextChild]content];
		
		if([[element firstChildWithTagName:@"a"] objectForKey:@"title"] == nil)
			tweet.URL = @"none";
		//NSLog(@"nil");
		else
			//NSLog(@"pew");
			tweet.URL = [[element firstChildWithTagName:@"a"] objectForKey:@"title"];
    }
	
    return newtweets;
}


+(NSMutableArray*)dateObjects{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='StreamItem js-stream-item']/div/div[1]/div/span[2]/a/span";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	
    NSMutableArray *newtweets = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in tweetsNodes) {
        
        Tweet *tweet = [[Tweet alloc] init];
        [newtweets addObject:tweet];
		
		tweet.date = [[element firstTextChild]content];
    }
	
    return newtweets;
}

+(NSMutableArray*)bareTweetContent{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='ProfileTweet-contents']/p";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	tweetCount = tweetsNodes.count;
	
    NSMutableArray *tweetContent = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (int i = 0; i<tweetsNodes.count; i++) {
        TFHppleElement *element = [tweetsNodes objectAtIndex:i];
		
		NSString* content = [[element firstTextChild]content];
		NSString* URL;
		
		if([[element firstChildWithTagName:@"a"] objectForKey:@"title"] == nil)
			URL = @"";
		//NSLog(@"nil");
		else
			//NSLog(@"pew");
			URL = [[element firstChildWithTagName:@"a"] objectForKey:@"title"];
		[tweetContent addObject:[content stringByAppendingString:URL]];
    }
	
    return tweetContent;
}

+(NSMutableArray*)bareTweetDates{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='StreamItem js-stream-item']/div/div[1]/div/span[2]/a/span";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	
    NSMutableArray *tweetDates = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in tweetsNodes) {
        
      [tweetDates addObject:[[element firstTextChild]content]];
    }
	
    return tweetDates;
}

+(NSString*)getURLs{
	return tweetURL;
}
@end
