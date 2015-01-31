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
#import "UIImageView+WebCache.h"

@interface ProgramsViewController ()

@end

@implementation ProgramsViewController

UIRefreshControl *refreshControl;

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
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //AFNetworking Method
    [self fetchData:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable {
    [self fetchData:YES];
}

-(void)fetchData:(BOOL)isRefreshing {
    //AFNetworking Method
    NSURL *url = [[NSURL alloc] initWithString:@"https://dl.dropboxusercontent.com/u/265794/MC/JSON/programming.json"];
    NSUInteger cPolicy;
    
    if (isRefreshing) {
        cPolicy = NSURLRequestUseProtocolCachePolicy;
    } else {
        cPolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:cPolicy
                                         timeoutInterval:30.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.programItem = responseObject;
        if (isRefreshing) [refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    
    [operation start];
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
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[programCell.contentView viewWithTag:6];
//    NSString *fileName = item[@"programImage"];
    [imageView sd_setImageWithURL:[NSURL URLWithString: item[@"programImgUrl"]]];
    
    return programCell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
