//
//  PlayViewController.m
//  Chaplaincy
//
//  Created by Anas Ahmad Faris on 2014-12-18.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "PlayViewController.h"
#import "SWRevealViewController.h"
#import "SermonsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"

@interface PlayViewController ()

@end

@implementation PlayViewController
STKAudioPlayer* audioPlayer;
NSCache* playings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSString *getURL = self.track[@"stream_url"];
    NSString *streamURL = [NSString stringWithFormat:@"%@?client_id=%@", getURL, @"906e9745181f3cee9d62e886490b164b"];

    if (playings) {
        NSString *onPlay = [playings objectForKey:@"onPlay"];
        if ([onPlay isEqualToString:streamURL]) {
        } else {
            [playings setObject:streamURL forKey:@"onPlay"];
            [audioPlayer stop];
            [self playSound:streamURL];
        }
    } else {
        playings = [[NSCache alloc] init];
        [playings setObject:streamURL forKey:@"onPlay"];
        [self playSound:streamURL];
    }
    
    self.trackTitle.text = self.track[@"title"];
    
    NSURL *url = [[NSURL alloc] initWithString:self.track[@"artwork_url"]];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    [self.albumCover setImage:img];
    
}

-(void) playSound:(NSString*)streamURL {
    audioPlayer = [[STKAudioPlayer alloc] init];
    [audioPlayer play: streamURL];
}

- (IBAction)backPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoBackToRSegue" sender:self];
}
- (IBAction)hiddenPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoBackToRSegue" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SermonsViewController *sermonsVC = segue.destinationViewController;
    sermonsVC.contentMemoryOffset = self.contentMemory;
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
    
    
}

@end
