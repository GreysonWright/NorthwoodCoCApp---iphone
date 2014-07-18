//
//  PrayerListTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 6/17/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerList.h"

@interface PrayerListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
-(void)fillWithData:(PrayerList*)prayerList;
-(void)loadWebPageInOfflineMode;
@end
