//
//  DetailsCellObject.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCellObject : UITableViewCell{
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *artist;
    IBOutlet UIImageView *thumb;
      IBOutlet UITextView *desc;
}
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *artist;
@property (nonatomic, retain) UIImageView *thumb;
@property (nonatomic, retain)UITextView *desc;

@end
