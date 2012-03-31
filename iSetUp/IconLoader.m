//
//  IconLoader.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "IconLoader.h"
#import "IconLoaderObjects.h"


@implementation IconLoader
@synthesize selectedThemeName;

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
   
     self.navigationItem.title = @"Icons";
    
    contentOfFolder = [[NSArray alloc] init];
    directoriesOfFolder = [[NSMutableArray alloc ] initWithCapacity:0];
    NSString *path = @"/Applications/";
    contentOfFolder = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    [directoriesOfFolder addObjectsFromArray:contentOfFolder];
    



}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [directoriesOfFolder count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"IconCell";
    
	myPath = indexPath;
	//ThemeParseObject *currentTheme = [[XMLparser themes] objectAtIndex:indexPath.row];
    
    
    IconLoaderObjects *customCell = (IconLoaderObjects *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IconCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                customCell =  (IconLoaderObjects *) currentObject;
                break;
            }
        }
    }
    
    
    
    
    appName = [directoriesOfFolder objectAtIndex:myPath.row];
    
    
    NSString *path = [NSString stringWithFormat:@"/Applications/%@/icon@2x.png",appName]; 
    NSLog(@"%@",path);
    
    if (path == NULL) {
        NSString *path = [NSString stringWithFormat:@"/Applications/%@/Icon@2x.png",appName]; 
        UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path];
        customCell.icon.image = bg; 
    
    }
    else{
    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path];
    customCell.icon.image = bg;      
    }
    
    
    //  NSLog(@"contents %@",directoriesOfBundles);    
    
    
    
    [tableView setBackgroundColor:[UIColor clearColor]];           
     
    
    return customCell;
    
    
}




// custom hieght 


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 60;
    
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
