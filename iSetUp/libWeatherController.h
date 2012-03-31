//
//  libWeatherController.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface libWeatherController : UIViewController{
    
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *templabel;
    IBOutlet UILabel *desclabel;
    IBOutlet UILabel *nightlabel;
    IBOutlet UILabel *othertemplabel;
    IBOutlet UILabel *timelabel;
    IBOutlet UILabel *codes;
    IBOutlet UIImageView *weathericon;    
}
-(IBAction)refreshWeather;

@end
