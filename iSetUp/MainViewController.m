//
//  MainViewController.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "MainViewController.h"
#import "SetUpCell.h"
#import "ThemeInfo.h"

@implementation MainViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
  

    self.navigationItem.title = @"Themes";
    
   
    
    sounds = [[Sounds alloc] init];
    
    
    contentOfFolder = [[NSArray alloc] init];
    directoriesOfFolder = [[NSMutableArray alloc ] initWithCapacity:0];
    NSString *path = @"/Library/Themes";
    contentOfFolder = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    [directoriesOfFolder addObjectsFromArray:contentOfFolder];
    
    
    
    iSetUpFolders = [[NSMutableArray alloc] init];
    NSString *iSetUpPath = [NSString stringWithFormat:@"%@/iSetUp",[directoriesOfFolder objectAtIndex:1]];
    contentOfFolder = [[NSFileManager defaultManager] directoryContentsAtPath:iSetUpPath];
    [iSetUpFolders addObjectsFromArray:contentOfFolder];
    
    
   // [self scanThemesForiSetUp:iSetUpPath];
     
}
     
     
-(void)scanThemesForiSetUp:(NSString*)iSetup{

    NSFileManager *manager = [[NSFileManager defaultManager] init];
    
    
    if ( ![manager fileExistsAtPath:iSetup] ) {
        
        NSLog(@"No set up folder available %@",iSetup);
        
        
        
    } 
    else {
        [iSetUpFolders addObject:iSetup];
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [directoriesOfFolder count];
    //return [iSetUpFolders count];
    
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"SetUpCellView";
	
    myPath = indexPath;
	
	//ThemeParseObject *currentTheme = [[XMLparser themes] objectAtIndex:indexPath.row];
    
    
    SetUpCell *customCell = (SetUpCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SetUpCellView" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                customCell =  (SetUpCell *) currentObject;
                break;
            }
        }
    }
    
    
    ThemeName = [directoriesOfFolder objectAtIndex:indexPath.row];
    
    NSString *iSetUpPath = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp",ThemeName];
    NSFileManager *manager = [[NSFileManager defaultManager] init];
    
    
    if ( ![manager fileExistsAtPath:iSetUpPath] ) {
        
        NSLog(@"No set up folder available");
        
       customCell.name.text = ThemeName;

        
    } 
    else {

    
    customCell.name.text = ThemeName;
    
    
    
    NSString *path6 = [NSString stringWithFormat:@"/Library/Themes/%@/thumbnail.png",ThemeName];   
    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path6];
    customCell.BG.image = bg;      
    
    
     customCell.BG.layer.masksToBounds = YES;
     customCell.BG.layer.cornerRadius = 2.0;
    
    //  NSLog(@"contents %@",directoriesOfBundles);    
    
    
    
    [tableView setBackgroundColor:[UIColor clearColor]];         
    
    
    }
    
    return customCell;
    
    
}




// custom hieght 


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 140;
    
    
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     ThemeName = [directoriesOfFolder objectAtIndex:indexPath.row];
    
    NSString *iSetUpPath = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp",ThemeName];
    NSFileManager *manager = [[NSFileManager defaultManager] init];
    
    
    if ( ![manager fileExistsAtPath:iSetUpPath] ) {
        
        NSLog(@"No set up folder available");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Set Up" message:@"Sorry but the creator has not placed a set up file for this theme." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    } 
    else {
    
    
    
    
     ThemeInfo *preview = [[ThemeInfo alloc] init];
     ThemeName = [directoriesOfFolder objectAtIndex:indexPath.row];
     NSString *theName = ThemeName;	
     NSString *XML = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/XML/info.xml",ThemeName]; 
     NSString *imgPath = [NSString stringWithFormat:@"/Library/Themes/%@/thumbnail.png",ThemeName];
    
    
    preview.selectedThemeName = theName;
    preview.selectedXML = XML;
    preview.imgPath = imgPath;
    
    //[self presentModalViewController:preview animated:YES];   
    [self.navigationController pushViewController:preview animated:YES];
    }
    
}




- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(editingStyle == UITableViewCellEditingStyleDelete) {		
        //Delete the object from the table.
		[directoriesOfFolder removeObjectAtIndex:indexPath.row];
        [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
        ThemeName = [directoriesOfFolder objectAtIndex:indexPath.row];
        
        NSString *iSetUpPath = [NSString stringWithFormat:@"/Library/Themes/%@",ThemeName];
        NSFileManager *manager = [[NSFileManager defaultManager] init];
        
        [manager removeItemAtPath:iSetUpPath error:NULL];
      
    }
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



- (void)dealloc
{
    [_managedObjectContext release];
    [super dealloc];
}



@end
