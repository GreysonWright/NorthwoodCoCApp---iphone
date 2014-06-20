//
//  DutyRosterTableViewCell.h
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DutyRoster.h"

@interface DutyRosterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;

-(void)fillWithData:(DutyRoster*)dutyRoster;
@end
