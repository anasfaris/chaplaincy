//
//  DetailViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-04.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "DetailViewController.h"
#import "SWRevealViewController.h"
#import "ThirtyLivesViewController.h"

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

    
    self.nameLabel.text = self.heroes[@"livesName"];
    self.contributionLabel.text = self.heroes[@"livesMajor"];
    self.captionLabel.text = self.heroes[@"livesCaption"];
    self.descriptionLabel.text = self.heroes[@"livesStory"];
//    NSString *hello = self.heroes[@"livesStory"];
//    NSString *newString = [hello stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//    NSLog(@"%@", newString);
    [self.imgView setImage:[UIImage imageNamed:self.heroes[@"livesPicture"]]];
    
    [self.descriptionLabel sizeToFit];
    
    // Set content size of scrollview
    self.detailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.nameLabel.frame.size.height + self.captionLabel.frame.size.height + self.descriptionLabel.frame.size.height + self.contributionLabel.frame.size.height + 10);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (IBAction)testPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoBackToThirtySegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ThirtyLivesViewController *thirtyVC = segue.destinationViewController;
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
