//
//  MailRequestViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/30/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "MailRequestViewController.h"
#import "LogginginViewController.h"
#import "NewsLoggedinViewController.h"

@interface MailRequestViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *blind;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation MailRequestViewController

static BOOL requesting;
static BOOL stillPresented;
int alertIndex;

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
	if([[NSUserDefaults standardUserDefaults]boolForKey:@"loggedIn"] == NO){
		[self.navigationController presentViewController:[[LogginginViewController alloc]init] animated:YES completion:nil];
	}
	else
		NSLog(@"%d",[[NSUserDefaults standardUserDefaults]boolForKey:@"loggedIn"]);
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

-(void)viewDidAppear:(BOOL)animated{
	if(stillPresented == NO && [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"] == NO){
		[self.navigationController popToRootViewControllerAnimated:YES];
		NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"]);
	}
	else{
		//do stuff here
		NSLog(@"yayaya");
	}
}

- (IBAction)submitButtonPressed:(id)sender {
	
	NSLog(@"submit stuff yayayaya");
    [[[UIAlertView alloc]initWithTitle:@"Success!!!" message:@"Your mail request has been submitted and will now be reviewed." delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil] show];
	alertIndex = 0;
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

+(void)setLoginStillPresented:(BOOL)input{
	stillPresented = input;
}

+(BOOL)loginStillPresented{
	return stillPresented;
}
@end
