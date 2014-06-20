//
//  SermonsTableViewCell.m
//  NorthwoodApp
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "SermonsTableViewCell.h"

@implementation SermonsTableViewCell

@synthesize sermonURL = _sermonURL;

-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SermonsTableViewCell class]) owner:nil options:nil][0];
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)fillNameWithData:(SermonPreacher*)preacher{
	self.nameLabel.text = preacher.content;
	NSLog(preacher.content);
}

-(void)fillDateWithData:(SermonDate*)date{
	self.dateLabel.text = date.content;
	NSLog(date.content);
}

-(void)fillSermonWithData:(SermonTitle*)title{
	self.titleLabel.text = title.content;
	NSLog(title.content);
}

-(void)getLinkWithData:(Sermon*)link{
	_sermonURL = link.link;
	NSLog(link.link);
}


@end
