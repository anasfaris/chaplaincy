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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //AFNetworking Method
    NSURL *url = [[NSURL alloc] initWithString:@"http://api.soundcloud.com/users/44839796/tracks.json?client_id=906e9745181f3cee9d62e886490b164b"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
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

#pragma mark Table View Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.programItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"SermonsItemCell";
    UITableViewCell *sermonsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    self.item = self.programItem[indexPath.row];
    
    // Set the program item and details
    UILabel *titleLabel = (UILabel*)[sermonsCell.contentView viewWithTag:1];
    
    titleLabel.text = self.item[@"title"];
    return sermonsCell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *getURL = self.item[@"stream_url"];
    NSString *streamURL = [NSString stringWithFormat:@"%@?client_id=%@", getURL, @"906e9745181f3cee9d62e886490b164b"];
    
//    if (playings) {
//        NSString *onPlay = [playings objectForKey:@"onPlay"];
//        if ([onPlay isEqualToString:streamURL]) {
//        } else {
//            [playings setObject:streamURL forKey:@"onPlay"];
//            [audioPlayer stop];
//            [self playSound:streamURL];
//        }
//    } else {
//        playings = [[NSCache alloc] init];
//        [playings setObject:streamURL forKey:@"onPlay"];
//        [self playSound:streamURL];
//    }
    
    [audioPlayer stop];
    [self playSound:streamURL];
    
    self.trackLabel.text = self.item[@"title"];
    
    NSURL *url = [[NSURL alloc] initWithString:self.item[@"artwork_url"]];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    [self.albumCover setImage:img];
}

-(void) playSound:(NSString*)streamURL {
    audioPlayer = [[STKAudioPlayer alloc] init];
    [audioPlayer play: streamURL];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end