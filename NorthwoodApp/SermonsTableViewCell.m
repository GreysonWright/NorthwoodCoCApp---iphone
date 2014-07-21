//
//  SermonsTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SermonsTableViewCell.h"

@implementation SermonsTableViewCell

@synthesize sermonURL = _sermonURL;

-(instancetype)init{
    //self=[super init];
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
	if([preacher  isEqual: @" "])
		self.nameLabel.text = preacher;
	else
		self.nameLabel.text = preacher.preacherContent;
	//NSLog(preacher.preacherContent);
}

-(void)fillDateWithData:(Sermon*)date{
	if([date isEqual: @" "])
		self.dateLabel.text = date;
	else
		self.dateLabel.text = date.dateContent;
	//NSLog(date.dateContent);
}

-(void)fillSermonWithData:(Sermon*)title{
	if([title  isEqual: @" "])
		self.titleLabel.text = title;
	else
		self.titleLabel.text = title.titleContent;
	//NSLog(title.titleContent);
}

-(void)getLinkWithData:(Sermon*)link{
	_sermonURL = link.link;
	//NSLog(link.link);
}


@end
