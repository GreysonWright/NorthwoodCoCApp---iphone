//
//  UniversalWebViewViewController.h
//  NorthwoodCoC
//
//  Created by greyson on 6/22/14.
//  Copyright (c) 2014 Greyson Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversalWebViewViewController : UIViewController

@property (weak) IBOutlet UIWebView *webView;

-(void)loadSermonAudio:(NSString*)URL;
//-(void)loadBulletinPDF:(NSString*)URL;
-(void)loadPDF:(NSString*)fileName;
@end
