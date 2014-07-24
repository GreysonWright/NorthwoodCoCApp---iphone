//
//  NetworkStatus.m
//  NorthwoodCoC
//
//  Created by greyson on 7/15/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "NetworkStatus.h"

@implementation NetworkStatus

static networkTooSlow;

+(BOOL)networkExists{
	NSURL *Url = [NSURL URLWithString:@"http://justchristians.info/"];
	NSURLRequest *request = [NSURLRequest requestWithURL:Url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:8];
    //NSData *htmlData = [NSData dataWithContentsOfURL:Url];
	//NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
	NSHTTPURLResponse* response = nil;
	NSError* error = nil;
	NSData *connection = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if(connection == nil){
		NSLog(@"error %@",error);
		NSLog(@"response %@",response);
		NSLog(@"no network");
		return NO;
	}
	
	else{
		NSLog(@"network available");
		return YES;
	}
}
@end
