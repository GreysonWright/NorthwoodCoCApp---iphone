//
//  TweetTableViewCell.m
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

-(instancetype)init{
    self=[super init];
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
	/*if([Tweet getURLs] != nil)
		self.contentLabel.text = [tweet.tweetContent stringByAppendingString:[Tweet getURLs]];
	else */
		self.contentLabel.text = tweet.tweetContent;
}

-(void)fillDateWithData:(Tweet*)tweet{
	NSString *realTweet = [tweet.date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	self.dateLabel.text = realTweet;
}

@end
