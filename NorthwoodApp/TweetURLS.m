//
//  TweetURLS.m
//  NorthwoodApp
//
//  Created by greyson on 6/20/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "TweetURLS.h"
#import "TFHpple.h"

@implementation TweetURLS

static NSString *tweetURL;

+(NSMutableArray*)URLObjects{
	NSURL *tweetsUrl = [NSURL URLWithString:@"https://twitter.com/northwoodcoc"]; ////*[@id="stream-item-tweet-460171806243311616"]/div/div[2]/p/a/span[3]
    NSData *tweetsHtmlData = [NSData dataWithContentsOfURL:tweetsUrl];
	
    TFHpple *tweetsParser = [TFHpple hppleWithHTMLData:tweetsHtmlData];
	
    NSString *tweetsXpathQueryString = @"//*[@id='stream-item-tweet-460171806243311616']/div/div[2]/p/a/span[3]";
    NSArray *tweetsNodes = [tweetsParser searchWithXPathQuery:tweetsXpathQueryString];
	
    NSMutableArray *newtweets = [[NSMutableArray alloc] initWithCapacity:0];
	
    for (TFHppleElement *element in tweetsNodes) {
        
        TweetURLS *tweet = [[TweetURLS alloc] init];
        [newtweets addObject:tweet];
		
		tweetURL = [[element firstTextChild]content];
    }
	
    return newtweets;
}

+(NSString*)getURLs{
	return tweetURL;
}

@end
