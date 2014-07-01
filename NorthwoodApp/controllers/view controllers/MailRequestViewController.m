//
//  MailRequestViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/30/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "MailRequestViewController.h"

@interface MailRequestViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *blind;

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

- (IBAction)submitButtonPressed:(id)sender {
	
	NSLog(@"submit stuff yayayaya");
	UIAlertView *submitAlert = [[UIAlertView alloc]initWithTitle:@"Success!!!!" message:@"Your mail request has been submitted and will now be reviewed." delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
    [submitAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[self.navigationController popToRootViewControllerAnimated:YES];
	/*if(buttonIndex == 0){
		NSLog(@"User cancelled logout");
	}
	else{
		NSLog(@"impossible");
	} */
}


+(BOOL)getRequest{
	return requesting;
}

+(void)setRequesting:(BOOL)request{
	requesting = request;
}
@end
