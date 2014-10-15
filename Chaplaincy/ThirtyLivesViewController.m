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

@interface ThirtyLivesViewController () {
    ThirtyLives *_selectedLives;
}

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.thirtyItem = [[[ThirtyLivesModel alloc] init] getThirtyItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.thirtyItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"ThirtyMenuCell";
    UITableViewCell *thirtyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    ThirtyLives *item = self.thirtyItem[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[thirtyCell.contentView viewWithTag:2];
    
    UIFont *museoFiqFont = [UIFont fontWithName:@"GothamBook" size:15.0];
    
    // Set menu item text and icon
    nameLabel.text = item.name;
    nameLabel.font = museoFiqFont;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:item.name
     attributes:
     @{
       NSFontAttributeName : museoFiqFont,
       NSKernAttributeName : @(2.0f)
       }];
    
    nameLabel.attributedText = attributedString;
    
  //  UILabel *nameLabel = (UILabel *) [thirtyCell.contentView viewWithTag:2];
   // nameLabel.text = item.name;
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[thirtyCell.contentView viewWithTag:1];
    NSString *fileName = item.imageName;
    [imageView setImage:[UIImage imageNamed:fileName]];
    
    return thirtyCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedLives = self.thirtyItem[indexPath.row];
    
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"GoToDetailSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.detailLives = _selectedLives;
    
    
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];
    
    
    // Slide the front view controller back into place
     [self.revealViewController revealToggleAnimated:YES];
    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
