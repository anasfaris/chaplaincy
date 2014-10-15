//
//  DetailViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-04.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirtyLives.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contributionLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) ThirtyLives *detailLives;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;

@end
