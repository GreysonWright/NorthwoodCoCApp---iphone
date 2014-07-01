//
//  MailRequestViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/30/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "MailRequestViewController.h"

@interface MailRequestViewController ()

@end

@implementation MailRequestViewController

static BOOL requesting;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mail Request";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(BOOL)getRequest{
	return requesting;
}

+(void)setRequesting:(BOOL)request{
	requesting = request;
}
@end
