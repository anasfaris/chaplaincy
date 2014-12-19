//
//  DonateViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "DonateViewController.h"
#import "SWRevealViewController.h"

@interface DonateViewController () {
    ADBannerView *_adView;
    BOOL _bannerIsVisible;
}

@end

@implementation DonateViewController

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
    
    // Set button styles
    [self.donateButton.layer setBorderWidth:1.0];
    
    UIColor *buttonBorderColor = [UIColor redColor];

    [self.donateButton.layer setBorderColor: buttonBorderColor.CGColor];
    
    [self hideAllButtons];
    [self animateButtons];
    
}

- (void)viewDidAppear:(BOOL)animated {
    // Call super implementation
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donateButtonClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mcuoft.com/donate/"]];
}

#pragma mark Mail Compose Delegate Methods

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Dismiss the compose controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)menuButtonTapped:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

-(void) hideAllButtons {
    
    CGRect donateButtonFrame = self.donateButton.frame;
    donateButtonFrame.origin.y = 2000;
    self.donateButton.frame = donateButtonFrame;

}

-(void) animateButtons {
    // Animate the buttons back to their positions

    [UIView animateWithDuration:0.8
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
                            CGRect donateButtonFrame = self.donateButton.frame;
                            donateButtonFrame.origin.y = 351;
                            self.donateButton.frame = donateButtonFrame;
                        }
                     completion:nil];

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
