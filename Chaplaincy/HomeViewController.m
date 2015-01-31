//
//  HomeViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailHomeViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    NSURL *url = [[NSURL alloc] initWithString:@"https://dl.dropboxusercontent.com/u/265794/MC/JSON/home.json"];
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
        self.homeItem = responseObject;
        if (isRefreshing) [refreshControl endRefreshing];
        else if (self.contentMemoryOffset) {
            [self.tableView setContentOffset:CGPointMake(0, self.contentMemoryOffset)];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    
    [operation start];
}

#pragma mark Table View Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"HomeItemCell";
    UITableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    NSDictionary *item = [self.homeItem objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = (UILabel *)[homeCell.contentView viewWithTag:2];
    
    UIFont *museoFiqFont = [UIFont fontWithName:@"GothamBold" size:15.0];
    
    // Set menu item text and icon
    titleLabel.text = item[@"programName"];
    titleLabel.font = museoFiqFont;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:item[@"programName"]
     attributes:
     @{
       NSFontAttributeName : museoFiqFont,
       NSKernAttributeName : @(2.0f)
       }];
    
    titleLabel.attributedText = attributedString;
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[homeCell.contentView viewWithTag:1];
    [imageView sd_setImageWithURL:[NSURL URLWithString: item[@"homeImgUrl"]]];
    
    return homeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"GoToDetailHomeSegue" sender:self];
    
}

- (IBAction)hamburgerPressed:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailHomeViewController *detailHomeVC = segue.destinationViewController;
    detailHomeVC.program = [self.homeItem objectAtIndex:indexPath.row];
    detailHomeVC.contentMemory = self.tableView.contentOffset.y;
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
