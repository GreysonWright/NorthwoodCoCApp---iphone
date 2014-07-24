//
//  PrayerListTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "PrayerListTableViewCell.h"

@implementation PrayerListTableViewCell

-(instancetype)init{
    
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
	//NSLog(URL);
	/*NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:requestObj]; */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"PrayerList.pdf"];
	NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@" ,dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
	[self.webView loadRequest:request];
	self.webView.scalesPageToFit=YES;
}

-(void)loadWebPageInOfflineMode{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"PrayerList.pdf"];
	NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@" ,dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
	[self.webView loadRequest:request];
	self.webView.scalesPageToFit=YES;
}

-(void)fillWithData:(PrayerList*)prayerList{
	[self loadWebPage:prayerList.link];
}

@end
