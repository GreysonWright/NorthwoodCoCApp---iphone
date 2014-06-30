//
//  NewsLoggedinViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/16/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsLoggedinViewController.h"
#import "TFHpple.h"
#import "Bulletin.h"
#import "BulletinTableViewCell.h"
#import "PrayerList.h"
#import "PrayerListTableViewCell.h"
#import "DutyRoster.h"
#import "DutyRosterTableViewCell.h"
#import "LogginginViewController.h"
#import "Directory.h"
#import "DirectoryTableViewCell.h"
#import "UniversalWebViewViewController.h"
#import "SettingsViewController.h"

@interface NewsLoggedinViewController (){
	NSMutableArray *_bulletinObjects;
	NSMutableArray *_prayerListObjects;
	NSMutableArray *_dutyRosterObjects;
	NSMutableArray *_nameObjects;
	NSMutableArray *_titleObjects;
	NSMutableArray *_phoneObjects;
	NSMutableArray *_emailObjects;
	NSMutableArray *_addressObjects;
	NSMutableArray *_linksForWebView;
	NSString *_bulletinEndURL;
	int _selectedSegment;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController; //add a directory button
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NewsLoggedinViewController
static BOOL loggedin;


- (IBAction)segmentsChanged:(id)sender {
	if(self.segmentController.selectedSegmentIndex == 0){
		_selectedSegment = 0;
	}
	else if(self.segmentController.selectedSegmentIndex == 1){
		_selectedSegment = 1;
	}
	else if(self.segmentController.selectedSegmentIndex == 2){
		_selectedSegment = 2;
	}
	else if (self.segmentController.selectedSegmentIndex == 3){
		_selectedSegment = 3;
	}
	[self.tableView reloadData];
	[self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 125) animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_bulletinObjects = [[NSMutableArray alloc]init];
		_prayerListObjects = [[NSMutableArray alloc]init];
		_dutyRosterObjects = [[NSMutableArray alloc]init];
		_nameObjects = [[NSMutableArray alloc]init];
		_titleObjects = [[NSMutableArray alloc]init];
		_phoneObjects = [[NSMutableArray alloc]init];
		_emailObjects = [[NSMutableArray alloc]init];
		_addressObjects = [[NSMutableArray alloc]init];
		_linksForWebView = [[NSMutableArray alloc]init];
		_bulletinObjects = [Bulletin bulletinObject];
		_prayerListObjects = [PrayerList prayerListObjects];
		_dutyRosterObjects = [DutyRoster dutyRosterObjects];
		_nameObjects = [Directory nameObjects];
		_titleObjects = [Directory titleObjects];
		_phoneObjects = [Directory phoneObjects];
		_emailObjects = [Directory emailObjects];
		_addressObjects = [Directory adressObjects];
		_selectedSegment = 0;
		self.title=@"Members";
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	loggedin = [[NSUserDefaults standardUserDefaults]boolForKey:@"loggedIn"];
	if(loggedin == NO){
		self.segmentController.selectedSegmentIndex = 0;
		_selectedSegment = 0;
		LogginginViewController *logginView = [[LogginginViewController alloc]init];
		[self presentViewController:logginView animated:YES completion:nil];
		[self.tableView reloadData];
	}
	else if(loggedin == YES){
		[self.tableView reloadData];
	}
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutTitleButtonTapped)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger returnThis;
	if(_selectedSegment == 0){
		returnThis = _bulletinObjects.count;
	}
	else if(_selectedSegment == 1){
		returnThis = _prayerListObjects.count;
	}
	else if(_selectedSegment == 2){
		returnThis = _dutyRosterObjects.count;
	}
	else if (_selectedSegment == 3){
		returnThis = _nameObjects.count;
	}
    return returnThis;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	int returnThis;
	if(_selectedSegment == 0){
		returnThis = 73;
	}
	else if(_selectedSegment == 1){
		returnThis = 700;
	}
	else if(_selectedSegment == 2){
		returnThis = 700;
	}
	else if (_selectedSegment == 3){
		returnThis = 109;
	}
	return returnThis;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(_selectedSegment == 0){
		UniversalWebViewViewController *webView= [[UniversalWebViewViewController alloc]init];
		[webView loadBulletinPDF:[_linksForWebView objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:webView animated:YES];
	}
	else if(_selectedSegment == 1){
		NSLog(@"do nothing");
	}
	else if(_selectedSegment == 2){
		NSLog(@"do nothing");
	}
	else if (_selectedSegment == 3){
		NSLog(@"do nothing");
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *returnThis;
	
	if(_selectedSegment == 0){ //bulletin
			self.navigationController.navigationBar.topItem.title = [@"Welcome, " stringByAppendingString:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
			
		BulletinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BulletinCell"];
		Bulletin *thisBulletin = [_bulletinObjects objectAtIndex:indexPath.row];
		
		if (cell == nil) {
			cell = [[BulletinTableViewCell alloc] init];
		}
		[cell fillWithData:thisBulletin];
		[_linksForWebView addObject:thisBulletin.bulletinLink];
		returnThis = cell;
	}
	
	else if(_selectedSegment == 1){ //prayerlist
		PrayerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrayerListCell"];
		PrayerList *thisPrayerList = [_prayerListObjects objectAtIndex:indexPath.row];
		if (cell==nil) {
			cell = [[PrayerListTableViewCell alloc] init];
		}
		[cell fillWithData:thisPrayerList];
		returnThis = cell;
	}
	
	else if(_selectedSegment == 2){
		DutyRosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DutyRosterCell"];
		DutyRoster *thisDutyRoster = [_dutyRosterObjects objectAtIndex:indexPath.row];
		if (cell==nil) {
			cell = [[DutyRosterTableViewCell alloc] init];
		}
		[cell fillWithData:thisDutyRoster];
		returnThis = cell;
	}
	
	else if (_selectedSegment == 3){
		DirectoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DirectoryCell"];
		Directory *thisName = [_nameObjects objectAtIndex:indexPath.row];
		Directory *thisTitle = [_titleObjects objectAtIndex:indexPath.row];
		Directory *thisPhone = [_phoneObjects objectAtIndex:indexPath.row];
		Directory *thisEmail = [_emailObjects objectAtIndex:indexPath.row];
		Directory *thisAddress = [_addressObjects objectAtIndex:indexPath.row];
		if (cell == nil) {
			cell = [[DirectoryTableViewCell alloc] init];
		}
		[cell fillNameWithData:thisName];
		[cell fillTitleWithData:thisTitle];
		[cell fillPhoneWithData:thisPhone];
		[cell fillEmailWithData:thisEmail];
		[cell fillAddressWithData:thisAddress];
		
		returnThis = cell;
	}
	
    return returnThis;
}

+(void)setLoggedin:(BOOL)newLoggedin{
	loggedin = newLoggedin;
}

+(BOOL)getLoggedin{
	return loggedin;
}

-(void)logoutTitleButtonTapped{
	UIAlertView *loggoutWarning = [[UIAlertView alloc]initWithTitle:@"logout?" message:@"Are you sure you would like to logout?" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
    [loggoutWarning show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSLog(@"User cancelled logout");
	}
	else{
		[alertView dismissWithClickedButtonIndex:-1 animated:YES];
		loggedin = NO;
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loggedIn"];
		[[NSUserDefaults standardUserDefaults] setObject:@"Members" forKey:@"username"];
		[[NSUserDefaults standardUserDefaults]synchronize];
		AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
		appDelegate.tabBar.selectedIndex=0;
	}
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}
@end