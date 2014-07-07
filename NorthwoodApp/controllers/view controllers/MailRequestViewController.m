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
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"done" style:UIBarButtonItemStylePlain target:self action:@selector(doneTitleButtonTapped)];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text  isEqual: @""]){
		self.blind.hidden = NO;
		self.submitButton.enabled = NO;
	}
	
	else{
		self.blind.hidden = YES;
		self.submitButton.enabled = YES;
	}
}

- (IBAction)submitButtonPressed:(id)sender {
	
	NSLog(@"submit stuff yayayaya");
	UIAlertView *submitAlert = [[UIAlertView alloc]initWithTitle:@"Success!!!!" message:@"Your mail request has been submitted and will now be reviewed." delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
    [submitAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[self.navigationController popToRootViewControllerAnimated:YES];
	/*if(buttonIndex == 0){
		NSLog(@"i dont remember what this does");
	}
	else{
		NSLog(@"impossible");
	} */
}

-(void)doneTitleButtonTapped{
	[self.textView resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
}

+(BOOL)getRequest{
	return requesting;
}

+(void)setRequesting:(BOOL)request{
	requesting = request;
}
@end
