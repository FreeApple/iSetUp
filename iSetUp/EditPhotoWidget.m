//
//  EditPhotoWidget.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "EditPhotoWidget.h"
#import "MWPhotoBrowser.h"
#import "PhotoThumbs.h"
#import "UIImageView+WebCache.h"


@implementation EditPhotoWidget
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
   
     change.enabled = NO;
    
    self.navigationItem.title = @"PhotoWidget";
    
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:selectedThemeName
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
    
    
    contentOfFolder = [[NSArray alloc] init];
    directoriesOfFolder = [[NSMutableArray alloc ] initWithCapacity:0];
    NSString *path = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/",selectedThemeName];  
    contentOfFolder = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    [directoriesOfFolder addObjectsFromArray:contentOfFolder];
    
    NSLog(@"images are %@",[directoriesOfFolder description]);
    
    
    
    NSString *path6 = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/LockBackground.JPG",selectedThemeName];   
    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path6];
    widgetImg.image = bg;   


    [path6 release];

}


-(IBAction)changeWidgetImage:(id)sender{
    
    
    contentOfFolder = [[NSArray alloc] init];
    directoriesOfFolder = [[NSMutableArray alloc ] initWithCapacity:0];
    NSString *path = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/",selectedThemeName];  
    contentOfFolder = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    [directoriesOfFolder addObjectsFromArray:contentOfFolder];
    
    NSLog(@"images are %@",[directoriesOfFolder description]);
    
    
    
    NSString *path6 = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/LockBackground.JPG",selectedThemeName];   
    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path6];
    widgetImg.image = bg;   
    
    // [self removeImage:bg atPath:
}



-(IBAction)viewAllPhotos:(id)sender{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    //[photos addObjectsFromArray:directoriesOfFolder];
    // Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
	//[browser setInitialPageIndex:0]; // Can be changed if desired
    // [self.navigationController pushViewController:browser animated:YES];    
	[self presentModalViewController:browser animated:YES];
	[browser release];
	[photos release];    
    
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"image picker did finish");
    
    
    
    
    widgetImg.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    change.enabled = YES;
    
    [self saveImage:widgetImg.image :ImgName];
    NSString *path = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/%@",selectedThemeName,ImgName]; 
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    NSLog(@"Path to file: %@", path);        
    NSLog(@"File exists: %d", fileExists);
    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:path]);
    if (fileExists) 
    {
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
    
    
    [self dismissModalViewControllerAnimated:YES]; 
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"image picker did cancel");
    
    
    [self dismissModalViewControllerAnimated:YES];   
    
}

-(IBAction)pickImage{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self; 
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing = YES;
    imagePicker.mediaTypes = [NSArray arrayWithObject:@"public.image"];
    [self presentModalViewController:imagePicker animated:YES];
    
    [imagePicker release];
}

- (void)saveImage:(UIImage*)image:(NSString*)imageName {  
    //convert image into .png format.  
    NSData *imageData = UIImagePNGRepresentation(image);  
    NSFileManager *fileManager = [NSFileManager defaultManager];   
    NSString *IMGPath = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/",selectedThemeName]; 
       
    
    [fileManager createFileAtPath:IMGPath contents:imageData attributes:nil];  
    NSLog(@"image saved"); 
    
} 


- (void)removeImage:(NSString*)fileName atPath:(NSString*)path {  
    
    NSFileManager *fileManager = [NSFileManager defaultManager];  
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = path; 
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:  
                          [NSString stringWithFormat:@"%@.JPG", fileName]];  
    
    [fileManager removeItemAtPath: fullPath error:NULL];  
    NSLog(@"image removed");  
    
}  


- (UIImage*)loadImage:(NSString*)imageName {  
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];  
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:  
                          [NSString stringWithFormat:@"%@.png", imageName]];  
    
    return [UIImage imageWithContentsOfFile:fullPath];  
    
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
    
    static NSString *CellIdentifier = @"photoThumbCell";

	
	//ThemeParseObject *currentTheme = [[XMLparser themes] objectAtIndex:indexPath.row];
    
    
    PhotoThumbs *customCell = (PhotoThumbs *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"photoThumbCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                customCell =  (PhotoThumbs *) currentObject;
                break;
            }
        }
    }
    
    
    ImgName = [directoriesOfFolder objectAtIndex:indexPath.row];
    
  
    
    NSString *path = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/%@",selectedThemeName,ImgName]; 
       UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path];
        customCell.thumb.image = bg;      
       
    
        
        customCell.thumb.layer.masksToBounds = YES;
        customCell.thumb.layer.cornerRadius = 2.0;
        
        //  NSLog(@"contents %@",directoriesOfBundles);    
        
        
        
        [tableView setBackgroundColor:[UIColor clearColor]];         
        
      
    return customCell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 65;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    myPath = indexPath;
    
    [self pickImage];
    ImgName = [directoriesOfFolder objectAtIndex:indexPath.row];

    
    NSString *path = [NSString stringWithFormat:@"/Library/Themes/%@/iSetUp/UserPhotos/%@",selectedThemeName,ImgName]; 

    UIImage *bg = [[UIImage alloc] initWithContentsOfFile:path];
    widgetImg.image = bg;      
    
 


}





-(IBAction)backButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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

@end
