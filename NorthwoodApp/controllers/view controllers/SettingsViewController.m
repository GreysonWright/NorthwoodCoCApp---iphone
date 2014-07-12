//
//  SettingsViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *pushLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *dutyLabel;
@property (strong, nonatomic) IBOutlet UILabel *dailyVerseLabel;
@property (strong, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *groupSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *eventSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *tweetSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *dutySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *dailyVerse;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title=@"Settings";
		self.tabBarItem.title=self.title;
		
    }
    return self;
}

- (void)viewDidLoad{
	[self loadState];
	[super viewDidLoad];
	if(self.pushSwitch.isOn == NO)
		[self objectsEnabled:NO];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveState{
	
	[[NSUserDefaults standardUserDefaults] setBool:self.pushSwitch.isOn forKey:@"pushSwitch"];
	[[NSUserDefaults standardUserDefaults] setBool:self.groupSwitch.isOn forKey:@"groupSwitch"];
	[[NSUserDefaults standardUserDefaults] setBool:self.eventSwitch.isOn forKey:@"eventSwitch"];
	[[NSUserDefaults standardUserDefaults] setBool:self.tweetSwitch.isOn forKey:@"tweetSwitch"];
	[[NSUserDefaults standardUserDefaults] setBool:self.dutySwitch.isOn forKey:@"dutySwitch"];
	[[NSUserDefaults standardUserDefaults] setBool:self.dailyVerse.isOn forKey:@"verseSwitch"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadState{
	
	[self.pushSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"pushSwitch"] animated:YES];
	[self.groupSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"groupSwitch"] animated:YES];
	[self.eventSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"eventSwitch"] animated:YES];
	[self.tweetSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"tweetSwitch"] animated:YES];
	[self.dutySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"dutySwitch"] animated:YES];
	[self.dailyVerse setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"verseSwitch"] animated:YES];
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
	self.dailyVerse.enabled = input;
	self.dailyVerseLabel.enabled = input;
}

- (IBAction)pushSwitchChanged:(id)sender {
	if(self.pushSwitch.isOn == YES)
		[self objectsEnabled:YES];
	else
		[self objectsEnabled:NO];
	
	[self saveState];
}

- (IBAction)groupSwitchChanged:(id)sender {
	[self saveState];
}

- (IBAction)eventSwitchChanged:(id)sender {
	[self saveState];
}

- (IBAction)tweetSwitchChanged:(id)sender {
	[self saveState];
}

- (IBAction)dutySwitchChanged:(id)sender {
	[self saveState];
}

- (IBAction)verseSwitchChanged:(id)sender {
	[self saveState];
}
@end
