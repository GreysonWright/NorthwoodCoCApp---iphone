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
}

@end

@implementation ContactUsViewController

-(void)loadStuff{
	if([NetworkStatus networkExists]){
		dispatch_async(dispatch_get_main_queue(), ^{
			_titleObjects = nil;
			_nameObjects = nil;
			_emailObjects = nil;
			_titleObjects = [ContactUs titleObjects];
			_nameObjects = [ContactUs nameObjects];
			_emailObjects = [ContactUs emailObjects];
			[self.tableView reloadData];
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
		_titleObjects = [ContactUs titleObjects];
		_nameObjects = [ContactUs nameObjects];
		_emailObjects = [ContactUs emailObjects];
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
    return _nameObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	ContactUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactUsCell"];
	//ContactUs *contactTitle = [_titleObjects objectAtIndex:indexPath.row];
	ContactUs *contactName = [_nameObjects objectAtIndex:indexPath.row];
	ContactUs *contactEmail = [_emailObjects objectAtIndex:indexPath.row];
	
    if (cell==nil) {
		cell = [[ContactUsTableViewCell alloc] init];
    }
	//[cell fillTitleWithData:contactTitle];
	[cell fillNameWithData:contactName];
	[cell fillEmailWithData:contactEmail];
	
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
