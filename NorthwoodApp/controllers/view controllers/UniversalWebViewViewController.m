//
//  UniversalWebViewViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/22/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "UniversalWebViewViewController.h"
#import "Sermon.h"
#import "SettingsViewController.h"

@interface UniversalWebViewViewController (){
	NSString *_url;
	NSString *_title;
	NSString *_dataPath;
	//NSURL *_pdfPath;
	
	BOOL isPDF;
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

-(void)viewDidAppear:(BOOL)animated{
	
	 [self.navigationController.navigationBar.backItem setTitle:@"Members"];
	[super viewDidAppear:animated];
}

- (void)viewDidLoad
{
	
	if(!isPDF){
		NSURL *url = [NSURL URLWithString:_url];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		//NSLog(_url);
		[self.webView loadRequest:requestObj];
	}
	
	else if(isPDF){
		self.title = _title;
		NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@" ,_dataPath]];
		NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
		[self.webView loadRequest:request];
	}
	
    [super viewDidLoad];
	/*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"PDFs"];
	NSURL *realPath = [NSURL fileURLWithPath:[NSString stringWithFormat:[@"%@/" stringByAppendingString:_title],dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:realPath];
	[self.webView loadRequest:request]; */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSermonAudio:(NSString*)URL{
	isPDF = NO;
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
	}
}

/*-(void)loadBulletinPDF:(NSString*)URL{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	 NSString *localDocumentsDirectory = [paths objectAtIndex:0];
	 NSString *pdfFileName =URL;
	 NSString *localDocumentsDirectoryPdfFilePath = [localDocumentsDirectory stringByAppendingPathComponent:pdfFileName];
	 NSURL *pdfUrl = [NSURL fileURLWithPath:localDocumentsDirectoryPdfFilePath];
	 
	getTitle = YES;
	NSString *urlAddress = [@"http://www.justchristians.info/Bulletins/" stringByAppendingString:URL];
	_url = urlAddress;
	_pdfPath = pdfUrl;
	_title = URL;
} */

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}

-(void)loadPDF:(NSString*)fileName{
	isPDF = YES;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
	_dataPath = dataPath;
	self.webView.scalesPageToFit=YES;
	_title = fileName;
}
@end
