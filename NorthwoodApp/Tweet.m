//
//  Tweet.m
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "Tweet.h"
#import "TFHpple.h"

@implementation Tweet

@synthesize tweetContent = _tweetContent;
@synthesize date = _date;

static NSString *tweetURL;

+(NSMutableArray*)tweetObjects{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"];
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='ProfileTweet-contents']/p";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	
    NSMutableArray *newtweets = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (int i = 0; i<tweetsNodes.count; i++) {
        TFHppleElement *element = [tweetsNodes objectAtIndex:i];
        Tweet *tweet = [[Tweet alloc] init];
        [newtweets addObject:tweet];
		
		tweet.tweetContent = [[element firstTextChild]content];
    }
	
    return newtweets;
}

+(NSMutableArray*)URLObjects{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"]; //*[@id="stream-item-tweet-433720654546747392"]/div/div[1]/div/span[2]/a
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//div[@class='ProfileTweet-contents']";//div[@class='StreamItem js-stream-item']/div/div[2]/p/a
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	
    NSMutableArray *newtweets = [[NSMutableArray alloc] initWithCapacity:0];
	
   for (TFHppleElement *element in tweetsNodes) {
        
	   Tweet *tweet = [[Tweet alloc] init];
	   [newtweets addObject:tweet];
		
	   //tweetURL = [element objectForKey:@"title"];
	   tweetURL = [[element firstChildWithTagName:@"p"]content];
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

+(NSString*)getURLs{
	return tweetURL;
}


@end
