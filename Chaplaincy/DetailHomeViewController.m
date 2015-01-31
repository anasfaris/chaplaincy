//
//  DetailHomeViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-09.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "DetailHomeViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "ThirtyLivesViewController.h"
#import "UIImageView+WebCache.h"

@interface DetailHomeViewController ()

@end

@implementation DetailHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
//    [self.programImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Home",self.program[@"programImage"]]]];
//    [self.programImg sd_setImageWithURL:[NSURL URLWithString: self.program[@"detailImgUrl"]]];

    [self.programImg sd_setImageWithURL:[NSURL URLWithString: self.program[@"detailImgUrl"]]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.programImg.image = [self adjustImageSizeWhenCropping:self.programImg.image];
                                  self.scrollView.contentSize = self.programImg.image.size;
                                  self.programImg.frame = CGRectMake(0,0,self.programImg.image.size.width, self.programImg.image.size.height);
    }];

    
    
    // Bring button on top of table view
    [self.view bringSubviewToFront:self.backButton];
}

-(UIImage *)adjustImageSizeWhenCropping:(UIImage *)image{
    
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    
    float ratio=self.view.bounds.size.width/actualWidth;
    actualHeight = actualHeight * ratio;
    
    CGRect rect = CGRectMake(0.0, 0.0, self.view.bounds.size.width, actualHeight);
    // UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
    
}

- (IBAction)backPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoBackToHomeSegue" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeViewController *homeVC = segue.destinationViewController;
    homeVC.contentMemoryOffset = self.contentMemory;
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
    
}

@end
