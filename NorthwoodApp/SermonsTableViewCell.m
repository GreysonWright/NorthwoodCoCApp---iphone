//
//  SermonsTableViewCell.m
//  NorthwoodApp
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
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

-(void)fillNameWithData:(Sermon*)preacher{
	self.nameLabel.text = preacher.preacherContent;
	//NSLog(preacher.preacherContent);
}

-(void)fillDateWithData:(Sermon*)date{
	self.dateLabel.text = date.dateContent;
	//NSLog(date.dateContent);
}

-(void)fillSermonWithData:(Sermon*)title{
	self.titleLabel.text = title.titleContent;
	//NSLog(title.titleContent);
}

-(void)getLinkWithData:(Sermon*)link{
	_sermonURL = link.link;
	NSLog(link.link);
}


@end
