//
//  DetailViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-04.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "DetailViewController.h"
#import "SWRevealViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    self.nameLabel.text = [self.heroes objectForKey:@"livesName"];
    self.contributionLabel.text = [self.heroes objectForKey:@"livesMajor"];
    self.captionLabel.text = [self.heroes objectForKey:@"livesCaption"];
    self.descriptionLabel.text = [self.heroes objectForKey:@"livesStory"];
    [self.descriptionLabel sizeToFit];
    
    // Set content size of scrollview
    self.detailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.nameLabel.frame.size.height + self.captionLabel.frame.size.height + self.descriptionLabel.frame.size.height + self.contributionLabel.frame.size.height + 70);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
