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

@interface Sermons2010ViewController (){
	NSMutableArray *_objects;
	NSMutableArray *_dateObjects;
	NSMutableArray *_titleObjects;
	NSMutableArray *_preacherObjects;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Sermons2010ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_objects = [[NSMutableArray alloc]init];
		_preacherObjects = [[NSMutableArray alloc]init];
		_titleObjects = [[NSMutableArray alloc]init];
		_dateObjects = [[NSMutableArray alloc]init];
		_objects = [Sermon sermonObjects];
		_dateObjects = [SermonDate sermonObjects];
		_titleObjects = [SermonTitle sermonObjects];
		_preacherObjects = [SermonPreacher sermonObjects];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	SermonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SermonCell"];
	Sermon *sermon = [_objects objectAtIndex:indexPath.row];
	SermonTitle *sermonTitle = [_titleObjects objectAtIndex:indexPath.row];
	SermonDate *sermonDate = [_dateObjects objectAtIndex:indexPath.row];
	SermonPreacher *sermonPreacher = [_preacherObjects objectAtIndex:indexPath.row];
    if (cell==nil) {
		cell = [[SermonsTableViewCell alloc] init];
    }
	[cell getLinkWithData:sermon];
	[cell fillSermonWithData:sermonTitle];
	[cell fillDateWithData:sermonDate];
	[cell fillNameWithData:sermonPreacher];
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 73;
}

@end