//
//  BulletinTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "BulletinTableViewCell.h"

@implementation BulletinTableViewCell

-(instancetype)init{

    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BulletinTableViewCell class]) owner:nil options:nil][0];
    
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

-(void)fillWithData:(Bulletin*)bulletin{
	self.dateLabel.text = bulletin.bulletinContent;
}

-(void)fillWithBareData:(NSString *)bulletin{
	self.dateLabel.text = bulletin;
}
@end
