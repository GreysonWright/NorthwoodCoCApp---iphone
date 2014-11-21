//
//  SlidingMenuController.m
//  SlidingMenuLib
//
//  Created by greyson on 10/19/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SlidingMenuController.h"
#import "LogginginViewController.h"

@interface SlidingMenuController (){
	BOOL _presented;
	BOOL _moving;
	BOOL _shouldHideMenuButton; //need to make this and the method actually hide the menuButton
	UIView *subView;
//	NSTimer* timer;
}

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;
@property UIPanGestureRecognizer *panRecognizer;
//@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SlidingMenuController

static BOOL shouldHideMenuButton = NO;
//static BOOL shouldResetMenu = NO;
static __strong SlidingMenuController* instance;

+(SlidingMenuController*)sharedInstance{
	
	if (instance == nil) {
		
		NSLog(@"this is broken");
		
	}
	
	return instance;
	
}

#pragma mark - setup methods
- (void)viewDidLoad {
//	shouldHideMenuButton = YES;
//	timer  = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkVals) userInfo:nil repeats:YES];
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if(self){
		self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userPanned:)];
		[self.view addGestureRecognizer:self.panRecognizer];
		instance = self;
	}
	return self;
}

-(void)viewDidAppear:(BOOL)animated{
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:0];
	subView = viewController.view;
	[subView addSubview:self.menuButton];
	self.menuButton.hidden = NO;
	[self.viewContainer addSubview:subView];
	[self.viewContainer sendSubviewToBack:subView];
	[super viewDidAppear:animated];
}

-(void)setViewControllers:(NSArray *)viewControllerObjects{
	self.viewControllerObjects = viewControllerObjects;
}

-(void)setMainViewController:(UIViewController*)viewController{
//	[self flushViews];
//	if(subView != nil){
//		[subView removeFromSuperview];
//		subView = nil;
//	}
//	subView = viewController.view;
//	[subView addSubview:self.menuButton];
//	self.menuButton.hidden = NO;
//	[self.viewContainer addSubview:subView];
//	[self.viewContainer sendSubviewToBack:subView];

	if (subView != nil) {
		[subView removeFromSuperview];
		subView = nil;
		NSArray *views = self.viewContainer.subviews;
		for (UIView *view in views) {
			[view removeFromSuperview];
			NSLog(@"%@",view);
		}
		NSLog(@"%lu",(unsigned long)views.count);
	}
	subView = viewController.view;
	[self.viewContainer addSubview:subView];
	[self.view sendSubviewToBack:self.viewContainer];
	
}

#pragma mark - gestureRecognizer

- (void)userPanned:(UIPanGestureRecognizer*)recognizer{
	CGPoint translatedPoint = [recognizer translationInView:recognizer.view];
	//CGPoint velocity = [recognizer velocityInView:recognizer.view];
	
	if(recognizer.state == UIGestureRecognizerStateBegan){
		[recognizer setTranslation:CGPointMake(recognizer.view.frame.origin.x, 0) inView:recognizer.view];
	}
	
	if(recognizer.state == UIGestureRecognizerStateEnded) {
		if(_presented){
			[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.viewContainer.transform = CGAffineTransformMakeTranslation(260, 0);
			}completion:nil];
			//_presented = YES;
		}
		else if(!_presented){
			[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.viewContainer.transform = CGAffineTransformIdentity;
			}completion:nil];
			//_presented = NO;
		}
		else{
			NSLog(@"do nothing");
		}
	}
	
	if(recognizer.state == UIGestureRecognizerStateBegan){
		[recognizer setTranslation:CGPointMake(self.viewContainer.frame.origin.x, 0) inView:self.viewContainer];
	}
	
	if(recognizer.state == UIGestureRecognizerStateChanged) {
		if(translatedPoint.x < 320/2){
			_presented = NO;
		}
		
		else{
			_presented = YES;
		}
		
		[self.viewContainer setTransform:CGAffineTransformMakeTranslation(MAX(0,translatedPoint.x), 0)];
		
	}
	if(recognizer.state == UIGestureRecognizerStateCancelled) {
		NSLog(@"cancelled");
	}
}

