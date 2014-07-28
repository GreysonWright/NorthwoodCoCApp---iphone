//
//  HomeViewController.h
//  NorthwoodCoC
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

+(UIBackgroundFetchResult)refreshTweets;
+(void)finnishedSetup;

@end
