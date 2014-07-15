//
//  Directory.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "Directory.h"

@implementation Directory //@#$!@#$!@#$!#@$get pics for directory

@synthesize nameValue = _nameValue;
@synthesize titleValue = _titleValue;
@synthesize phoneValue = _phoneValue;
@synthesize emailValue = _emailValue;
@synthesize addressValue = _addressValue;

+(NSMutableArray*)nameObjects{
	NSMutableArray *theseObjects = [[NSMutableArray alloc]init];
	[theseObjects addObject:@"Jason Wright"];
	[theseObjects addObject:@"Kim Wright"];
	[theseObjects addObject:@"Ellie Wright"];
	[theseObjects addObject:@"Greyson Wright"];
	return theseObjects;
}

+(NSMutableArray*)titleObjects{
	NSMutableArray *theseObjects = [[NSMutableArray alloc]init];
	[theseObjects addObject:@"deacon"];
	[theseObjects addObject:@"member"];
	[theseObjects addObject:@"member"];
	[theseObjects addObject:@"member"];
	return theseObjects;
}

+(NSMutableArray*)phoneObjects{
	NSMutableArray *theseObjects = [[NSMutableArray alloc]init];
	[theseObjects addObject:@"2055614428"];
	[theseObjects addObject:@"2054548738"];
	[theseObjects addObject:@"2054549899"];
	[theseObjects addObject:@"2053936552"];
	return theseObjects;
}

+(NSMutableArray*)emailObjects{
	NSMutableArray *theseObjects = [[NSMutableArray alloc]init];
	[theseObjects addObject:@"jwright@cs.ua.edu"];
	[theseObjects addObject:@"kwright@cs.ua.edu"];
	[theseObjects addObject:@"elliewright51@gmail.com"];
	[theseObjects addObject:@"greysonmwright@gmail.com"];
	return theseObjects;
}

+(NSMutableArray*)adressObjects{
	NSMutableArray *theseObjects = [[NSMutableArray alloc]init];
	
	[theseObjects addObject:@"5711 Bradford ln Tuscaloosa AL"];
	[theseObjects addObject:@"5711 Bradford ln Tuscaloosa AL"];
	[theseObjects addObject:@"5711 Bradford ln Tuscaloosa AL"];
	[theseObjects addObject:@"5711 Bradford ln Tuscaloosa AL"];
	return theseObjects;
}
@end
