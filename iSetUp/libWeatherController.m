//
//  libWeatherController.m
//  iSetUp
//
//  Created by Anthony Cornell on 3/29/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "libWeatherController.h"

@implementation libWeatherController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self refreshWeather];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    rightButton.title = @"Edit";    
     self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = @"Weather";

}


-(IBAction)refreshWeather{
    
    NSString *plistPath = @"var/mobile/Library/Caches/";
    NSString *finalPath = [plistPath stringByAppendingPathComponent:@"com.ashman.LibWeather.cache.plist"];
    NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
    
    NSString *city = [plistData objectForKey:@"city"];
    NSNumber *temp = [plistData objectForKey:@"chill"];
    NSString *tempSring = [temp stringValue];
    NSNumber *code = [plistData objectForKey:@"code"];
    NSString *desc = [plistData objectForKey:@"description"];
    NSString *night = [plistData objectForKey:@"night"];
    NSString *otherTemp = [plistData objectForKey:@"temp"];
    NSNumber *time = [plistData objectForKey:@"timestamp"];
    NSString *timeString = [time stringValue];
    NSArray *forecast = [plistData objectForKey:@"forecast"];
    
    
    
    cityLabel.text = city;
    templabel.text = tempSring;
    desclabel.text =desc;
    nightlabel.text =night;
    othertemplabel.text =otherTemp;
    codes.text =[code stringValue];
    
    NSLog(@"WeatherCode is %@",code);
    
    if ([codes.text isEqual:@"28"]) {
        UIImage *icon = [UIImage imageNamed:@"28d.png"];
        weathericon.image = icon;
        NSLog(@"weather icon is mostly cloudy");
    }
    else{
        NSLog(@"error");
    }
    
    NSLog(@"forecast is %@",forecast);
    
    
    NSString *dateWithInitialFormat = timeString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *date = [dateFormatter dateFromString:dateWithInitialFormat];
    
    NSString *dateWithNewFormat = [dateFormatter stringFromDate:date];
    NSLog(@"dateWithNewFormat: %@", dateWithNewFormat);
	
    timelabel.text =dateWithNewFormat;
    
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
