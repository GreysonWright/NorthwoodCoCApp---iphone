//
//  Sermons2010ViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/16/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "Sermons2010ViewController.h"
#import "Sermon.h"
#import "TFHpple.h"
#import "SermonsTableViewCell.h"
#import "UniversalWebViewViewController.h"
#import "SettingsViewController.h"

@interface Sermons2010ViewController (){
	NSMutableArray *_linkObjects;
	NSMutableArray *_dateObjects;
	NSMutableArray *_titleObjects;
	NSMutableArray *_preacherObjects;
	NSMutableArray *_linksForWebView;
	NSMutableArray *_sermonsForWebView;
	NSInteger _indexPathRow;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Sermons2010ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_linkObjects = [[NSMutableArray alloc]init];
		_preacherObjects = [[NSMutableArray alloc]init];
		_titleObjects = [[NSMutableArray alloc]init];
		_dateObjects = [[NSMutableArray alloc]init];
		_linksForWebView = [[NSMutableArray alloc]init];
		_sermonsForWebView = [[NSMutableArray alloc]init];
		_linkObjects = [Sermon sermonObjects];
		_dateObjects = [Sermon sermonDateObjects];
		_titleObjects = [Sermon sermonTitleObjects];
		_preacherObjects = [Sermon sermonPreacherObjects];
		self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTitleButtonTapped)];
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
    return _titleObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(self.title !=@"2012" && self.title !=@"2011"){
		if([_linksForWebView objectAtIndex:indexPath.row] != @"none" && [_linksForWebView objectAtIndex:indexPath.row] != @"N/A"){
			
			UIAlertView *playBackWarning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Streaming audio will use large amounts of data. It is advised that you connect to wireless internet. Would you like to proceed?" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
			[playBackWarning show];
			NSLog([_linksForWebView objectAtIndex:indexPath.row]);
		}
		else{
			UIAlertView *noLinkWarning = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unfortunately the sermon selected does not have audio." delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
			[noLinkWarning show];
		}
		_indexPathRow = indexPath.row;
	}
	else{
		UIAlertView *noAudio = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Sorry, the audio in 2012 is download only. If you would like to listen to the audio please download it at www.justchristians.info/" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[noAudio show];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	SermonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SermonCell"];
	Sermon *sermonPreacher = [_preacherObjects objectAtIndex:indexPath.row];
	Sermon *sermonTitle = [_titleObjects objectAtIndex:indexPath.row];
	Sermon *sermonDate = [_dateObjects objectAtIndex:indexPath.row];
    if (cell==nil) {
		cell = [[SermonsTableViewCell alloc] init];
    }
	if(self.title != @"2012" && self.title != @"2011"){
		Sermon *sermonLink = [_linkObjects objectAtIndex:indexPath.row];
		[cell getLinkWithData:sermonLink];
		[_linksForWebView addObject:sermonLink.link];
	}
	
	else
		NSLog(@"2012 or 2011");
		
	[cell fillSermonWithData:sermonTitle];
	[cell fillDateWithData:sermonDate];
	[cell fillNameWithData:sermonPreacher];
	[_sermonsForWebView addObject:sermonTitle.titleContent];
	
    return cell;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSLog(@"user did not play audio");
	}
	else{
		UniversalWebViewViewController *webView = [[UniversalWebViewViewController alloc]init];
		webView.title = [_sermonsForWebView objectAtIndex:_indexPathRow];
		[self.navigationController pushViewController:webView animated:YES];
		[webView loadSermonAudio:[_linksForWebView objectAtIndex:_indexPathRow]];
		[alertView dismissWithClickedButtonIndex:-1 animated:YES];
	}
}

-(void)settingsTitleButtonTapped{
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	[self.navigationController pushViewController:settingsView animated:YES];
}
@end