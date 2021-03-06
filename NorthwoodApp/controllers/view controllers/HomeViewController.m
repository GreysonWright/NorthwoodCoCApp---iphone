//
//  HomeViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "HomeViewController.h"
#import "TFHpple.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "BigTweetViewController.h"
#import "SettingsViewController.h"
#import "MailRequestViewController.h"
#import "LogginginViewController.h"
#import "NewsLoggedinViewController.h"
#import "NetworkStatus.h"
#import "AppDelegate.h"
#import "ContactUsViewController.h"
#import "PDFCleaner.h"

@interface HomeViewController (){
	NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UIView *littleBigView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property UIRefreshControl* refreshControl;
@property UIView *loadingView;

@end

@implementation HomeViewController

static NSMutableArray *_contentObjects;
static NSMutableArray *_dateObjects;
static NSMutableArray *_tweetContent;
static NSMutableArray *_tweetDates;
//static NSString *tmpObj;
static BOOL finishedSetup;
BOOL skipPageTurn;
BOOL offlineMode;

-(void)checkSetup{
	if(finishedSetup){
		[UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{ _loadingView.alpha = 0;}completion:^(BOOL finished){ [_loadingView removeFromSuperview];
			//[SlidingMenuController shouldHideMenuButton:NO];
		}];
		[[SlidingMenuController sharedInstance]enablePanRecognizer];
		[timer invalidate];
		[PDFCleaner cleanPDFObjects];
	}
	else
		NSLog(@"not finnished");
}

-(void)buildLoadingView{
	if(!_loadingView)
	{
		_loadingView = [[UIView alloc] initWithFrame:self.view.frame];
		[_loadingView setBackgroundColor:[UIColor blackColor]];
		
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		//[indicator setFrame:CGRectMake((160), (260), 0, 0)];
		indicator.center = CGPointMake(self.view.center.x, (self.view.center.y - 20));
		UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((0), (280), 320, 30)];
		loadingLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
		loadingLabel.textColor = [UIColor whiteColor];
		[loadingLabel setTextAlignment:NSTextAlignmentCenter];
		loadingLabel.text = @"fetching new data";
		
		[_loadingView addSubview:indicator];
		[_loadingView addSubview:loadingLabel];
		
		[indicator startAnimating];
	}
	[self.navigationController.view addSubview:_loadingView];
	
}

-(void)loadStuff{
	if([NetworkStatus networkExists]){
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			//dispatch_async(dispatch_get_main_queue(), ^{
			_contentObjects = nil;
			_dateObjects = nil;
			_tweetContent = nil;
			_tweetDates = nil;
			_contentObjects = [Tweet tweetObjects];
			_dateObjects = [Tweet dateObjects];
			_tweetContent = [Tweet bareTweetContent];
			_tweetDates = [Tweet bareTweetDates];
			[self.refreshControl endRefreshing];
			[self.tableView reloadData];
			offlineMode = NO;
		});
	}
	else{
		NSLog(@"don't refresh");
		[self.refreshControl endRefreshing];
	}
}

-(void)refresh{
	[NetworkStatus setSlowNetwork:NO];
	[self loadStuff];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"list26"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
		self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
		self.title = @"Home";
		self.tabBarItem.image = [UIImage imageNamed:@"home65.png"];
		_contentObjects = [[NSMutableArray alloc]init];
		_dateObjects = [[NSMutableArray alloc]init];
		_tweetContent = [[NSMutableArray alloc]init];
		_tweetDates = [[NSMutableArray alloc]init];
		if([NetworkStatus networkExists]){
			_tweetContent = [Tweet bareTweetContent];
			_tweetDates = [Tweet bareTweetDates];
			_contentObjects = [Tweet tweetObjects];
			_dateObjects = [Tweet dateObjects];
			[[NSUserDefaults standardUserDefaults]setObject:_tweetContent forKey:@"tweetContent"];
			[[NSUserDefaults standardUserDefaults]setObject:_tweetDates forKey:@"tweetDates"];
			offlineMode = NO;
		}
		else if(![NetworkStatus networkExists]){
			_tweetContent = [[NSUserDefaults standardUserDefaults]objectForKey:@"tweetContent"];
			_tweetDates = [[NSUserDefaults standardUserDefaults]objectForKey:@"tweetDates"];
			offlineMode = YES;
		}
		
		if([[NSUserDefaults standardUserDefaults]objectForKey:@"tmpObj"] == nil){
			[[NSUserDefaults standardUserDefaults]setObject:[_tweetContent objectAtIndex:0] forKey:@"tmpObj"];
			[[NSUserDefaults standardUserDefaults]synchronize];
			//NSLog([_tweetContent objectAtIndex:0]);
		}
		//tmpObj =[_tweetContent objectAtIndex:0];
		//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
		
		//this will be enabled once the backend is built
		//self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Mail Request" style:UIBarButtonItemStylePlain target:self action:@selector(requestTitleButtonTapped)];
		timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkSetup) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	
	//if(finnishedSetup)
