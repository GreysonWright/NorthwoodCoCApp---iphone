//
//  HomeViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "HomeViewController.h"
#import "TFHpple.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
@import Social;

@interface HomeViewController (){
	NSMutableArray *_contentObjects;
	NSMutableArray *_URLObjects;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Home";
		self.tabBarItem.title=self.title;
		_contentObjects = [[NSMutableArray alloc]init];
		_URLObjects = [[NSMutableArray alloc]init];
		_contentObjects = [Tweet tweetObjects];
		_URLObjects = [TweetURLS URLObjects];
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView reloadData];
	
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
	return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Tweet *thisTweet = [_contentObjects objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[TweetTableViewCell alloc]init];
    }
	
    [cell fillWithData:thisTweet];
    return cell;
}

- (IBAction)twitterButtonPressed:(id)sender {
	if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=northwoodcoc"]]) {
        
        // opening the app didn't work - let's open Safari
        if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/northwoodcoc"]]) {
            NSLog(@"dead");
        }
    }
}

@end
