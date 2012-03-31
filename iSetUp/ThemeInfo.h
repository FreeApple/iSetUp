//
//  ThemeInfo.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "ThemeXMLInfo.h"


@class XMLParser;


@interface ThemeInfo : UIViewController <UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
   
    NSTimer *viewTimer;
    NSString *selectedThemeName;
    NSString *selectedXML;
    
   
    
    IBOutlet UILabel *name;
    XMLParser *xmlParser;
    NSMutableArray *theme;
    IBOutlet UITableView *tblView;
    IBOutlet UIView *editoView;
    IBOutlet UITextView *plistdatatext;
    
    IBOutlet UITextField *one;
    IBOutlet UITextField *two;
    IBOutlet UITextField *three;
    IBOutlet UITextField *four;
    IBOutlet UITextField *five;
    

    
}

-(IBAction)backButton:(id)sender;
-(IBAction)tweet:(id)sender;
-(IBAction)editPlist:(id)sender;
-(IBAction)editHTML:(id)sender;
-(IBAction)removeEditorView;
-(IBAction)viewChannelLog:(id)sender;
-(void)showEditorView;
-(IBAction)photoWidgetEditor:(id)sender;









@property (nonatomic, retain) NSString *selectedThemeName;
@property (nonatomic, retain) NSString  *selectedXML;
@property (nonatomic, retain) NSString  *imgPath;

@end
