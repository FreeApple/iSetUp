//
//  XMLParser.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

@synthesize themes;

-(id) loadXMLByString:(NSString *)fileString{
    
    //THIS CAN BE FROM A URL IF NEEDED TO PARSE OF LIVE SERVER
    
    themes          = [[NSMutableArray alloc] init];
    NSData  *data   = [[NSData alloc] initWithContentsOfFile:fileString];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;    
    
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname   
   namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
     attributes:(NSDictionary *)attributeDict
{
    
    
    if ([elementname isEqualToString:@"themeinfo"]) 
    {
        currentTheme = [ThemeXMLInfo alloc];
    }
}


- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName     
   namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{  
    
    if ([elementName isEqualToString:@"name"]) {
        
        currentTheme.themeName = currentNodeContent;
        NSLog(@"%@",currentNodeContent);
    }
    
    if ([elementName isEqualToString:@"creator"]) {
        
        currentTheme.themeArtist = currentNodeContent;
    }  
    
    if ([elementName isEqualToString:@"price"]) {
        
        currentTheme.themePrice = currentNodeContent;
    }      
    
    if ([elementName isEqualToString:@"twitter"]) {
        
        currentTheme.twitterName = currentNodeContent;
    }  
    
    if ([elementName isEqualToString:@"link"]) {
        
        currentTheme.cydiaLink = currentNodeContent;
    }   
    
    if ([elementName isEqualToString:@"screenshots"]) {
        
        currentTheme.screenshots = currentNodeContent;
    } 
    
    if ([elementName isEqualToString:@"preview"]) {
        
        currentTheme.themeImage = currentNodeContent;
       // NSLog(@"PreviewIMG = %@",currentNodeContent);

    } 
    
    if ([elementName isEqualToString:@"description"]) {
        
        currentTheme.themeDescription = currentNodeContent;
    }     
    
    if ([elementName isEqualToString:@"weather"]) {
        
        currentTheme.weather = currentNodeContent;
    }       
    
    if ([elementName isEqualToString:@"help"]) {
        
        currentTheme.help = currentNodeContent;
    }       
    
    if ([elementName isEqualToString:@"channellog"]) {
        
        currentTheme.channelLog = currentNodeContent;
    }     
    
    if ([elementName isEqualToString:@"themeinfo"]) 
    {
        [themes addObject:currentTheme];
        [currentTheme release];
        currentTheme = nil;
        [currentNodeContent release];
        currentNodeContent = nil;
        
    }
    
}



- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString *) [string    
                                              stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


//TODO
//Add core data .... save info for theme defaults "not nessicarry but a idea for future development"


@end
