//
//  Sounds.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//This is a class I wrote and re-use in all my apps and you are welcome to do so as well just please mention my name inside your credits! Thank you and enjoy the free code!

#import <Foundation/Foundation.h>
#import "AVFoundation/AVAudioPlayer.h"

@interface Sounds : NSObject<AVAudioPlayerDelegate> {
    
    //Any Sound can be added I give one in this app to show how
    
    AVAudioPlayer *buttonClick;
   
    
}

@property (nonatomic, retain) AVAudioPlayer *buttonClick;

-(void)PlayButtonClick:(id)sender;

@end
