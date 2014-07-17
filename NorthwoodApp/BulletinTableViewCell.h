//
//  BulletinTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bulletin.h"

@interface BulletinTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
-(void)fillWithData:(Bulletin*)bulletin;
-(void)fillWithBareData:(NSString*)bulletin;

@end
