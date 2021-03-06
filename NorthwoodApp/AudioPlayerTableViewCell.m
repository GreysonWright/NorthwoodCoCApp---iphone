//
//  AudioPlayerTableViewCell.m
//  NorthwoodCoC
//
//  Created by greyson on 11/24/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import "AudioPlayerTableViewCell.h"
#import "Sermon.h"
#import "SlidingMenuController.h"

@implementation AudioPlayerTableViewCell{
	NSString *_url;
	UIView *_loadingView;
}

BOOL shouldUpdateSlider = YES;
BOOL shouldResumePlaying = YES;
BOOL initialTimeRemaining;

static AudioPlayerTableViewCell *instance;

-(instancetype)init{
	
	//init is such a way that the xib file actually works
	self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AudioPlayerTableViewCell class]) owner:nil options:nil][0];
	
	instance = self;
	
	return self;
}

- (void)awakeFromNib {
	
	self.progressSlider.transform = CGAffineTransformMakeScale(.5, .5);
	self.isLoading = NO;
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

-(void)playAudioWithURLString:(NSString*)URL withTitle:(NSString*)title{
	if (URL == nil) {
		NSLog(@"URL was nil");
	}
	else{
		self.titleLabel.text = title;
		[self buildLoadingView];
		self.isLoading = YES;
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			
			//		[self buildLoadingView];
			
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
			
			
			if([URL rangeOfString:@"2009"].location != NSNotFound  || [URL rangeOfString:@"2010"].location != NSNotFound){
				NSString *urlAddress = [@"http://www.justchristians.info" stringByAppendingString:URL];
				NSString *refinedFinalURL = [urlAddress stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
				_url = refinedFinalURL;
			}
			else if([URL rangeOfString:@"2009"].location == NSNotFound  || [URL rangeOfString:@"2010"].location == NSNotFound){
				NSString *urlAddress = [@"http://www.justchristians.info/Sermons/" stringByAppendingString:[Sermon getSermonYear]];
				NSString *nextURL = [urlAddress stringByAppendingString:URL];
				NSString *finalURL = [nextURL stringByReplacingOccurrencesOfString:@"./" withString:@""];
				NSString *refinedFinalURL = [finalURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
				NSString *secondRefinedURL = [refinedFinalURL stringByReplacingOccurrencesOfString:@"\n" withString:@"%20"];
				_url = secondRefinedURL;
			}
			
			NSError *error;
			NSError *error2;
			NSLog(@"%@", URL);
			NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_url] options:NSDataReadingUncached error:&error];
			self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:&error2];
			//self.audioPlayer.delegate = self;
			//[self.audioPlayer prepareToPlay];
			NSLog(@"%@",error);
//			[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setViewToActive) userInfo:nil repeats:NO];
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
////				[self setViewToActive];
//				self.titleLabel.text = title;
				self.playPauseButton.enabled = true;
				self.userInteractionEnabled = YES;
				self.progressSlider.maximumValue = self.audioPlayer.duration;
				[self.audioPlayer play];
				shouldUpdateSlider = YES;
				shouldResumePlaying = YES;
				[self.playPauseButton setImage:[UIImage imageNamed:@"pause44.png"] forState:UIControlStateNormal];
				self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpdater) userInfo:nil repeats:YES];
//				self.alpha = 1.0f;
				[UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{ _loadingView.alpha = 0;}completion:^(BOOL finished){
					[_loadingView removeFromSuperview];
					self.isLoading = NO;
				}];
				NSLog(@"%f", self.alpha);
			}];
			//[self setViewToActive];
			//		self.remainingLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration - self.progressSlider.value]];
			//		self.playPauseButton.titleLabel.text = @"play";
			//		[_loadingView removeFromSuperview];
			//self.slider setThumbImage:<#(UIImage *)#> forState:<#(UIControlState)#>
			
			//http://stackoverflow.com/questions/15850447/how-to-get-audio-to-play-from-an-online-url-on-iphone
		});
	}
	
}

- (IBAction)sliderPanned:(id)sender {
	shouldUpdateSlider = NO; //should be first to happen
	[[SlidingMenuController sharedInstance]panRecognizer].enabled = NO;
	[self.audioPlayer pause];
	self.playedLabel.text = [self timeFormat:self.progressSlider.value];
	self.remainingLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration - self.progressSlider.value]];
}

