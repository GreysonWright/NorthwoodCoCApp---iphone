//
//  DirectoryTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Directory.h"

@interface DirectoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)fillNameWithData:(Directory*)name;
-(void)fillTitleWithData:(Directory*)title;
-(void)fillPhoneWithData:(Directory*)phone;
-(void)fillEmailWithData:(Directory*)email;
-(void)fillAddressWithData:(Directory*)address;

@end
