//
//  FileDownloader.m
//  NorthwoodCoC
//
//  Created by greyson on 7/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "FileDownloader.h"
#import "ASIHTTPRequest.h"
#import "NetworkStatus.h"


@implementation FileDownloader

+(void)creatDirectoryForPDFs:(NSString*)fileName{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
}

+(void)downloadPDFWithURL:(NSString*)link withFileName:(NSString*)fileName{
	if([NetworkStatus networkExists]){
		[self creatDirectoryForPDFs:fileName];
		
		/*NSURL *url = [NSURL URLWithString:[link stringByAppendingString:object]];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setDownloadDestinationPath:@"PDFs"];
		[request setDelegate:self];
		[request startAsynchronous];*/
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
		NSURL *url = [NSURL URLWithString:link];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setDownloadDestinationPath:[NSString stringWithFormat:@"%@",dataPath]];
		[request setDelegate:self];
		[request startAsynchronous];
	}
	else{
		NSLog(@"dont download");
	}
}
@end
