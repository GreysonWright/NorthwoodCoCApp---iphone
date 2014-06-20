//
//  AppDelegate.m
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 SilentDoorHinges. All rights reserved.
//

#import "AppDelegate.h"
#import "Colours.h"
#import "HomeViewController.h"
#import "HomeNavigationViewController.h"
#import "SermonsViewController.h"
#import "SermonsNavigationViewController.h"
#import "NewsLoggedinViewController.h"
#import "NewsNavigationViewController.h"
#import "SettingsViewController.h"
#import "SettingsNavigationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor yellowColor];
    [self.window makeKeyAndVisible];
	
		//views
	HomeViewController *homeView = [[HomeViewController alloc] init];
	SermonsViewController *sermonsView=[[SermonsViewController alloc]init];
	NewsLoggedinViewController *newsView=[[NewsLoggedinViewController alloc] init];
	SettingsViewController *settingsView=[[SettingsViewController alloc]init];
		
		//navs
	HomeNavigationViewController *homeNav=[[HomeNavigationViewController alloc]initWithRootViewController:homeView];
	SermonsNavigationViewController *sermonsNav=[[SermonsNavigationViewController alloc] initWithRootViewController:sermonsView];
	NewsNavigationViewController *newsNav=[[NewsNavigationViewController alloc]initWithRootViewController:newsView];
	SettingsNavigationViewController *settingsNav=[[SettingsNavigationViewController alloc]initWithRootViewController:settingsView];
		
		//tabBar
	self.tabBar=[[TabBarController alloc]init];
	self.tabBar.tabBar.translucent=NO;
	self.tabBar.tabBar.barStyle = UIBarStyleBlack;
	self.tabBar.tabBar.tintColor=[UIColor whiteColor];
	[self.tabBar setViewControllers:@[homeNav, sermonsNav, newsNav, settingsNav]]; //keep settings view last
	[self.window setRootViewController:self.tabBar];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
