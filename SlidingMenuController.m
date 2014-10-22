//
//  SlidingMenuController.m
//  SlidingMenuLib
//
//  Created by greyson on 10/19/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "SlidingMenuController.h"

@interface SlidingMenuController (){
	BOOL _presented;
	BOOL _moving;
	UIView *subView;
}

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;
@property UIPanGestureRecognizer *panRecognizer;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SlidingMenuController

#pragma mark - setup methods
- (void)viewDidLoad {
	
	self.navigationController.navigationBarHidden = YES;
	
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
	}
	return self;
}

-(void)viewDidAppear:(BOOL)animated{
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:0];
	subView = viewController.view;
	[self.viewContainer addSubview:subView];
	[self.viewContainer sendSubviewToBack:subView];
	[super viewDidAppear:animated];
}

-(void)setViewControllers:(NSArray *)viewControllerObjects{
	self.viewControllerObjects = viewControllerObjects;
}

-(void)setMainViewController:(UIViewController*)viewController{
	subView = viewController.view;
	[self.viewContainer addSubview:subView];
	[self.viewContainer sendSubviewToBack:subView];
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

#pragma mark - buttons

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
	cell.textLabel.text = viewController.title;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(subView != nil){
		[subView removeFromSuperview];
	}
	UIViewController *viewController = [self.viewControllerObjects objectAtIndex:indexPath.row];
	subView = viewController.view;
	[self.viewContainer addSubview:subView];
	[self.viewContainer sendSubviewToBack:subView];
	self.titleLabel.text = viewController.title;
	[self hideView];
	[self.menuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
