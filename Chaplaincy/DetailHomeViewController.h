//
//  DetailHomeViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-09.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *programImg;
@property (strong, nonatomic) NSDictionary *program;
@property float contentMemory;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@end
