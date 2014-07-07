//
//  AppDelegate.m
//  NorthwoodApp
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "AppDelegate.h"
#import "Colours.h"
#import "HomeViewController.h"
#import "HomeNavigationViewController.h"
#import "SermonsViewController.h"
#import "SermonsNavigationViewController.h"
#import "NewsLoggedinViewController.h"
#import "NewsNavigationViewController.h"
#import "ContactUsViewController.h"
#import "ContactUsNavigationViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation AppDelegate

int _alert;

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		if(_alert == 0){
			NSLog(@"no push notifications");
			UIAlertView *currentLocationAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"\"Northwood\" would like to use your current location." delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
			[currentLocationAlert show];
			_alert = 1;
		}
		else if(_alert == 1){
			NSLog(@"do nothing");
		}
	}
	else{
		if(_alert == 0){
			NSLog(@"push notifications enabled");
			UIAlertView *currentLocationAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"\"Northwood\" would like to use your current location." delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
			[currentLocationAlert show];
			_alert = 1;
		}
		else if(_alert == 1){
			NSLog(@"do stuff");
		}
	}
	
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirstLaunch"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor yellowColor];
    [self.window makeKeyAndVisible];
	
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	
	NSError *setCategoryError = nil;
	BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
	if (!success) {
		NSLog(@"broken");
	}
	
	NSError *activationError = nil;
	success = [audioSession setActive:YES error:&activationError];
	if (!success) {
		NSLog(@"broken");
	} 
	
		//views
	HomeViewController *homeView = [[HomeViewController alloc] init];
	SermonsViewController *sermonsView=[[SermonsViewController alloc]init];
	NewsLoggedinViewController *newsView=[[NewsLoggedinViewController alloc] init];
	ContactUsViewController *contactUsView=[[ContactUsViewController alloc]init];
		
		//navs
	HomeNavigationViewController *homeNav=[[HomeNavigationViewController alloc]initWithRootViewController:homeView];
	SermonsNavigationViewController *sermonsNav=[[SermonsNavigationViewController alloc] initWithRootViewController:sermonsView];
	NewsNavigationViewController *newsNav=[[NewsNavigationViewController alloc]initWithRootViewController:newsView];
	ContactUsNavigationViewController *contactUsNav=[[ContactUsNavigationViewController alloc]initWithRootViewController:contactUsView];
		
		//tabBar
	self.tabBar=[[TabBarController alloc]init];
	self.tabBar.tabBar.translucent=NO;
	self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:37.0/255.0f green:37.0/255.0f blue:38.0/255.0f alpha:1];
	self.tabBar.tabBar.tintColor = [UIColor whiteColor];
	[self.tabBar setViewControllers:@[homeNav, sermonsNav, newsNav, contactUsNav]];
	[self.window setRootViewController:self.tabBar];
	
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"notFirstLaunch"] == NO){
		UIAlertView *pushNotificationAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Would You like to receive push notifications?" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
		[pushNotificationAlert show];
		_alert = 0;

	}
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
