//
//  FlipsideViewController.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"appSounds"] == YES) {
        soundsSwitch.tag = 1;
        [soundsImage setImage:[UIImage imageNamed:@"AltSwitchOn@2x.png"]];
        [defaults synchronize];
    }
    
    else
    {
        soundsSwitch.tag = 0;
        [soundsImage setImage:[UIImage imageNamed:@"AltSwitchOff@2x.png"]];
        [defaults synchronize];
    }    

    
    
}







-(IBAction)showDonationView{
    
    CGRect viewFrame1 = [donationView frame];
    viewFrame1.origin.y = 480;
    donationView.frame = viewFrame1;
   
    
    [activity startAnimating];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HZRKSSMMK7E3U"]]];




    [UIView beginAnimations:@"animateView" context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect viewFrame = [donationView frame];
    viewFrame.origin.y = 0;
    donationView.frame = viewFrame;
    [UIView commitAnimations];  
    [self.view addSubview:donationView];    
    
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





- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    
    NSLog(@"Message Sent");
    
    
}





-(IBAction)email:(id)sender{
    
    
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    compose.mailComposeDelegate = self;
    
    [compose autorelease];  
    
    if ([MFMailComposeViewController canSendMail]) {
        
        [compose setSubject:@"Technical Support"];
        [compose setToRecipients:[NSArray arrayWithObject:@"support@idevicethemes.com"]];
        
        [compose setMessageBody:@"iSetUp Help" isHTML:NO];
        
        compose.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentModalViewController:compose animated:YES];
        
        
        
        
        
    }
    
    
    
    
    
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    [self dismissModalViewControllerAnimated:YES];

    
    if (result == MFMailComposeResultFailed) {
        UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Sending failed" message:@"Your Message was not sent Sorry for the inconvience!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [failed show];
        [failed release];
    }
    
    if (result == MFMailComposeResultSent) {
        UIAlertView *sent = [[UIAlertView alloc] initWithTitle:@"Messgae Sent" message:@"Thank you we will be looking at your message soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        
        
        [sent show];
        [sent release];
    }
    
}


-(IBAction)sounds:(id)sender{
    
    
    soundsSwitch = (UIButton *)sender;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([defaults boolForKey:@"appSounds"] == NO)
    {
        // Do something to animate out to reveal the entire image
        soundsSwitch.tag = 1;
        
        [soundsImage setImage:[UIImage imageNamed:@"AltSwitchOn@2x.png"]];
        
        [defaults setBool:YES forKey:@"appSounds"];
        [defaults synchronize];
        
        
        [sounds PlayButtonClick:sender];
        
    }
    
    else
    {
        // Do something else to animate back to its original location
        soundsSwitch.tag = 0;
        
        [soundsImage setImage:[UIImage imageNamed:@"AltSwitchOff@2x.png"]];        
        
        [defaults setBool:NO forKey:@"appSounds"];
        [defaults synchronize];
        
        [sounds PlayButtonClick:sender];        
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
