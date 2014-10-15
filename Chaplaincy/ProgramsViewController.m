//
//  ProgramsViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "ProgramsViewController.h"
#import "SWRevealViewController.h"

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.programItem = [[[ProgramModel alloc] init] getProgramItems];
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
    NSString *cellIdentifier = @"ProgramItemCell";
    UITableViewCell *programCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get program item that it's asking for
    Program *item = self.programItem[indexPath.row];
    
    // Set the program item and details
    //programCell.textLabel.text = item.title;
    UILabel *titleLabel = (UILabel*)[programCell.contentView viewWithTag:1];
    UILabel *dateLabel = (UILabel*)[programCell.contentView viewWithTag:2];
    UILabel *timeLabel = (UILabel*)[programCell.contentView viewWithTag:3];
    UILabel *locationLabel = (UILabel*)[programCell.contentView viewWithTag:4];
    UILabel *descriptionLabel = (UILabel*)[programCell.contentView viewWithTag:5];
    
    // Set the image
    UIImageView *imageView = (UIImageView*)[programCell.contentView viewWithTag:6];
    NSString *fileName = item.img;
    [imageView setImage:[UIImage imageNamed:fileName]];
    
    titleLabel.text = item.title;
    dateLabel.text = item.startingDate;
    timeLabel.text = item.dayAndTime;
    locationLabel.text = item.location;
    descriptionLabel.text = item.description;
    [descriptionLabel sizeToFit];

    
    
    return programCell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
