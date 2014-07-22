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

@interface SermonsViewController (){
	NSMutableArray *_years;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *loadingView;

@end

@implementation SermonsViewController

-(void)loadingViewSetup{
	if(!_loadingView)
	{
		_loadingView = [[UIView alloc] initWithFrame:self.view.frame];
		_loadingView.alpha = .85;
		[_loadingView setBackgroundColor:[UIColor blackColor]];
		
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[indicator setFrame:CGRectMake((160), (180), 0, 0)];
		UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((0), (210), 320, 30)];
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
		self.tabBarItem.title=self.title;
		_years=[[NSMutableArray alloc] initWithObjects:@"2009", @"2010", @"2011", @"2012", @"2013", @"2014", nil];
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
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



-(void)viewDidDisappear:(BOOL)animated{
	[_loadingView removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[self loadingViewSetup];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger row = [indexPath row];
		
		if(row==0){
			[Sermon makeFinalURLWith:@"2009"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2009";
		}
		else if(row==1){
			[Sermon makeFinalURLWith:@"2010"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2010";
		}
		if(row==2){
			[Sermon makeFinalURLWith:@"2011"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2011";
		}
		if(row==3){
			[Sermon makeFinalURLWith:@"2012"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2012";
		}
		if(row==4){
			[Sermon makeFinalURLWith:@"2013"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2013";
		}
		if(row==5){
			[Sermon makeFinalURLWith:@"2014"];
			Sermons2010ViewController *sermons2010View = [[Sermons2010ViewController alloc] init];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self.navigationController pushViewController:sermons2010View animated:YES];
			sermons2010View.title=@"2014";
		}
	});
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}
@end
