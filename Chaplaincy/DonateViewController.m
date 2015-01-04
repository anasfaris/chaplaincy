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
float pos = 0;

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
//    [self.donateButton.layer setBorderWidth:0.9];
//    
//    UIColor *buttonBorderColor = [UIColor redColor];
//
//    [self.donateButton.layer setBorderColor: buttonBorderColor.CGColor];
    
    pos = self.donateButton.frame.origin.y;
    
//    [self hideAllButtons];
//    [self animateButtons];
    
}

- (void)viewDidAppear:(BOOL)animated {
    // Call super implementation
    [super viewDidAppear:animated];

}

- (IBAction)hamburgerPressed:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

- (IBAction)fbPressed:(id)sender {
    NSURL *fanPageURL = [NSURL URLWithString:@"fb://page?id=mcuoft"];
    if (![[UIApplication sharedApplication] canOpenURL:fanPageURL])
        fanPageURL =   [ NSURL URLWithString:@"https://www.facebook.com/mcuoft"];
    
    [[UIApplication sharedApplication] openURL:fanPageURL];
}

- (IBAction)twPressed:(id)sender {
    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=mcuoft"];
    NSURL *tweetbotURL = [NSURL URLWithString:@"tweetbot:///user_profile/mcuoft"];
    NSURL *defaultURL = [NSURL URLWithString:@"https://twitter.com/mcuoft"];
    
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else if ([[UIApplication sharedApplication] canOpenURL:tweetbotURL])
        [[UIApplication sharedApplication] openURL:tweetbotURL];
    else
        [[UIApplication sharedApplication] openURL:defaultURL];
}

- (IBAction)igPressed:(id)sender {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=mcuoft"];
    NSURL *defaultURL = [NSURL URLWithString:@"http://instagram.com/mcuoft"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        [[UIApplication sharedApplication] openURL:instagramURL];
    else
        [[UIApplication sharedApplication] openURL:defaultURL];
}

- (IBAction)webPressed:(id)sender {
    NSURL *webURL = [NSURL URLWithString:@"http://mcuoft.com"];
    [[UIApplication sharedApplication] openURL:webURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donateClicked:(id)sender {
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
                            donateButtonFrame.origin.y = pos;
                            self.donateButton.frame = donateButtonFrame;
                        }
                     completion:nil];

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
