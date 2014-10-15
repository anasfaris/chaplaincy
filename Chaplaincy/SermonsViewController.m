//
//  SermonsViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "SermonsViewController.h"
#import "SWRevealViewController.h"

@interface SermonsViewController ()

@end

@implementation SermonsViewController
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
    
    NSURL *url = [NSURL URLWithString:@"http://m.soundcloud.com/muslim-chaplaincy-at-uoft"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestURL];
    [webView addSubview:self.indicator];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)loading {
    if (!webView.loading) {
        [self.indicator stopAnimating];
    } else {
        [self.indicator startAnimating];
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
