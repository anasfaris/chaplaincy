//
//  MenuViewController.m
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    
    // 1. Set self as the data source and delegate for the table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 2. Fetch the menu items
    self.menuItems = [[[MenuModel alloc] init] getMenuItems];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve cell
    NSString *cellIdentifier = @"MenuItemCell";
    UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get menu item that it's asking for
    MenuItem *item = self.menuItems[indexPath.row];
    
    // Get image view
    UIImageView *iconImageView = (UIImageView *) [menuCell viewWithTag:2];
    UILabel *menuItemTitle = (UILabel *)[menuCell viewWithTag:1];
    
    UIFont *museoFiqFont = [UIFont fontWithName:@"GothamBook" size:15.0];
    
    // Set menu item text and icon
    menuItemTitle.text = item.menuTitle;
    menuItemTitle.font = museoFiqFont;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:item.menuTitle
     attributes:
     @{
       NSFontAttributeName : museoFiqFont,
       NSKernAttributeName : @(2.0f)
       }];
    
    menuItemTitle.attributedText = attributedString;
    
    iconImageView.image = [UIImage imageNamed:item.menuIcon];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor whiteColor];
    menuCell.selectedBackgroundView = selectionColor;
    
    return menuCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Check which item was tapped
    MenuItem *item = self.menuItems[indexPath.row];
    
    switch (item.screenType) {
        case ScreenTypeHome:
            [self performSegueWithIdentifier:@"GoToHomeSegue" sender:self];
            break;
        case ScreenTypeCounselling:
            [self performSegueWithIdentifier:@"GoToCounsellingSegue" sender:self];
            break;
        case ScreenTypeDonate:
            [self performSegueWithIdentifier:@"GoToDonateSegue" sender:self];
            break;
        case ScreenTypePrograms:
            [self performSegueWithIdentifier:@"GoToProgramsSegue" sender:self];
            break;
        case ScreenTypeSermons:
            [self performSegueWithIdentifier:@"GoToSermonsSegue" sender:self];
            break;
        case ScreenType30Lives:
            [self performSegueWithIdentifier:@"GoToThirtyLivesSegue" sender:self];
            break;
            
        default:
            break;
    }
}

#pragma mark Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Set the front view controller to be the destination one
    [self.revealViewController setFrontViewController:segue.destinationViewController];

    // Slide the front view controller back into place
    [self.revealViewController revealToggleAnimated:YES];
}
@end
