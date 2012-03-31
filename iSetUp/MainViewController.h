//
//  MainViewController.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Sounds.h"

@class Sounds;

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    NSDictionary *userInfo;   
    Sounds *sounds;
    NSMutableArray * directoriesOfFolder; 
    NSArray *contentOfFolder;
    NSMutableArray * directoriesOfFolderIcons; 
    NSArray *contentOfFolderIcon;
    
    NSMutableArray *iSetUpFolders;
    
    NSMutableArray * directoriesOfBundles; 
    NSArray *contentOfBundles;    
    
    NSIndexPath *myPath;
    NSString *ThemeName;

    
    IBOutlet UITableView *myTableView;    

    
  
    
    
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



-(void)scanThemesForiSetUp:(NSString*)iSetup;



@end
