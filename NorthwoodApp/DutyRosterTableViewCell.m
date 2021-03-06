//
//  DutyRosterTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "DutyRosterTableViewCell.h"

@implementation DutyRosterTableViewCell

-(instancetype)init{
   
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DutyRosterTableViewCell class]) owner:nil options:nil][0];
    
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
	
	/*NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:requestObj];
	self.webView.scalesPageToFit = YES; */
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"DutyRoster.pdf"];
	NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@" ,dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
	[self.webView loadRequest:request];
	self.webView.scalesPageToFit=YES;
}

-(void)loadWebPageInOfflineMode{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"DutyRoster.pdf"];
	NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@" ,dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
	[self.webView loadRequest:request];
	self.webView.scalesPageToFit=YES;
}

-(void)fillWithData:(DutyRoster*)dutyRoster{
	[self loadWebPage:dutyRoster.link];
}

@end
