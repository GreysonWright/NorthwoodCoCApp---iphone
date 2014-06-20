//
//  NewsLoggedinViewController.m
//  NorthwoodApp
//
//  Created by greyson on 6/16/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "NewsLoggedinViewController.h"
#import "TFHpple.h"
#import "Bulletin.h"
#import "BulletinTableViewCell.h"
#import "PrayerList.h"
#import "PrayerListTableViewCell.h"
#import "DutyRoster.h"
#import "DutyRosterTableViewCell.h"

@interface NewsLoggedinViewController (){
	NSMutableArray *_bulletinObjects;
	NSMutableArray *_prayerListObjects;
	NSMutableArray *_dutyRosterObjects;
	NSString *_bulletinEndURL;
	int _selectedSegment;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController; //add a directory button
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NewsLoggedinViewController

- (IBAction)segmentsChanged:(id)sender {
	if(self.segmentController.selectedSegmentIndex == 0){
		_selectedSegment = 0;
		self.title = @"Bulletins";
	}
	else if(self.segmentController.selectedSegmentIndex == 1){
		_selectedSegment = 1;
		self.title = @"Prayer List";
	}
	else if(self.segmentController.selectedSegmentIndex == 2){
		_selectedSegment = 2;
		self.title = @"DutyRoster";
	}
	[self.tableView reloadData];
	[self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 125) animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self.title = @"Bulletins";
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_bulletinObjects = [[NSMutableArray alloc]init];
		_prayerListObjects = [[NSMutableArray alloc]init];
		_dutyRosterObjects = [[NSMutableArray alloc]init];
		_bulletinObjects = [Bulletin bulletinObject];
		_prayerListObjects = [PrayerList prayerListObjects];
		_dutyRosterObjects = [DutyRoster dutyRosterObjects];
		_selectedSegment = 0;
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
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int returnThis;
	if(_selectedSegment == 0){
		returnThis = _bulletinObjects.count;
	}
	else if(_selectedSegment == 1){
		returnThis = _prayerListObjects.count;
	}
	else if(_selectedSegment == 2){
		returnThis = _dutyRosterObjects.count;
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
	return returnThis;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *returnThis;
	
	if(_selectedSegment == 0){ //bulletin
	
		BulletinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BulletinCell"];
		Bulletin *thisBulletin = [_bulletinObjects objectAtIndex:indexPath.row];
		
		if (cell == nil) {
			cell = [[BulletinTableViewCell alloc] init];
			
		}
		[cell fillWithData:thisBulletin];
		returnThis=cell;
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
	
    return returnThis;
}

@end
