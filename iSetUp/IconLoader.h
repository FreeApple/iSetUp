//
//  IconLoader.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconLoader : UIViewController{
    
    NSMutableArray * directoriesOfFolder; 
    NSArray *contentOfFolder;
    NSIndexPath *myPath;
    NSString *appName;
    
    
    IBOutlet UITableView *tbl;
    
}
@property (nonatomic, retain) NSString *selectedThemeName;
@end
