//
//  NewsViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/13/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsLoggedinViewController.h"

@interface NewsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title=@"Members";
		self.tabBarItem.title=self.title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.usernameTextField setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)logginButtonTapped:(id)sender {
	NewsLoggedinViewController *newsLoggedinView = [[NewsLoggedinViewController alloc]init];
	//[self.navigationController pushViewController:newsLoggedinView animated:YES];
	//[self.navigationController presentModalViewController:newsLoggedinView animated:YES]; //this changes the root view controller e.e
	newsLoggedinView.title=@"Bulletins";
}

@end
