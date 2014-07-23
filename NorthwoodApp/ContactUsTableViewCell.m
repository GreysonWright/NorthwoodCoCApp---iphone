//
//  ContactUsTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "ContactUsTableViewCell.h"

@implementation ContactUsTableViewCell

-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContactUsTableViewCell class]) owner:nil options:nil][0];
    
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
- (IBAction)emailButtonTapped:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:" stringByAppendingString:self.emailLabel.currentTitle ]]];
}

-(void)fillTitleWithData:(ContactUs*)contact{
	self.titleLabel.text = contact.title;
	//self.nameLabel.text = contact.name;
}

-(void)fillNameWithData:(ContactUs*)contact{
	self.nameLabel.text = contact.name;
	
}

-(void)fillEmailWithData:(ContactUs*)contact{
	NSString *stringWithoutMailto = [contact.email stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
	//self.emailLabel.text = stringWithoutMailto;
	[self.emailLabel setTitle:stringWithoutMailto forState:UIControlStateNormal];
	CGRect emailButton = self.emailLabel.frame;
	emailButton.size = CGSizeMake(self.emailLabel.currentTitle.length * 8, self.emailLabel.frame.size.height);
	self.emailLabel.frame = emailButton;
}

-(void)fillTitleWithBareData:(NSString *)title{
	self.titleLabel.text = title;
}

-(void)fillNameWithBareData:(NSString *)name{
	self.nameLabel.text = name;
}

-(void)fillEmailWithBareData:(NSString *)email{
	NSString *stringWithoutMailto = [email stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
	//self.emailLabel.text = stringWithoutMailto;
	[self.emailLabel setTitle:stringWithoutMailto forState:UIControlStateNormal];
}
@end