- (IBAction)sliderPanEnded:(id)sender {
	[self.audioPlayer setCurrentTime:self.progressSlider.value];
	if (shouldResumePlaying) {
		[self.audioPlayer play];
	}
	[[SlidingMenuController sharedInstance]panRecognizer].enabled = YES;
	shouldUpdateSlider = YES; //should be last to happen
}

-(NSString*)timeFormat:(float)value{
	
	float minutes = floor(lroundf(value)/60);
	float seconds = lroundf(value) - (minutes * 60);
	
	long roundedSeconds = lroundf(seconds);
	long roundedMinutes = lroundf(minutes);
	
	NSString *time = [[NSString alloc] initWithFormat:@"%ld:%02ld", roundedMinutes, roundedSeconds];
	return time;
}

-(void)timeUpdater{
	//self.progressBar.progress = self.audioPlayer.currentTime/self.audioPlayer.duration;
	//	double currentMinutes = floor(self.audioPlayer.currentTime/60000);
	//	double currentSeconds = floor(self.audioPlayer.currentTime - currentMinutes/60);
	//	double durrationMinutes = floor(self.audioPlayer.duration/60);
	//	double durrationSeconds = floor((self.audioPlayer.duration - durrationMinutes)/60);
	
	if (shouldUpdateSlider){
		self.progressSlider.value = self.audioPlayer.currentTime;
		self.playedLabel.text = [self timeFormat:self.audioPlayer.currentTime];
		self.remainingLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration - self.audioPlayer.currentTime]];
		NSLog(@"%f", self.audioPlayer.duration);
		NSLog(@"%d", shouldResumePlaying);
		//self.timeLabel1.text = [NSString stringWithFormat:@"%.0f:%.0f", currentMinutes, currentSeconds];
		//self.timeLabel2.text = [NSString stringWithFormat:@"%.0f:%.0f", durrationMinutes -  currentMinutes, durrationSeconds - currentSeconds];
	}
}

- (IBAction)playPauseTouched:(id)sender {
	if(self.audioPlayer.isPlaying){
		[self.audioPlayer stop];
		[self.timer invalidate];
		shouldResumePlaying = NO;
		shouldUpdateSlider = NO;
		//		self.playPauseButton.titleLabel.text = @"pause";
		//		[self.playPauseButton setTitle:@"play" forState:UIControlStateNormal];
		[self.playPauseButton setImage:[UIImage imageNamed:@"media23.png"] forState:UIControlStateNormal];
	}
	else{
		[self.audioPlayer play];
		shouldUpdateSlider = YES;
		shouldResumePlaying = YES;
		//		self.playPauseButton.titleLabel.text = @"play";
		//		[self.playPauseButton setTitle:@"pause" forState:UIControlStateNormal];
		[self.playPauseButton setImage:[UIImage imageNamed:@"pause44.png"] forState:UIControlStateNormal];
		self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpdater) userInfo:nil repeats:YES];
	}
	NSLog(@"%d",self.audioPlayer.isPlaying);
}

-(void)stopPlayer{
	[self.audioPlayer stop];
	[self.timer invalidate];
	shouldResumePlaying = NO;
	shouldUpdateSlider = NO;
}

-(void)buildLoadingView{
	if(!_loadingView)
	{
		_loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 19)];
		[_loadingView setBackgroundColor:[UIColor blackColor]];
		_loadingView.alpha = .6;
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		//[indicator setFrame:CGRectMake((160), (260), 0, 0)];
		indicator.center = CGPointMake(self.center.x - 15, (self.center.y - 5));
//		UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((0), (280), 320, 30)];
//		loadingLabel.center = CGPointMake(self.center.x, self.center.y + 20);
//		loadingLabel.textColor = [UIColor whiteColor];
//		[loadingLabel setTextAlignment:NSTextAlignmentCenter];
//		loadingLabel.text = @"Fetching new data";

		[_loadingView addSubview:indicator];
//		[_loadingView addSubview:loadingLabel];

		[indicator startAnimating];
	}
	[self addSubview:_loadingView];

}

+(AudioPlayerTableViewCell*)sharedInstance{ // we do actually need this
	if(instance == nil){
		NSLog(@"something broke");
	}
	return instance;
}

@end
