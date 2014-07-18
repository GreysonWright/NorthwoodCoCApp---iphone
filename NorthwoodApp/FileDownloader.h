//
//  FileDownloader.h
//  NorthwoodCoC
//
//  Created by greyson on 7/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloader : NSObject

+(void)downloadPDFWithURL:(NSString*)link withFileName:(NSString*)fileName;

@end
