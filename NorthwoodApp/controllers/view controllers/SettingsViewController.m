//
//  SettingsViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *pushLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *dutyLabel;
@property (strong, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *groupSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *eventSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *tweetSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *dutySwitch;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title=@"4";
		self.tabBarItem.title=self.title;
		
    }
    return self;
}

- (void)viewDidLoad
{
	
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)objectsEnabled:(BOOL)input{
	self.groupSwitch.enabled = input;
	self.groupLabel.enabled = input;
	self.eventSwitch.enabled = input;
	self.eventLabel.enabled = input;
	self.tweetSwitch.enabled = input;
	self.tweetLabel.enabled = input;
	self.dutySwitch.enabled = input;
	self.dutyLabel.enabled = input;
}

- (IBAction)pushSwitchChanged:(id)sender {
	if(self.pushSwitch.isOn == YES)
		[self objectsEnabled:YES];
	else
		[self objectsEnabled:NO];
}
- (IBAction)groupSwitchChanged:(id)sender {
}
- (IBAction)eventSwitchChanged:(id)sender {
}
- (IBAction)tweetSwitchChanged:(id)sender {
}
- (IBAction)dutySwitchChanged:(id)sender {
}
@end
