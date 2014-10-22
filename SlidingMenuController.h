//
//  SlidingMenuController.h
//  SlidingMenuLib
//
//  Created by greyson on 10/19/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingMenuController : UIViewController <UITabBarControllerDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *viewControllerObjects;
-(void)setViewControllerObjects:(NSArray *)viewControllerObjects;
-(void)setMainViewController:(UIViewController*)viewController;

@end
