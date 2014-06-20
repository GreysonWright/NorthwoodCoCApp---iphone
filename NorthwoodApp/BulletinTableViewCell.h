//
//  BulletinTableViewCell.h
//  NorthwoodApp
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bulletin.h"

@interface BulletinTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
-(void)fillWithData:(Bulletin*)bulletin;

@end
