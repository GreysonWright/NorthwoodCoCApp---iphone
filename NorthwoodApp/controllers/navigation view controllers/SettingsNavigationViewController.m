//
//  SettingsNavigationViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 10/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SettingsNavigationViewController.h"

@interface SettingsNavigationViewController ()

@end

@implementation SettingsNavigationViewController

- (void)viewDidLoad {
	self.navigationBar.barTintColor = [UIColor colorWithRed:45.0/255.0f green:45.0/255.0f blue:48.0/255.0f alpha:1];
	[self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
