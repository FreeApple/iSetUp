//
//  ThemeXMLInfo.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "ThemeXMLInfo.h"

@implementation ThemeXMLInfo
@synthesize themeName;
@synthesize themeArtist;
@synthesize themeImage;
@synthesize themeDescription;
@synthesize twitterName;
@synthesize themePrice;
@synthesize screenshots;
@synthesize cydiaLink;
@synthesize weather;
@synthesize help;
@synthesize channelLog;




-(void)dealloc{
    
      [super dealloc];
    
    //Ive only released items in use at the moment..."lazy coding"
    [themeName release];
    [themeArtist release];
    [themeDescription release];
    [themeImage release];
    
  
    
}

@end
