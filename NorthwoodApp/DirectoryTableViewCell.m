//
//  DirectoryTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "DirectoryTableViewCell.h"
#import <MapKit/MapKit.h>

@implementation DirectoryTableViewCell

-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DirectoryTableViewCell class]) owner:nil options:nil][0];
    
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

-(void)fillNameWithData:(Directory*)name{
	self.nameLabel.text = name;
}

-(void)fillTitleWithData:(Directory*)title{
	self.titleLabel.text = title;
}

-(void)fillPhoneWithData:(Directory*)phone{
	self.phoneLabel.text = phone;
}

-(void)fillEmailWithData:(Directory*)email{
	self.emailLabel.text = email;
}

-(void)fillAddressWithData:(Directory*)address{
	self.addressLabel.text = address;
}

- (IBAction)callButtonTapped:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:self.phoneLabel.text]]];
}

- (IBAction)emailButtonTapped:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:" stringByAppendingString:self.emailLabel.text]]];
}


- (IBAction)adressButtonTapped:(id)sender {
	NSString *addressLabelString = self.addressLabel.text;
	NSString *convertedAddress = [addressLabelString stringByReplacingOccurrencesOfString:@" "withString:@"+"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"http://maps.apple.com?q=" stringByAppendingString:convertedAddress]]];
	
}
@end
