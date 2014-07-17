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
	NSMutableArray *_titleObjects;
	NSMutableArray *_nameObjects;
	NSMutableArray *_emailObjects;
	NSMutableArray *_bareTitleObjects;
	NSMutableArray *_bareNameObjects;
	NSMutableArray *_bareEmailObjects;
}

@end

@implementation ContactUsViewController

BOOL offlineMode;

-(void)loadStuff{
	if([NetworkStatus networkExists]){
		dispatch_async(dispatch_get_main_queue(), ^{
			_titleObjects = nil;
			_nameObjects = nil;
			_emailObjects = nil;
			_bareTitleObjects = nil;
			_bareNameObjects = nil;
			_bareEmailObjects = nil;
			_titleObjects = [ContactUs titleObjects];
			_nameObjects = [ContactUs nameObjects];
			_emailObjects = [ContactUs emailObjects];
			_bareTitleObjects = [ContactUs bareTitleObjects];
			_bareNameObjects = [ContactUs bareNameObjects];
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
		_titleObjects = [[NSMutableArray alloc]init];
		_nameObjects = [[NSMutableArray alloc]init];
		_emailObjects = [[NSMutableArray alloc]init];
		_bareTitleObjects = [[NSMutableArray alloc]init];
		_bareNameObjects = [[NSMutableArray alloc]init];
		_bareEmailObjects = [[NSMutableArray alloc]init];
		
		if([NetworkStatus networkExists]){
			_titleObjects = [ContactUs titleObjects];
			_nameObjects = [ContactUs nameObjects];
			_emailObjects = [ContactUs emailObjects];
			_bareTitleObjects = [ContactUs bareTitleObjects];
			_bareNameObjects = [ContactUs bareNameObjects];
			_bareEmailObjects = [ContactUs bareEmailObjects];
			
			//[[NSUserDefaults standardUserDefaults]setObject:_bareTitleObjects forKey:@"bareTitleObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareNameObjects forKey:@"bareNameObjects"];
			[[NSUserDefaults standardUserDefaults]setObject:_bareEmailObjects forKey:@"bareEmailObjects"];
			offlineMode = NO;
		}
		else if(![NetworkStatus networkExists]){
			//_bareTitleObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareTitleObjects"];
			_bareNameObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareNameObjects"];
			_bareEmailObjects = [[NSUserDefaults standardUserDefaults]objectForKey:@"bareEmailObjects"];
			offlineMode = YES;
			NSLog([_bareEmailObjects objectAtIndex:0]);
		}
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
		
		self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Mail Request" style:UIBarButtonItemStylePlain target:self action:@selector(requestTitleButtonTapped)];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if([NetworkStatus networkExists])
		return _nameObjects.count;
	else
		return _bareNameObjects.count;
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
		//ContactUs *contactTitle = [_titleObjects objectAtIndex:indexPath.row];
		ContactUs *contactName = [_nameObjects objectAtIndex:indexPath.row];
		ContactUs *contactEmail = [_emailObjects objectAtIndex:indexPath.row];
		//[cell fillTitleWithData:contactTitle];
		[cell fillNameWithData:contactName];
		[cell fillEmailWithData:contactEmail];
	}
	else if(offlineMode){
		//[cell fillTitleWithBareData:[_bareTitleObjects objectAtIndex:indexPath.row]];
		[cell fillNameWithBareData:[_bareNameObjects objectAtIndex:indexPath.row]];
		[cell fillEmailWithBareData:[_bareEmailObjects objectAtIndex:indexPath.row]];
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
	if(_nameObjects.count == 0){
		NSLog(@"reload");
		return YES;
	}
	else{
		NSLog(@"doesnt need to reload");
		return NO;
	}
}
@end
