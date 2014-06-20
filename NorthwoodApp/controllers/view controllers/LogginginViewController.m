//
//  LogginginViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/20/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "LogginginViewController.h"
#import "NewsLoggedinViewController.h"

@interface LogginginViewController ()
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
}

@end
