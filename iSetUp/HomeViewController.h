//
//  HomeViewController.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import "Sounds.h"


@class Sounds;

@interface HomeViewController : UIViewController <FlipsideViewControllerDelegate, UIAlertViewDelegate,UIWebViewDelegate>{
     Sounds *sounds;
      
    NSTimer *viewTimer;
    
    IBOutlet UIView *donationView;
    IBOutlet UIWebView *webview;
    IBOutlet UIActivityIndicatorView *activity;

}

-(IBAction)VewThemes:(id)sender;
-(IBAction)VewWeather:(id)sender;
- (IBAction)showInfo:(id)sender;
-(IBAction)about:(id)sender;
-(void)showDonationView;
-(IBAction)removeDonationView;
-(IBAction)advanced:(id)sender;
-(IBAction)viewIcons;


@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
