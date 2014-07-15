//
//  AppDelegate.h
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property TabBarController *tabBar;

+(void)backgroundFetchEnabled:(BOOL)yesNo;

@end