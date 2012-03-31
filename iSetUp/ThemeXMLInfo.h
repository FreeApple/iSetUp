//
//  ThemeXMLInfo.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeXMLInfo : NSObject{
    
    NSString * themeName;
    NSString * themeArtist;
    NSString * themeImage;
    NSString * themeDescription;
    NSString * twitterName;
    NSString * themePrice;
    NSString * screenshots;
    NSString * cydiaLink;
    NSString * weather;
    NSString * help;
    NSString * channelLog;
}

@property (nonatomic, retain) NSString * themeName;
@property (nonatomic, retain) NSString * themeArtist;
@property (nonatomic, retain) NSString * themeImage;
@property (nonatomic, retain) NSString * themeDescription;
@property (nonatomic, retain) NSString * twitterName;
@property (nonatomic, retain) NSString * themePrice;
@property (nonatomic, retain) NSString * screenshots;
@property (nonatomic, retain) NSString * cydiaLink;
@property (nonatomic, retain) NSString * weather;
@property (nonatomic, retain) NSString * help;
@property (nonatomic, retain) NSString * channelLog;


@end
