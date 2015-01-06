//
//  SermonsViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "SermonsViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperation.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"

@interface SermonsViewController ()

@end

@implementation SermonsViewController
STKAudioPlayer* audioPlayer;
NSTimer* timer;

//NSCache* playings;

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
    
    // Bring button on top of table view
    [self.view bringSubviewToFront:self.hamburgerImg];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupTimer];
    [self tick];
    
    [self updateControls];
    
    //AFNetworking Method
    NSURL *url = [[NSURL alloc] initWithString:@"http://api.soundcloud.com/users/44839796/tracks.json?client_id=906e9745181f3cee9d62e886490b164b"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.programItem = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hamburgerPressed:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

#pragma mark Table View Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.programItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"SermonsItemCell";
    UITableViewCell *sermonsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    NSDictionary *tempItem = self.programItem[indexPath.row];
    
    // Set the program item and details
    UILabel *titleLabel = (UILabel*)[sermonsCell.contentView viewWithTag:1];
    
    titleLabel.text = tempItem[@"title"];
    return sermonsCell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.item = self.programItem[indexPath.row];
    NSString *getURL = self.item[@"stream_url"];
    self.streamURL = [NSString stringWithFormat:@"%@?client_id=%@", getURL, @"906e9745181f3cee9d62e886490b164b"];
    
    [audioPlayer stop];
    [self playSound];
    
    [self tick];
    
    self.trackLabel.text = self.item[@"title"];
    
    NSURL *url = [[NSURL alloc] initWithString:self.item[@"artwork_url"]];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    [self.albumCover setImage:img];
}

- (IBAction)sliderChanged:(id)sender {
    if (!audioPlayer) {
        return;
    }
    
//    NSLog(@"Slider Changed: %f", self.slider.value);
    
    [audioPlayer seekToTime:self.slider.value];
}

-(void) updateControls {
    if (audioPlayer == nil) {
        self.playButtonImg.hidden = false;
        self.pauseButtonImg.hidden = true;
        self.playButtonImg.enabled = false;
    } else if (audioPlayer.state == STKAudioPlayerStatePlaying) {
        self.playButtonImg.hidden = true;
        self.pauseButtonImg.hidden = false;
    } else if (audioPlayer.state == STKAudioPlayerStatePaused) {
        self.playButtonImg.hidden = false;
        self.playButtonImg.enabled = true;
        self.pauseButtonImg.hidden = true;
    } else {
        self.playButtonImg.hidden = true;
        self.pauseButtonImg.hidden = false;
    }
}

-(void) setupTimer {
    timer = [NSTimer timerWithTimeInterval:0.001 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(NSString*) formatTimeFromSeconds:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

-(void) tick
{
    if (!audioPlayer) {
        self.slider.value = 0;
        self.label.text = @"";
        
        return;
    }
    
    if (audioPlayer.currentlyPlayingQueueItemId == nil) {
        self.slider.value = 0;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 0;
        
        self.label.text = @"";
        
        return;
    }
    
    if (audioPlayer.duration != 0) {
        self.slider.minimumValue = 0;
        self.slider.maximumValue = audioPlayer.duration;
        self.slider.value = audioPlayer.progress;
        
        self.label.text = [NSString stringWithFormat:@"%@ - %@", [self formatTimeFromSeconds:audioPlayer.progress], [self formatTimeFromSeconds:audioPlayer.duration]];
    } else {
        self.slider.value = 0;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 0;
        
        self.label.text =  [NSString stringWithFormat:@"Streaming..."];
    }
}

- (IBAction)playButton:(id)sender {
    if (audioPlayer.state == STKAudioPlayerStatePaused) {
        [audioPlayer resume];
    } else {
        [self playSound];
    }
    [self updateControls];
//    self.playButtonImg.hidden = true;
//    self.pauseButtonImg.hidden = false;
}


- (IBAction)pauseButton:(id)sender {
//    self.pausing = true;
    [audioPlayer pause];
//    self.pauseButtonImg.hidden = true;
//    self.playButtonImg.hidden = false;
    [self updateControls];
}

-(void) playSound {
    
    
    audioPlayer = [[STKAudioPlayer alloc] init];
    [audioPlayer play: self.streamURL];
//    self.playButtonImg.hidden = true;
//    self.pauseButtonImg.hidden = false;
    
//    self.playing = true;
    //TOFIX: pause-stop-play
    [self updateControls];
}

- (IBAction)mcSoundcloudClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://soundcloud.com/mcuoft"]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end