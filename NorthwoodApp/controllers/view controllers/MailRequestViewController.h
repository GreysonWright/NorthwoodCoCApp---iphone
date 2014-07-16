//
//  MailRequestViewController.h
//  NorthwoodCoC
//
//  Created by greyson on 6/30/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailRequestViewController : UIViewController

+(BOOL)getRequest;
+(void)setRequesting:(BOOL)request;
+(void)setLoginStillPresented:(BOOL)input;
+(BOOL)loginStillPresented;

@end
