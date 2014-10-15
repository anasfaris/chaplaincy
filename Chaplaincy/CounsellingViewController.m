//
//  CounsellingViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "CounsellingViewController.h"
#import "SWRevealViewController.h"

@interface CounsellingViewController ()

@end

@implementation CounsellingViewController
@synthesize webView;

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
    
    NSURL *url = [NSURL URLWithString:@"https://calendly.com/mcuoft"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestURL];
    [webView addSubview:self.activityInd];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)loading {
    if (!webView.loading) {
        [self.activityInd stopAnimating];
    } else {
        [self.activityInd startAnimating];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
