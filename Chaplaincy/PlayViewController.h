//
//  PlayViewController.h
//  Chaplaincy
//
//  Created by Anas Ahmad Faris on 2014-12-18.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController

@property (strong, nonatomic) NSDictionary *track;
@property float contentMemory;
@property (strong, nonatomic) IBOutlet UIImageView *albumCover;
@property (strong, nonatomic) IBOutlet UILabel *trackTitle;

@end
