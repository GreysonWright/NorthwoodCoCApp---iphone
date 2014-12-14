//
//  PDFCleaner.m
//  NorthwoodCoC
//
//  Created by greyson on 12/14/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "PDFCleaner.h"

@implementation PDFCleaner

+(void)cleanPDFObjects{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSFileManager *fileManager = [[NSFileManager alloc]init];
	NSError *error;
	NSArray *fileObjects = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error];
	//NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yy"];
	NSString *currentDateString = [formatter stringForObjectValue:[NSDate date]];
	
	for (int i=0; i<fileObjects.count; i++) {
		
		NSString *fileObject =[fileObjects objectAtIndex:i];
		NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileObject];
		if ([fileObject rangeOfString:@"Duty"].location != NSNotFound || [fileObject rangeOfString:@"Prayer"].location != NSNotFound) {
			NSLog(@"excluding %@",fileObject);
		}
		
		else{
			NSArray *compareWithObjects = [fileObject componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
			NSInteger compareYear = [[compareWithObjects objectAtIndex:compareWithObjects.count -1] integerValue];
			NSInteger currentYear = [currentDateString integerValue];
			//			NSInteger currentYear = 15;
			
			if (compareYear < currentYear) {
				NSLog(@"delete %@ because %ld < %ld", fileObject, (long)compareYear, (long)currentYear);
				if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
					[fileManager removeItemAtPath:dataPath error:&error];
				else
					NSLog(@"%@", error);
			}
			else{
				NSLog(@"don't delete %@ because %ld >= %ld",fileObject ,(long)compareYear, (long)currentYear);
			}
			
		}
	}
}

@end
