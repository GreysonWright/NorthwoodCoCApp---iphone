//
//  UniversalWebViewViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/22/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "UniversalWebViewViewController.h"
#import "Sermon.h"
#import "SettingsViewController.h"

@interface UniversalWebViewViewController (){
	NSString *_url;
	NSString *_title;
	BOOL _scaleToFit;
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
	if(_scaleToFit == YES){
		self.webView.scalesPageToFit = YES;
		_scaleToFit=NO;
	}
	else if(_scaleToFit == NO){
		NSLog(@"no zoom");
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSermonAudio:(NSString*)URL{
	if([URL rangeOfString:@"2009"].location != NSNotFound  || [URL rangeOfString:@"2010"].location != NSNotFound){
		NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
		NSString *refinedFinalURL = [urlAddress stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		_url = refinedFinalURL;
	}
	else if([URL rangeOfString:@"2009"].location == NSNotFound  || [URL rangeOfString:@"2010"].location == NSNotFound){
	NSString *urlAddress = [@"http://www.justchristians.info/Sermons/" stringByAppendingString:[Sermon getSermonYear]];
	NSString *nextURL = [urlAddress stringByAppendingString:URL];
	NSString *finalURL = [nextURL stringByReplacingOccurrencesOfString:@"./" withString:@""];
	NSString *refinedFinalURL = [finalURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSString *secondRefinedURL = [refinedFinalURL stringByReplacingOccurrencesOfString:@"\n" withString:@"%20"];
	_url = secondRefinedURL;
	_scaleToFit = YES;
	}
}

-(void)loadBulletinPDF:(NSString*)URL{
	NSString *urlAddress = [@"http://www.justchristians.info/Bulletins/" stringByAppendingString:URL];
	_url = urlAddress;
	_title = URL;
	_scaleToFit = YES;
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}
@end
