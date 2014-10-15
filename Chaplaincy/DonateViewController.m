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
    [self.feedbackButton.layer setBorderWidth:1.0];
    [self.rateButton.layer setBorderWidth:1.0];
    [self.donateButton.layer setBorderWidth:1.0];
    
    UIColor *buttonBorderColor = [UIColor redColor];
    
    [self.feedbackButton.layer setBorderColor:buttonBorderColor.CGColor];
    [self.rateButton.layer setBorderColor:buttonBorderColor.CGColor];
    [self.donateButton.layer setBorderColor: buttonBorderColor.CGColor];
    
    [self hideAllButtons];
    [self animateButtons];
    
}

- (void)viewDidAppear:(BOOL)animated {
    // Call super implementation
    [super viewDidAppear:animated];
    
    // Create iAd banner and place at bottom
    _adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    // [self.view addSubview:_adView];
    _adView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)feedbackButtonClicked:(id)sender {
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"Chaplaincy App Feedback"];
    [mailComposer setToRecipients:@[@"sifooparadox@gmail.com"]];
    
    [self presentViewController:mailComposer animated:YES completion:nil];
     
}

- (IBAction)rateButtonClicked:(id)sender {
    
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
    CGRect feedbackButtonFrame = self.feedbackButton.frame;
    feedbackButtonFrame.origin.y = 2000;
    self.feedbackButton.frame = feedbackButtonFrame;
    
    CGRect rateButtonFrame = self.rateButton.frame;
    rateButtonFrame.origin.y = 2000;
    self.rateButton.frame = rateButtonFrame;
    
    CGRect donateButtonFrame = self.donateButton.frame;
    donateButtonFrame.origin.y = 2000;
    self.donateButton.frame = donateButtonFrame;
    
    self.aboutHeader.alpha = 0.0;
    self.devHeader.alpha = 0.0;
    
}

-(void) animateButtons {
    // Animate the buttons back to their positions
    
    [UIView animateWithDuration:0.8
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
                            CGRect feedbackButtonFrame = self.feedbackButton.frame;
                            feedbackButtonFrame.origin.y = 235;
                            self.feedbackButton.frame = feedbackButtonFrame;
    }
                     completion:nil];
    
    [UIView animateWithDuration:0.8
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
                            CGRect rateButtonFrame = self.rateButton.frame;
                            rateButtonFrame.origin.y = 293;
                            self.rateButton.frame = rateButtonFrame;
                        }
                     completion:nil];
    
    [UIView animateWithDuration:0.8
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
                            CGRect donateButtonFrame = self.donateButton.frame;
                            donateButtonFrame.origin.y = 351;
                            self.donateButton.frame = donateButtonFrame;
                        }
                     completion:nil];
    
    [UIView animateWithDuration:0.8
                          delay:0.8
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
                            self.aboutHeader.alpha = 1.0;
                            self.devHeader.alpha = 1.0;
                        }
                     completion:nil];
    
    
}

#pragma mark iAd Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    // Banner was successfully retrieve. Show ad if ad is not visible
    if(!_bannerIsVisible) {
        // Add the banner into the view
        if (_adView.superview == nil) {
            [self.view addSubview:_adView];
        }
    
        // Animate it into view
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        _adView.frame = CGRectOffset(_adView.frame, 0, -_adView.frame.size.height);
        
        [UIView commitAnimations];
        
        // Set flag
        _bannerIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    // Banner failed to be retrieved.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
