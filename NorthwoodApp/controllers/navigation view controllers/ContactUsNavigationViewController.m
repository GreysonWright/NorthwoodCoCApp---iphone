//
//  ContactUsNavigationViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "ContactUsNavigationViewController.h"

@interface ContactUsNavigationViewController ()

@end

@implementation ContactUsNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.navigationBar.barTintColor = [UIColor colorWithRed:45.0/255.0f green:45.0/255.0f blue:48.0/255.0f alpha:1];
		[self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
