//
//  NetworkStatus.m
//  NorthwoodCoC
//
//  Created by greyson on 7/15/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "NetworkStatus.h"

@implementation NetworkStatus

static BOOL slowNetwork;

+(BOOL)networkExists{
		if(slowNetwork == NO){
		NSURL *Url = [NSURL URLWithString:@"http://justchristians.info/"];
		NSURLRequest *request = [NSURLRequest requestWithURL:Url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3];
		//NSData *htmlData = [NSData dataWithContentsOfURL:Url];
		//NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
		NSHTTPURLResponse* response = nil;
		NSError* error = nil;
		NSData *connection = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
		NSString *errorStirng = [NSString stringWithFormat:@"%@", error ];
	
		if(connection == nil && [errorStirng rangeOfString:@"offline"].location != NSNotFound){
			NSLog(@"no network");
			NSLog(@"error %@",error);
			NSLog(@"response %@",response);
			return NO;
		}
	
		else if(connection == nil && [errorStirng rangeOfString:@"timed"].location != NSNotFound){
			NSLog(@"no network");
			NSLog(@"error %@",error);
			NSLog(@"response %@",response);
			slowNetwork = YES;
			return NO;
		}
	
		else{
			NSLog(@"network available");
			NSLog(@"error %@",error);
			NSLog(@"response %@",response);
			return YES;
		}
	}
	else if(slowNetwork == YES){
		NSLog(@"slow network");
		return NO;
	}
	
	return 0;
}

+(void)setSlowNetwork:(BOOL)slow{
	slowNetwork = slow;
}
@end
