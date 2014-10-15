//
//  HomeViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    self.homeItem = [[[HomeModel alloc] init] getHomeItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    HomeItem *item = self.homeItem[indexPath.row];
    
    UILabel *titleLabel = (UILabel *)[homeCell.contentView viewWithTag:2];
    
    UIFont *museoFiqFont = [UIFont fontWithName:@"GothamBold" size:15.0];
    
    // Set menu item text and icon
    titleLabel.text = item.title;
    titleLabel.font = museoFiqFont;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:item.title
     attributes:
     @{
       NSFontAttributeName : museoFiqFont,
       NSKernAttributeName : @(2.0f)
       }];
    
    titleLabel.attributedText = attributedString;
    
    // Set the program item and details
    //homeCell.textLabel.text = item.title;
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[homeCell.contentView viewWithTag:1];
    NSString *fileName = item.imageName;
    [imageView setImage:[UIImage imageNamed:fileName]];    
    
    return homeCell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
