//
//  HomeViewController.m
//  NorthwoodApp
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

@interface HomeViewController (){
	NSMutableArray *_contentObjects;
	NSMutableArray *_dateObjects;
	NSMutableArray *_tweetContent;
	NSMutableArray *_tweetDates;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property UIRefreshControl* refreshControl;
@property UIPageControl* pageControl;

@end

@implementation HomeViewController

-(void)loadStuff{
	dispatch_async(dispatch_get_main_queue(), ^{
		_contentObjects = nil;
		_dateObjects = nil;
		_tweetContent = nil;
		_tweetDates = nil;
		_contentObjects = [Tweet tweetObjects];
		_dateObjects = [Tweet dateObjects];
		_tweetContent = [Tweet bareTweetContent];
		_tweetDates = [Tweet bareTweetDates];
	});
	
	[self.refreshControl endRefreshing];
	[self.tableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Home";
		self.tabBarItem.title=self.title;
		_contentObjects = [[NSMutableArray alloc]init];
		_dateObjects = [[NSMutableArray alloc]init];
		_tweetContent = [[NSMutableArray alloc]init];
		_tweetDates = [[NSMutableArray alloc]init];
		_tweetContent = [Tweet bareTweetContent];
		_tweetDates = [Tweet bareTweetDates];
		_contentObjects = [Tweet tweetObjects];
		_dateObjects = [Tweet dateObjects];
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
		self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Mail Request" style:UIBarButtonItemStylePlain target:self action:@selector(requestTitleButtonTapped)];
	
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -60, self.tableView.frame.size.width, 60)];
    [self.refreshControl addTarget:self action:@selector(loadStuff) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
	
	/*UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 80)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    scrollView.delegate = self; */
	
	self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 90, self.scrollView.frame.size.width, 20)];
    self.pageControl.numberOfPages = self.scrollView.contentSize.width/self.scrollView.frame.size.width;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
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
    return _contentObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 137;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BigTweetViewController *bigTweetView = [[BigTweetViewController alloc]init];
	[bigTweetView setText:[_tweetContent objectAtIndex:indexPath.row]];
	bigTweetView.title = [_tweetDates objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:bigTweetView animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Tweet *thisTweet = [_contentObjects objectAtIndex:indexPath.row];
	Tweet *tweetDate = [_dateObjects objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[TweetTableViewCell alloc]init];
    }
	[cell fillWithData:thisTweet];
	[cell fillDateWithData:tweetDate];
	
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
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"] == YES){
	MailRequestViewController *requestView = [[MailRequestViewController alloc]init];
	[self.navigationController pushViewController:requestView animated:YES];
	}
	else{
		[MailRequestViewController setRequesting:YES];
		LogginginViewController *loginView = [[LogginginViewController alloc]init];
		[self presentViewController:loginView animated:YES completion:NULL];
	}
}

- (void)changePage:(id)sender {
    CGFloat x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView  {
    NSInteger pageNumber = roundf(scrollView.contentOffset.x / (scrollView.frame.size.width));
    self.pageControl.currentPage = pageNumber;
}
@end