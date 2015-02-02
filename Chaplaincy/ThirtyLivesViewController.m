//
//  ThirtyLivesViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "ThirtyLivesViewController.h"
#import "SWRevealViewController.h"
#import "DetailViewController.h"
#import "AFHTTPRequestOperation.h"

@interface ThirtyLivesViewController ()

@end

@implementation ThirtyLivesViewController

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
    NSURL *url = [[NSURL alloc] initWithString:@"https://dl.dropboxusercontent.com/u/10553577/MC/JSON/lives.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                        timeoutInterval:30.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.thirtyItem = responseObject;
        if (self.contentMemoryOffset) {
            [self.tableView setContentOffset:CGPointMake(0, self.contentMemoryOffset)];
        }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.thirtyItem count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"ThirtyMenuCell";
    UITableViewCell *thirtyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    UILabel *nameLabel = (UILabel *)[thirtyCell.contentView viewWithTag:2];
    UIFont *museoFiqFont = [UIFont fontWithName:@"GothamBook" size:15.0];
    NSDictionary *tempDict = [self.thirtyItem objectAtIndex:indexPath.row];

    // Set menu item text and icon
    nameLabel.text = [tempDict objectForKey:@"livesName"];
    nameLabel.font = museoFiqFont;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:[tempDict objectForKey:@"livesName"]
     attributes: @{ NSFontAttributeName : museoFiqFont,NSKernAttributeName : @(2.0f) }];
    nameLabel.attributedText = attributedString;
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[thirtyCell.contentView viewWithTag:1];
    NSString *fileName = [tempDict objectForKey:@"livesPicture"];
    [imageView setImage:[UIImage imageNamed:fileName]];
    
    return thirtyCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"GoToDetailSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.heroes = [self.thirtyItem objectAtIndex:indexPath.row];
    detailVC.contentMemory = self.tableView.contentOffset.y;
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
     [self.revealViewController revealToggleAnimated:YES];
    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end