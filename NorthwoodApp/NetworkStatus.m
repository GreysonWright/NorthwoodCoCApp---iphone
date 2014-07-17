//
//  NetworkStatus.m
//  NorthwoodCoC
//
//  Created by greyson on 7/15/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "NetworkStatus.h"
#import "TFHpple.h"

@implementation NetworkStatus

static BOOL networkExistsBool = YES;

+(BOOL)networkExists{
	NSURL *Url = [NSURL URLWithString:@"http://justchristians.info/"];
    NSData *htmlData = [NSData dataWithContentsOfURL:Url];
	
	if(htmlData == nil){
		NSLog(@"no network");
		return NO;
	}
	
	else{
		NSLog(@"network available");
		return YES;
	}
}
@end
