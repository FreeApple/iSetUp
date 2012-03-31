//
//  SetUpCell.h
//  iSetUp
//
//  Created by Anthony Cornell on 3/27/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpCell : UITableViewCell{
    
IBOutlet UIImageView *BG;
IBOutlet UILabel *name;
  

}

@property (nonatomic, retain) IBOutlet UIImageView *BG;
@property (nonatomic, retain)  IBOutlet UILabel *name;


@end
