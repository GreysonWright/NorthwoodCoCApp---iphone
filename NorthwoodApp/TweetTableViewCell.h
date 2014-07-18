//
//  TweetTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/18/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

-(void)fillWithData:(Tweet*)tweet;
-(void)fillDateWithData:(Tweet*)tweet;
-(void)fillWithBareData:(NSString*)tweet;
-(void)fillDateWithBareData:(NSString*)date;

@end
