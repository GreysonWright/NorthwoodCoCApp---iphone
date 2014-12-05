//
//  SermonsViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/13/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SermonsViewController.h"
#import "TFHpple.h"
#import "Sermon.h"
#import "Sermons2010ViewController.h"
#import "SermonDateTableViewCell.h"
#import "SettingsViewController.h"
#import "SlidingMenuController.h"
#import "SermonYear.h"
#import "NetworkStatus.h"

@interface SermonsViewController (){
	NSMutableArray *_years;
	UIView *_offlineView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *loadingView;

@end

@implementation SermonsViewController

-(void)offlineViewSetUp{
	if(!_offlineView)
	{
		_offlineView = [[UIView alloc] initWithFrame:self.view.frame];
		_offlineView.alpha = .85;
		[_offlineView setBackgroundColor:[UIColor blackColor]];
		
		UILabel *offlineLabel = [[UILabel alloc] initWithFrame:CGRectMake((0), (250), 320, 30)];
		offlineLabel.text = @"Network Unavailable";
		offlineLabel.backgroundColor = [UIColor blackColor];
		offlineLabel.textColor = [UIColor whiteColor];
		[offlineLabel setTextAlignment:NSTextAlignmentCenter];
		
		[_offlineView addSubview:offlineLabel];
	}
	[self.view addSubview:_offlineView];
}

-(void)loadingViewSetup{
	if(!_loadingView)
	{
		_loadingView = [[UIView alloc] initWithFrame:self.view.frame];
		_loadingView.alpha = .85;
		[_loadingView setBackgroundColor:[UIColor blackColor]];
		
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		//[indicator setFrame:CGRectMake((160), (180), 0, 0)];
		indicator.center = CGPointMake(_loadingView.center.x, (_loadingView.center.y - 40));
		UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((0), (210), 320, 30)];
		loadingLabel.center = _loadingView.center;
		loadingLabel.textColor = [UIColor whiteColor];
		[loadingLabel setTextAlignment:NSTextAlignmentCenter];
		loadingLabel.text = @"Loading";
		
		[_loadingView addSubview:indicator];
		[_loadingView addSubview:loadingLabel];
		
		[indicator startAnimating];
	}
	
	[self.tableView addSubview:_loadingView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title=@"Sermons";
		self.tabBarItem.image = [UIImage imageNamed:@"read2.png"];
		//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"list26"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
		self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
//		_years=[[NSMutableArray alloc] initWithObjects:@"2009", @"2010", @"2011", @"2012", @"2013", @"2014", nil];
		if([NetworkStatus networkExists])
			_years = [SermonYear getSermonYearObjects];
		else
			[self offlineViewSetUp];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _years.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SermonDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
	NSString *newYear = [_years objectAtIndex:indexPath.row];
    if (cell==nil) {
		cell = [[SermonDateTableViewCell alloc] init];
    }
	[cell fillCellWithDates:newYear];
	//NSLog(newYear);
	
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
//	[SlidingMenuController shouldHideMenuButton:NO];
	if([self needsToReload])
		if([NetworkStatus networkExists])//keep this here so we dont lag when switching tabs
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
				_years = [SermonYear getSermonYearObjects];
				if (_offlineView != nil)
					[_offlineView removeFromSuperview];
			});
	
	[super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
	[_loadingView removeFromSuperview];
	[super viewDidDisappear:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self loadingViewSetup];
	
	//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
	dispatch_async(dispatch_get_main_queue(), ^{
		//NSInteger row = [indexPath row];
		
		[Sermon makeFinalURLWith:[_years objectAtIndex:indexPath.row]];
		Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
		[self.navigationController pushViewController:sermons2010View animated:YES];
		sermons2010View.title =[_years objectAtIndex:indexPath.row];
		
//		if(row==0){
//			[Sermon makeFinalURLWith:@"2009"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2009";
//		}
//		else if(row==1){
//			[Sermon makeFinalURLWith:@"2010"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2010";
//		}
//		if(row==2){
//			[Sermon makeFinalURLWith:@"2011"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2011";
//		}
//		if(row==3){
//			[Sermon makeFinalURLWith:@"2012"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2012";
//		}
//		if(row==4){
//			[Sermon makeFinalURLWith:@"2013"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2013";
//		}
//		if(row==5){
//			[Sermon makeFinalURLWith:@"2014"];
//			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
//			[self.navigationController pushViewController:sermons2010View animated:YES];
//			sermons2010View.title=@"2014";
//		}
		
//		[SlidingMenuController shouldHideMenuButton:YES];
	});
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}

-(void)menuButtonTapped{
	[[SlidingMenuController sharedInstance]navMenuButtonTapped];
}

-(BOOL)needsToReload{
	if (_years != nil)
		return NO;
	else
		return YES;
}

@end
