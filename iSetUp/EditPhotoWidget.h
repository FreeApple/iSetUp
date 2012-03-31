//
//  EditPhotoWidget.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPhotoWidget : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSMutableArray * directoriesOfFolder; 
    NSArray *contentOfFolder;
    NSString *ImgName;

    NSIndexPath *myPath;
    
    
    IBOutlet UIImageView *widgetImg;
    IBOutlet UIBarButtonItem *change;
    IBOutlet UITableView *tblView;
    
    
    
    
}

-(IBAction)changeWidgetImage:(id)sender;
-(IBAction)pickImage;
- (void)saveImage:(UIImage*)image:(NSString*)imageName;
- (void)removeImage:(NSString*)fileName atPath:(NSString*)path ;
- (UIImage*)loadImage:(NSString*)imageName;
-(IBAction)viewAllPhotos:(id)sender;




@property (nonatomic, retain) NSString *selectedThemeName;

@end
