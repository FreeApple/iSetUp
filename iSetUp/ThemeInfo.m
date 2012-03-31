//
//  ThemeInfo.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "ThemeInfo.h"
#import "XMLParser.h"
#import "DetailsCellObject.h"
#import "UIImageView+WebCache.h"
#import "Twitter/Twitter.h"
#import "EditPhotoWidget.h"

@implementation ThemeInfo
@synthesize selectedThemeName;
@synthesize selectedXML;
@synthesize imgPath;


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
     
    xmlParser  = [[XMLParser alloc] loadXMLByString:selectedXML];

    self.navigationItem.title = @"Theme SetUp";

    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:selectedThemeName
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    
    
    return [[xmlParser themes] count];
 
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"DetailsCell";
	
    ThemeXMLInfo *event = [[xmlParser themes] objectAtIndex:indexPath.row];
    
    
    DetailsCellObject *customCell = (DetailsCellObject *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailsCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                customCell =  (DetailsCellObject *) currentObject;
                break;
            }
        }
    }

    
   customCell.name.text = [event themeName];
    customCell.artist.text = [event themeArtist];
    customCell.desc.text = [event themeDescription];
    
    
    
    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:imgPath];
    customCell.thumb.image = bg;          
    
    customCell.thumb.layer.masksToBounds = YES;
    customCell.thumb.layer.cornerRadius = 2.0;
    
    
    
    return  customCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { 

    return 480;

}



-(IBAction)tweet:(id)sender{
    
    ThemeXMLInfo *event = [[xmlParser themes] objectAtIndex:0];

    
    
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    // Optional: set an image, url and initial text
    //[twitter addImage:[UIImage imageNamed:@"iOSDevTips.png"]];
    [twitter addURL:[NSURL URLWithString:[NSString stringWithString:@"http://iOSDeveloperTips.com/"]]];
    NSString *string = [NSString stringWithFormat:@"%@ I need help with #%@ ",[event twitterName],selectedThemeName];
    [twitter setInitialText:string];
    
    // Show the controller
    [self presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
    {
        NSString *title = @"Tweet Status";
        NSString *msg; 
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet compostion was canceled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet composition completed.";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };
}


-(IBAction)editPlist:(id)sender{
    [self showEditorView];

NSString *plistPath = [NSString stringWithFormat:@"/Library/Themes/%@/",selectedThemeName];
  
    NSString *finalPath = [plistPath stringByAppendingPathComponent:@"Info.plist"];
    NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];   
    
    NSLog(@"Plist Data %@",plistData);
    
    plistdatatext.text = [plistData description];
    
    NSString *datestyle = [plistData objectForKey:@"CalendarIconDateStyle"];
    NSString *daystyle = [plistData objectForKey:@"CalendarIconDayStyle"];
      NSString *dockicon = [plistData objectForKey:@"DockedIconLabelStyle"];
      NSString *Undockicon = [plistData objectForKey:@"UndockedIconLabelStyle"];
    NSString *timestyle = [plistData objectForKey:@"TimeStyle"];
    
    one.text =datestyle;
    two.text = daystyle;
    three.text = dockicon;
    four.text = Undockicon;
    five.text = timestyle;

}


-(IBAction)editHTML:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"Just have not gotten this far yet" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];
}


-(IBAction)viewChannelLog:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"Just have not gotten this far yet" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)showEditorView{
    
    CGRect viewFrame1 = [editoView frame];
    viewFrame1.origin.y = 480;
    editoView.frame = viewFrame1;
    
    
    [UIView beginAnimations:@"animateView" context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect viewFrame = [editoView frame];
    viewFrame.origin.y = 0;
    editoView.frame = viewFrame;
    [UIView commitAnimations];  
    [self.navigationController.view addSubview:editoView];    
    
}


-(IBAction)removeEditorView{
    
    [one resignFirstResponder];
    
    [UIView beginAnimations:@"animateView" context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect viewFrame = [editoView frame];
    viewFrame.origin.y = 480;
    editoView.frame = viewFrame;
    [UIView commitAnimations];  
  
    viewTimer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(removeEditorViewFromSuper) userInfo:nil repeats:NO];

}

-(void)removeEditorViewFromSuper{
    
    [editoView removeFromSuperview];
}




-(IBAction)photoWidgetEditor:(id)sender{
    
    EditPhotoWidget *edit = [[EditPhotoWidget alloc ] init];
    edit.selectedThemeName = selectedThemeName;
    [self.navigationController pushViewController:edit animated:YES];
    
    
}


-(IBAction)backButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    xmlParser = nil;
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

@end