//		[SlidingMenuController shouldHideMenuButton:NO];
	
	[super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
	
	if([self needsToReload])
		if([NetworkStatus networkExists])//keep this here so we dont lag when switching tabs
			[self loadStuff];
	[super viewDidAppear:animated];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -60, self.tableView.frame.size.width, 60)];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
	
		NSMutableArray* images = [[NSMutableArray alloc] initWithObjects:@"phillipians.png", @"bible.png", nil];
	
	for (int i = 0; i < [images count]; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[images objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
	}
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [images count], self.scrollView.frame.size.height);
	
	[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timedPageFlips) userInfo:nil repeats:YES];
	
	[self buildLoadingView];
	[NewsLoggedinViewController fireInit];
	[ContactUsViewController fireInit];
	[SlidingMenuController sharedInstance].isChangingView = NO;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*if([NetworkStatus networkExists])
		return _contentObjects.count;
	else */
		return _tweetContent.count;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 137;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	BigTweetViewController *bigTweetView = [[BigTweetViewController alloc]init];
	[bigTweetView setText:[_tweetContent objectAtIndex:indexPath.row]];
	bigTweetView.title = [_tweetDates objectAtIndex:indexPath.row];
	//[SlidingMenuController shouldHideMenuButton:YES];
	[self.navigationController pushViewController:bigTweetView animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[TweetTableViewCell alloc]init];
    }
	if(!offlineMode){
		Tweet *thisTweet = [_contentObjects objectAtIndex:indexPath.row];
		Tweet *tweetDate = [_dateObjects objectAtIndex:indexPath.row];
		[cell fillWithData:thisTweet];
		[cell fillDateWithData:tweetDate];
	}
	else if(offlineMode){
		[cell fillWithBareData:[_tweetContent objectAtIndex:indexPath.row]];
		[cell fillDateWithBareData:[_tweetDates objectAtIndex:indexPath.row]];
	}
	
    return cell;
}

- (IBAction)twitterButtonPressed:(id)sender {
	if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=northwoodcoc"]]) {
        
        if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/northwoodcoc"]]) {
            NSLog(@"dead");
        }
    }
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}

-(void)requestTitleButtonTapped{
	[self.navigationController pushViewController:[[MailRequestViewController alloc]init] animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
	skipPageTurn = YES;
}

-(void)timedPageFlips{
	if(self.pageControl.currentPage == 0 && skipPageTurn == NO){
		NSLog(@"turn page");
		self.pageControl.currentPage = 1;
		[UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.scrollView.contentOffset = CGPointMake(320, 0);
		} completion:NULL];
	}
	else if(self.pageControl.currentPage == 1 && skipPageTurn == NO){
		NSLog(@"turn page");
	 self.pageControl.currentPage = 0;
		[UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
			self.scrollView.contentOffset = CGPointMake(0, 0);
		} completion:NULL];
	}
	else{
		NSLog(@"skipping turn");
		skipPageTurn = NO;
	}
}

-(BOOL)needsToReload{
	if(_tweetContent.count < _contentObjects.count){
		NSLog(@"reload");
		return YES;
	}
	else{
		NSLog(@"doesnt need to reload");
		return NO;
	}
}

-(void)menuButtonTapped{
	[[SlidingMenuController sharedInstance]navMenuButtonTapped];
}

+(BOOL)refreshTweets{
	//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
	//dispatch_async(dispatch_get_main_queue(), ^{
		_contentObjects = nil;
		_dateObjects = nil;
		_tweetContent = nil;
		_tweetDates = nil;
		_contentObjects = [Tweet tweetObjects];
		_dateObjects = [Tweet dateObjects];
		_tweetContent = [Tweet bareTweetContent];
		_tweetDates = [Tweet bareTweetDates];
	//});
	if([self arrayIsUpdated]){
		NSLog(@"gogogogo");
		[self notifFire];
		//return UIBackgroundFetchResultNewData;
		return YES;
	}
	else{
		NSLog(@"no new data");
		//return UIBackgroundFetchResultNoData;
		return NO;
	}
}

+(void)notifFire{
	UILocalNotification *notification = [[UILocalNotification alloc]init];
	notification.alertBody = [_tweetContent objectAtIndex:0];
	notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
	notification.timeZone = [NSTimeZone defaultTimeZone];
	notification.soundName = UILocalNotificationDefaultSoundName;
	[[UIApplication sharedApplication] setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];
}

+(BOOL)arrayIsUpdated{
	if([[[NSUserDefaults standardUserDefaults]objectForKey:@"tmpObj"]  isEqual:[_tweetContent objectAtIndex:0]]){
		return NO;
	}
	else{
		//NSLog([@"first defaults-" stringByAppendingString:[[NSUserDefaults standardUserDefaults]objectForKey:@"tmpObj"]]);
		//NSLog([@"tweet conent-"stringByAppendingString:[_tweetContent objectAtIndex:0]]);
		[[NSUserDefaults standardUserDefaults]setObject:[_tweetContent objectAtIndex:0] forKey:@"tmpObj"];
		[[NSUserDefaults standardUserDefaults]synchronize];
		//NSLog([@"second user defaults-" stringByAppendingString:[[NSUserDefaults standardUserDefaults]objectForKey:@"tmpObj"]]);
		return YES;
	}
}

+(void)finnishedSetup{
	finishedSetup = YES;
}

@end