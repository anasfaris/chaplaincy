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

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation SermonsViewController
@synthesize player;

STKAudioPlayer* audioPlayer;


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
    
    audioPlayer = [[STKAudioPlayer alloc] init];
    
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
    NSDictionary *item = self.programItem[indexPath.row];
    
    // Set the program item and details
    //programCell.textLabel.text = item.title;
    UILabel *titleLabel = (UILabel*)[sermonsCell.contentView viewWithTag:1];
//    UILabel *dateLabel = (UILabel*)[programCell.contentView viewWithTag:2];
//    UILabel *timeLabel = (UILabel*)[programCell.contentView viewWithTag:3];
//    UILabel *locationLabel = (UILabel*)[programCell.contentView viewWithTag:4];
//    UILabel *descriptionLabel = (UILabel*)[programCell.contentView viewWithTag:5];
    
    // Set the image
//    UIImageView *imageView = (UIImageView*)[programCell.contentView viewWithTag:6];
//    NSString *fileName = item[@"programImage"];
//    [imageView setImage:[UIImage imageNamed:fileName]];
    
    titleLabel.text = item[@"title"];
//    self.streamer = item[@"stream_url"];
//    dateLabel.text = item[@"programDate"];
//    timeLabel.text = item[@"programDay"];
//    locationLabel.text = item[@"programLocation"];
//    descriptionLabel.text = item[@"programDescription"];
//    [descriptionLabel sizeToFit];
    [player prepareToPlay];
    return sermonsCell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *track = [self.programItem objectAtIndex:indexPath.row];
    NSString *getURL = [track objectForKey:@"stream_url"];
    NSString *streamURL = [NSString stringWithFormat:@"%@?client_id=%@", getURL, @"906e9745181f3cee9d62e886490b164b"];
//    NSURL *trackURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", streamURL]];
    
    [audioPlayer play: streamURL];
    
//    [player stop];
//    
//    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:trackURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        // self.player is strong property
//        player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//        [player prepareToPlay];
//        [player play];
//    }];
//    
//    [task resume];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end