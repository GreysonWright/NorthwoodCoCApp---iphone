//
//  SermonDateTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SermonDateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

-(void)fillCellWithDates:(NSString*)inputYear;

@end
