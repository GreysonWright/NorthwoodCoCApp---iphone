//
//  SermonDateTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "SermonDateTableViewCell.h"

@implementation SermonDateTableViewCell

-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SermonDateTableViewCell class]) owner:nil options:nil][0];
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithDates:(NSString*)inputYear{
	self.yearLabel.text = inputYear;
}

@end
