//
//  FlipsideViewController.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Sounds.h"

@class Sounds;
@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<MFMailComposeViewControllerDelegate>{
   
    Sounds *sounds;
    NSTimer *viewTimer;
    IBOutlet UIButton *soundsSwitch;
    IBOutlet UIImageView *soundsImage;
    
    IBOutlet UIView *donationView;
    IBOutlet UIWebView *webview;
    IBOutlet UIActivityIndicatorView *activity;

}

@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
-(IBAction)showDonationView;
-(IBAction)removeDonationView;
-(IBAction)email:(id)sender;

@end
