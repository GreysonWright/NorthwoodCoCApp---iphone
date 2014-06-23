//
//  UniversalWebViewViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/22/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "UniversalWebViewViewController.h"

@interface UniversalWebViewViewController (){
	NSString *_url;
	NSString *_title;
}
@end

@implementation UniversalWebViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:_url];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	NSLog(_url);
	[self.webView loadRequest:requestObj];
	self.title = _title;
	self.webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSermonAudio:(NSString*)URL{
	
	NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
	NSString *finalURL = [urlAddress stringByReplacingOccurrencesOfString:@"." withString:@""];
	NSString *refinedFinalURL = [finalURL stringByReplacingOccurrencesOfString:@" " withString:@"%"];
	_url = refinedFinalURL;
	_title = URL;
}

-(void)loadBulletinPDF:(NSString*)URL{
	NSString *urlAddress = [@"http://www.justchristians.info/Bulletins/" stringByAppendingString:URL];
	_url = urlAddress;
	_title = URL;
}

@end
