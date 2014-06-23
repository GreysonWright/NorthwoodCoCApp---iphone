//
//  SermonsTableViewCell.h
//  NorthwoodApp
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sermon.h"

@interface SermonsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, copy) NSString *sermonURL;
-(void)fillNameWithData:(Sermon*)preacher;
-(void)fillDateWithData:(Sermon*)date;
-(void)fillSermonWithData:(Sermon*)title;
-(void)getLinkWithData:(Sermon*)link;

@end
