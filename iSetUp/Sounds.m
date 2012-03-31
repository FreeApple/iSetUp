//
//  Sounds.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

//Any Sound can be added I give one in this app to show how

#import "Sounds.h"

@implementation Sounds
@synthesize buttonClick;

-(void)PlayButtonClick:(id)sender{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"appSounds"]) {    
        
        NSString  *path = [[NSBundle mainBundle] pathForResource:@"button_click" ofType:@"caf"];
        self.buttonClick = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        self.buttonClick.delegate = self;
        [self.buttonClick play];  
        
    }    
    
    
    
    
}


@end
