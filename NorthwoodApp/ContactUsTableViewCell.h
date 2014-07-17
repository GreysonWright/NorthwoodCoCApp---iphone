//
//  ContactUsTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/21/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactUs.h"

@interface ContactUsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

-(void)fillTitleWithData:(ContactUs*)contact;
-(void)fillNameWithData:(ContactUs*)contact;
-(void)fillEmailWithData:(ContactUs*)contact;
-(void)fillTitleWithBareData:(NSString*)title;
-(void)fillNameWithBareData:(NSString*)name;
-(void)fillEmailWithBareData:(NSString*)email;

@end
