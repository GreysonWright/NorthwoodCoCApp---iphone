//
//  PrayerListTableViewCell.m
//  NorthwoodApp
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "PrayerListTableViewCell.h"

@implementation PrayerListTableViewCell

-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PrayerListTableViewCell class]) owner:nil options:nil][0];
    
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

-(void)loadWebPage:(NSString*)URL{
	NSLog(URL);
	NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:requestObj];
	
}

-(void)fillWithData:(PrayerList*)prayerList{
	[self loadWebPage:prayerList.link];
}

@end
