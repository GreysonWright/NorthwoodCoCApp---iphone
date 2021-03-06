//
//  AppDelegate.m
//  NorthwoodCoC
//
//  Created by greyson on 6/11/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "AppDelegate.h"
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
#import "NetworkStatus.h"
#import "SettingsViewController.h"
#import "SlidingMenuController.h"
#import "SettingsViewController.h"
#import "SettingsNavigationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.versionNumber = @"1.2";
	
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
	SettingsViewController *settingsView = [[SettingsViewController alloc]init];
	
	//navs
	HomeNavigationViewController *homeNav=[[HomeNavigationViewController alloc]initWithRootViewController:homeView];
	SermonsNavigationViewController *sermonsNav=[[SermonsNavigationViewController alloc] initWithRootViewController:sermonsView];
	NewsNavigationViewController *newsNav=[[NewsNavigationViewController alloc]initWithRootViewController:newsView];
	ContactUsNavigationViewController *contactUsNav=[[ContactUsNavigationViewController alloc]initWithRootViewController:contactUsView];
	SettingsNavigationViewController *settingsNav = [[SettingsNavigationViewController alloc]initWithRootViewController:settingsView];
	
//	//tabBar
//	self.tabBar=[[TabBarController alloc]init];
//	self.tabBar.tabBar.translucent=NO;
//	self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:45.0/255.0f green:45.0/255.0f blue:48.0/255.0f alpha:1];
//	
//	self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0/255.0f green:126.0/255.0f blue:255.0/255.0f alpha:1];
//	[self.tabBar setViewControllers:@[homeNav, sermonsNav, newsNav, contactUsNav]];
//	[self.window setRootViewController:self.tabBar];
	SlidingMenuController *slidingMenu = [[SlidingMenuController alloc]init];
	slidingMenu.viewControllerObjects = @[homeNav, sermonsNav, newsNav, contactUsNav, settingsNav];
	self.window.rootViewController = slidingMenu;
	
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"notFirstLaunch"] == NO){
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pushSwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"groupSwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"eventSwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tweetSwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"dutySwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"verseSwitch"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifsOn"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirstLaunch"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		NSLog(@"first launch");
	}
	
	if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"versionNumber"] isEqual:self.versionNumber]) {
		NSLog(@"version %@ != %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNumber"], self.versionNumber);
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loggedIn"];
		[[NSUserDefaults standardUserDefaults] setValue:self.versionNumber forKey:@"versionNumber"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		NSLog(@"version %@ != %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNumber"], self.versionNumber);
	}
	
	if([SettingsViewController pushSwitchIsOn]) //shouldve used nsuserdefaults now that i think about it
		[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
	else{
		[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
		NSLog(@"no background checking e.e");
	}
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSURL *docs = [NSURL fileURLWithPath:documentsDirectory];
	if([self doNotBackupURL:docs]){
		NSLog(@"iCloud will not backup documents");
	}
	else{
		NSLog(@"broken");
	}
	
    return YES;
}

- (BOOL)doNotBackupURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
	
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+(void)backgroundFetchEnabled:(BOOL)yesNo{
	if(yesNo)
		[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
	else{
		[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
		NSLog(@"no notifs :(");
	}
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
	//dispatch_async(dispatch_get_main_queue(), ^{
		NSLog(@"fetching");
		
		[NetworkStatus setSlowNetwork:NO];
		
		if(![NetworkStatus networkExists])
			completionHandler(UIBackgroundFetchResultFailed);
		
		else if([[NSUserDefaults standardUserDefaults]boolForKey:@"tweetSwitch"]){
			
			if([HomeViewController refreshTweets])
				completionHandler(UIBackgroundFetchResultNewData);
			else
				completionHandler(UIBackgroundFetchResultNoData);
		}
		else
			completionHandler(UIBackgroundFetchResultNoData);
		
	});
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