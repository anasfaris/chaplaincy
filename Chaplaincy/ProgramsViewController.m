//
//  ProgramsViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "ProgramsViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperation.h"

@interface ProgramsViewController ()

@end

@implementation ProgramsViewController

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
    
    //AFNetworking Method
    NSURL *url = [[NSURL alloc] initWithString:@"https://dl.dropboxusercontent.com/u/265794/programData.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:30.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
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
    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
}

#pragma mark Table View Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.programItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"ProgramItemCell";
    UITableViewCell *programCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    NSDictionary *item = self.programItem[indexPath.row];
    
    // Set the program item and details
    //programCell.textLabel.text = item.title;
    UILabel *titleLabel = (UILabel*)[programCell.contentView viewWithTag:1];
    UILabel *dateLabel = (UILabel*)[programCell.contentView viewWithTag:2];
    UILabel *timeLabel = (UILabel*)[programCell.contentView viewWithTag:3];
    UILabel *locationLabel = (UILabel*)[programCell.contentView viewWithTag:4];
    UILabel *descriptionLabel = (UILabel*)[programCell.contentView viewWithTag:5];
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[programCell.contentView viewWithTag:6];
    NSString *fileName = item[@"programImage"];
    [imageView setImage:[UIImage imageNamed:fileName]];
    
    titleLabel.text = item[@"programName"];
    dateLabel.text = item[@"programDate"];
    timeLabel.text = item[@"programDay"];
    locationLabel.text = item[@"programLocation"];
    descriptionLabel.text = item[@"programDescription"];
    [descriptionLabel sizeToFit];
    
    return programCell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