#pragma mark - view actions


-(void)hideView{
	[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		self.viewContainer.transform = CGAffineTransformIdentity;
	}completion:nil];
	_presented = NO;
}

-(void)showView{
	[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		self.viewContainer.transform = CGAffineTransformMakeTranslation(260, 0);
	}completion:nil];
	_presented = YES;
}

#pragma mark - button actions

- (IBAction)menuButtonPressed:(id)sender {
	if(!_presented){
		[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
			self.viewContainer.transform = CGAffineTransformMakeTranslation(260, 0);
		}completion:nil];
		_presented = YES;
	}
	else{
		[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
			self.viewContainer.transform = CGAffineTransformIdentity;
		}completion:nil];
		_presented = NO;
		
	}
}

#pragma mark - table view methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.viewControllerObjects.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if(cell == nil){
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:indexPath.row];
	cell.backgroundColor = [UIColor colorWithRed:45.0/255.0f green:45.0/255.0f blue:48.0/255.0f alpha:1];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.text = viewController.title;
	cell.imageView.image = viewController.tabBarItem.image;
	cell.imageView.image = [cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	cell.imageView.tintColor = [UIColor whiteColor];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (subView != nil) {
		//[subView removeFromSuperview];
		subView = nil;
		NSArray *views = self.viewContainer.subviews;
		for (UIView *view in views) {
			[view removeFromSuperview];
			NSLog(@"%@",view);
		}
		NSLog(@"%lu",(unsigned long)views.count);
	}
	UIViewController *viewController = [self.controllerObjects objectAtIndex:indexPath.row];
	subView = viewController.view;
	[self.viewContainer addSubview:subView];
	[self.viewContainer sendSubviewToBack:subView];
	[self hideView];
}

#pragma mark - other actions
//+(void)shouldHideMenuButton:(BOOL)shouldHide{
//	
//	shouldHideMenuButton = shouldHide;
//	
////	static SlidingMenuController* slidingMenu;
////	
////	@synchronized (self){
////		if (!slidingMenu)
////			slidingMenu = [[SlidingMenuController alloc]init];
////	}
////	
////	[slidingMenu checkMenuButton];
////	NSLog(@"%d", shouldHide);
//}

//+(void)resetMenu{
//	shouldResetMenu = YES;
//}

//-(void)checkVals{
//	
//	if(shouldResetMenu){
////		[subView removeFromSuperview];
////		subView = nil;
//		UIViewController *viewController = [self.viewControllerObjects objectAtIndex:0];
//		[self setMainViewController:viewController];
//		shouldResetMenu = NO;
//	}
//	
//	if (!shouldHideMenuButton) {
//		self.menuButton.hidden = NO;
////		[timer invalidate];
//	}
//	else
//		self.menuButton.hidden = YES;
//}

-(void)resetMenu{
	
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:0];
	[self setMainViewController:viewController];
	
}

-(void)flushViews{
	[subView removeFromSuperview];
	subView = nil;
	for (UIView *view in [self.viewContainer subviews]){
		[view removeFromSuperview];
	}
	NSLog(@"subview - %@",subView);
}

-(void)logout{
	
	LogginginViewController *loginView = [[LogginginViewController alloc]init];
	[self presentViewController:loginView animated:YES completion:nil];
	self.loggedIn = NO;
	
}

-(void)login{
	
	self.loggedIn = YES;
	
}

-(void)showLoginView{
	
	if (!self.loggedIn && !self.isChangingView) {
		
		LogginginViewController *loginView = [[LogginginViewController alloc]init];
		
		[self presentViewController:loginView animated:YES completion:nil];
		
	}
	
}

-(void)cancelLogin{
	
	self.isChangingView = YES;
	
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:0];
	
	[self setMainViewController:viewController];
	
}

@end