//
//  ContactUsViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ContactUs.h"
#import "ContactUsTableViewCell.h"
#import "SettingsViewController.h"
#import "MailRequestViewController.h"
#import "LogginginViewController.h"
#import "NewsLoggedinViewController.h"
#import "NetworkStatus.h"

@interface ContactUsViewController (){
	//NSMutableArray *_titleObjects;
	NSMutableArray *_evangelistObjects;
	NSMutableArray *_elderObjects;
	NSMutableArray *_deaconObjects;
	NSMutableArray *_emailObjects;
	NSMutableArray *_bareTitleObjects;
	NSMutableArray *_bareEvangelistObjects;
	NSMutableArray *_bareElderObjects;
	NSMutableArray *_bareDeaconObjects;
	NSMutableArray *_bareEmailObjects;
}

@end

@implementation ContactUsViewController

BOOL offlineMode;

-(void)loadStuff{
	if([NetworkStatus networkExists]){
		dispatch_async(dispatch_get_main_queue(), ^{
		//	_titleObjects = nil;
			_elderObjects = nil;
			_deaconObjects = nil;
			_evangelistObjects = nil;
			_emailObjects = nil;
			_bareTitleObjects = nil;
			_bareEvangelistObjects = nil;
			_bareElderObjects = nil;
			_bareDeaconObjects = nil;
			_bareEmailObjects = nil;
			//_titleObjects = [ContactUs titleObjects];
			_elderObjects = [ContactUs elderObjects];
			_deaconObjects = [ContactUs deaconObjects];
			_evangelistObjects = [ContactUs evangelistObjects];
			_emailObjects = [ContactUs emailObjects];
			_bareTitleObjects = [ContactUs bareTitleObjects];
			_bareEvangelistObjects = [ContactUs bareEvangelistObjects];
			_bareElderObjects = [ContactUs bareElderObjects];
			_bareDeaconObjects = [ContactUs bareDeaconObjects];
			_bareEmailObjects = [ContactUs bareEmailObjects];
			[self.tableView reloadData];
			offlineMode = NO;
		});
	}
	else
		NSLog(@"dont load data");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Contact Us";
		self.navigationItem.title = self.title;
		//_titleObjects = [[NSMutableArray alloc]init];
		_elderObjects = [[NSMutableArray alloc]init];
		_deaconObjects = [[NSMutableArray alloc]init];
		_evangelistObjects = [[NSMutableArray alloc]init];
		_emailObjects = [[NSMutableArray alloc]init];
		_bareTitleObjects = [[NSMutableArray alloc]init];
		_bareElderObjects = [[NSMutableArray alloc]init];
		_bareDeaconObjects = [[NSMutableArray alloc]init];
		_bareEvangelistObjects = [[NSMutableArray alloc]init];
		_bareEmailObjects = [[NSMutableArray alloc]init];
		
		if([NetworkStatus networkExists]){
			//_titleObjects = [ContactUs titleObjects];
			_elderObjects = [ContactUs elderObjects];
			_deaconObjects = [ContactUs deaconObjects];
			_evangelistObjects = [ContactUs evangelistObjects];
			_emailObjects = [ContactUs emailObjects];
			_bareTitleObjects = [ContactUs bareTitleObjects];
			_bareEvangelistObjects = [ContactUs bareEvangelistObjects];
			_bareElderObjects = [ContactUs bareElderObjects];
			_bareDeaconObjects = [ContactUs bareDeaconObjects];
			_bareEmailObjects = [ContactUs bareEmailObjects];
			
			//[[NSUserDefaults standardUserDefaults]setObject:_bareTitleObjects forKey:@"bareTitleObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareEvangelistObjects forKey:@"bareEvangelistObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareElderObjects forKey:@"bareElderObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareDeaconObjects forKey:@"baredeaconObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareEmailObjects forKey:@"bareEmailObjects"];
			offlineMode = NO;
		}
		else if(![NetworkStatus networkExists]){
			//_bareTitleObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareTitleObjects"];
			_bareEvangelistObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareEvangelistObjects"];
			_bareElderObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareElderObjects"];
			_bareDeaconObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"baredeaconObjects"];
			_bareEmailObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareEmailObjects"];
			offlineMode = YES;
			NSLog([_bareEmailObjects objectAtIndex:0]);
		}
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
		
		//this will be enabled once the backend is built
		
		//self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Mail Request" style:UIBarButtonItemStylePlain target:self action:@selector(requestTitleButtonTapped)];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
	if([self needsToReload])
		if([NetworkStatus networkExists])
			dispatch_async(dispatch_get_main_queue(), ^{
				[self loadStuff];
			});
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
- (IBAction)locatButtonTapped:(id)sender {
	  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://maps.apple.com?q=northwood+church+of+christ+tuscaloosa+alabama"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(!offlineMode){
		if(section == 0)
			return _evangelistObjects.count;
		else if(section == 1)
			return _elderObjects.count;
		else if (section == 2)
			return _deaconObjects.count;
		
		return 0;
	}
	else{
		if(section == 0)
			return _bareEvangelistObjects.count;
		else if(section == 1)
			return _bareElderObjects.count;
		else if (section == 2)
			return _bareDeaconObjects.count;
			
		return 0;
	}
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0)
		return @"Evangelists";
	if(section == 1)
		return @"Elders";
	if(section == 2)
		return @"Deacons";
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 73;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	ContactUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactUsCell"];
	
    if (cell==nil) {
		cell = [[ContactUsTableViewCell alloc] init];
    }
	if(!offlineMode){
		ContactUs *contactEmail = [_emailObjects objectAtIndex:indexPath.row];
		if(indexPath.section == 0){
			ContactUs *evangelists = [_evangelistObjects objectAtIndex:indexPath.row];
			[cell fillNameWithData:evangelists];
			[cell fillEmailWithData:contactEmail];
		}
		else if(indexPath.section == 1){
			ContactUs *elders = [_elderObjects objectAtIndex:indexPath.row];
			[cell fillNameWithData:elders];
			[cell fillEmailWithData:contactEmail];
		}
		else if(indexPath.section == 2){
			ContactUs *deacons = [_deaconObjects objectAtIndex:indexPath.row];
			[cell fillNameWithData:deacons];
			[cell fillEmailWithData:contactEmail];
		}
		//ContactUs *contactTitle = [_titleObjects objectAtIndex:indexPath.row];
		//[cell fillTitleWithData:contactTitle];
		//[cell fillNameWithData:contactName];
	}
	else if(offlineMode){
		//[cell fillTitleWithBareData:[_bareTitleObjects objectAtIndex:indexPath.row]];
		NSString *contactEmail = [_bareEmailObjects objectAtIndex:indexPath.row];
		if(indexPath.section == 0){
			NSString *evangelists = [_bareEvangelistObjects objectAtIndex:indexPath.row];
			[cell fillNameWithBareData:evangelists];
			[cell fillEmailWithBareData:contactEmail];
		}
		else if(indexPath.section == 1){
			NSString *elders = [_bareElderObjects objectAtIndex:indexPath.row];
			[cell fillNameWithBareData:elders];
			[cell fillEmailWithBareData:contactEmail];
		}
		else if(indexPath.section == 2){
			NSString *deacons = [_bareDeaconObjects objectAtIndex:indexPath.row];
			[cell fillNameWithBareData:deacons];
			[cell fillEmailWithBareData:contactEmail];
		}

	}
	
    return cell;
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}

-(void)requestTitleButtonTapped{
		MailRequestViewController *requestView = [[MailRequestViewController alloc]init];
		[self.navigationController pushViewController:requestView animated:YES];
	
}

-(BOOL)needsToReload{
	if(_emailObjects.count == 0){
		NSLog(@"reload");
		return YES;
	}
	else{
		NSLog(@"doesnt need to reload");
		return NO;
	}
}
@end
