//
//  SermonsTableViewCell.h
//  NorthwoodApp
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sermon.h"
#import "SermonTitle.h"
#import "SermonDate.h"
#import "SermonPreacher.h"

@interface SermonsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, copy) NSString *sermonURL;
-(void)fillNameWithData:(SermonPreacher*)preacher;
-(void)fillDateWithData:(SermonDate*)date;
-(void)fillSermonWithData:(SermonTitle*)title;
-(void)getLinkWithData:(Sermon*)link;

@end
