//
//  XMLParser.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeXMLInfo.h"

@class ThemeXMLInfo;

@interface XMLParser : NSObject <NSXMLParserDelegate>  {
    
    NSMutableData *recivedData;
    NSMutableArray *themes;
    NSMutableString    *currentNodeContent;
    NSXMLParser        *parser;
    
    NSManagedObjectContext *managedObjectContext;  
    NSMutableArray *themeArray;   
    
    ThemeXMLInfo *currentTheme;
    
}

@property (readonly, retain) NSMutableArray *themes;
-(id) loadXMLByString:(NSString *)fileString;


@end
