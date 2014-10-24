//
//  LogginginViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/20/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "LogginginViewController.h"
#import "NewsLoggedinViewController.h"
#import "AppDelegate.h"
#import "MailRequestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"

@interface LogginginViewController (){
	NSString *passwordString;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameBox;
@property (weak, nonatomic) IBOutlet UITextField *passwordBox;

@end

@implementation LogginginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.usernameBox.delegate = self;
	self.passwordBox.delegate = self;
	[MailRequestViewController setLoginStillPresented:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTapped:(id)sender {
	if([self.usernameBox.text  isEqual: @"member"] && [self.passwordBox.text  isEqual: @"NorthwoodCoC"]){
		[self dismissViewControllerAnimated:YES completion:nil];
		[NewsLoggedinViewController setLoggedin:YES];
		[MailRequestViewController setLoginStillPresented:YES];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
		[[NSUserDefaults standardUserDefaults] setObject:[self.usernameBox text] forKey:@"username"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	else{
		[[[UIAlertView alloc]initWithTitle:@"Login Error" message:@"The username or password provided was incorrect." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
	}
}

- (IBAction)cancelButtonTapped:(id)sender {
	[NewsLoggedinViewController isSwitching];
	[self dismissViewControllerAnimated:YES completion:nil];
//	AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
//	appDelegate.tabBar.selectedIndex=0;
	[SlidingMenuController resetMenu];
	[MailRequestViewController setLoginStillPresented:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	[textField resignFirstResponder];
    return NO;
}
@end
