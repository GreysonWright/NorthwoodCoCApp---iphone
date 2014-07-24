//
//  TweetTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

-(instancetype)init{
   
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TweetTableViewCell class]) owner:nil options:nil][0];
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

-(void)fillWithData:(Tweet*)tweet{
	if([tweet.URL  isEqual: @"none"])
		self.contentLabel.text = tweet.tweetContent;
	else
		self.contentLabel.text = [tweet.tweetContent stringByAppendingString:tweet.URL];
}

-(void)fillDateWithData:(Tweet*)tweet{
	NSString *realTweet = [tweet.date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	self.dateLabel.text = realTweet;
}

-(void)fillWithBareData:(NSString *)tweet{
	self.contentLabel.text=tweet;
}

-(void)fillDateWithBareData:(NSString*)date{
	NSString *realTweet = [date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	self.dateLabel.text = realTweet;
}
@end
