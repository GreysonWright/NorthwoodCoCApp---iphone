//
//  BigTweetViewController.m
//  NorthwoodCoC
//
//  Created by greyson on 6/24/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "BigTweetViewController.h"

@interface BigTweetViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BigTweetViewController

static NSString *viewText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.text = viewText;
	self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText:(NSString*)text{
	viewText = text;
}

@end
