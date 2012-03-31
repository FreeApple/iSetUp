//
//  HomeViewController.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "HomeViewController.h"
#import "MainViewController.h"
#import "libWeatherController.h"
#import "ThemersSection.h"
#import "IconLoader.h"


@implementation HomeViewController
@synthesize flipsidePopoverController = _flipsidePopoverController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

   
     sounds = [[Sounds alloc] init];
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Settings"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(showInfo:)];
    self.navigationItem.rightBarButtonItem = settings;
    [settings release];
    
    UIBarButtonItem *about = [[UIBarButtonItem alloc] 
                                 initWithTitle:@"About"                                            
                                 style:UIBarButtonItemStyleBordered 
                                 target:self 
                                 action:@selector(about:)];
    self.navigationItem.leftBarButtonItem = about;
    [about release];
    
    
    self.navigationItem.title = @"iSetUp";


}

-(IBAction)VewThemes:(id)sender{
    
    MainViewController *mainThemes = [[[MainViewController alloc] initWithNibName:@"MainViewController_iPhone" bundle:nil] autorelease];
    [self.navigationController pushViewController:mainThemes animated:YES];

    
    
}


-(IBAction)VewWeather:(id)sender{
    
    libWeatherController *libWeather = [[libWeatherController alloc] init];
    [self.navigationController pushViewController:libWeather animated:YES];
    
}

-(IBAction)viewIcons{
    
    IconLoader *icons = [[IconLoader alloc] init];
    [self.navigationController pushViewController:icons animated:YES];
    
    
}



-(IBAction)about:(id)sender{
    
    [sounds PlayButtonClick:sender];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iSetUp" message:@"iSetUp is a free open souce project created by FreeAppl3. This app has the ability to do many many things for theme creators and theme users. If you have any suggestion, comments, issues please use the contact form in the settings page. Thank you" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Donate", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==0) {
        [sounds PlayButtonClick:nil];
    }
    else{
        [sounds PlayButtonClick:nil];
        [self showDonationView];
        [activity startAnimating];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HZRKSSMMK7E3U"]]];
    }
}

-(void)showDonationView{
    
    CGRect viewFrame1 = [donationView frame];
    viewFrame1.origin.y = 480;
    donationView.frame = viewFrame1;
    
    
    [UIView beginAnimations:@"animateView" context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect viewFrame = [donationView frame];
    viewFrame.origin.y = 20;
    donationView.frame = viewFrame;
    [UIView commitAnimations];  
    [self.navigationController.view addSubview:donationView];    
    
}


-(IBAction)removeDonationView{
    
    [webview stopLoading];
    
    [UIView beginAnimations:@"animateView" context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect viewFrame = [donationView frame];
    viewFrame.origin.y = 480;
    donationView.frame = viewFrame;
    [UIView commitAnimations];  
    
    viewTimer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(removeDonatorViewFromSuper) userInfo:nil repeats:NO];
    
}

-(void)removeDonatorViewFromSuper{
    
    [donationView removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [activity startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if ([webview isLoading]) {
        [activity startAnimating];
        
    }
    else{
        [activity stopAnimating];
        activity.hidden =YES;
    }
}





-(IBAction)advanced:(id)sender{
    
    ThemersSection *themers = [[ThemersSection alloc] init];
    [self.navigationController pushViewController:themers animated:YES];
    
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}




#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
    
}

- (IBAction)showInfo:(id)sender
{
    [sounds PlayButtonClick:sender];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
        controller.delegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];
    } else {
        if (!self.flipsidePopoverController) {
            FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
            controller.delegate = self;
            
            self.flipsidePopoverController = [[[UIPopoverController alloc] initWithContentViewController:controller] autorelease];
        }
        if ([self.flipsidePopoverController isPopoverVisible]) {
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        } else {
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

- (void)dealloc{
    [super dealloc];
    [_flipsidePopoverController release];
}


@end
