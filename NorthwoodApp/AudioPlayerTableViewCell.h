//
//  AudioPlayerTableViewCell.h
//  NorthwoodCoC
//
//  Created by greyson on 11/24/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISlider *progressSlider;
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) IBOutlet UILabel *playedLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainingLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property BOOL isLoading;
@property AVAudioPlayer *audioPlayer;
@property NSTimer *timer;

-(void)playAudioWithURLString:(NSString*)URL withTitle:(NSString*)title;
-(void)stopPlayer;
+(AudioPlayerTableViewCell*)sharedInstance;

@end
