//
//  MenuViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
#import "MenuItem.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// @property (strong, nonatomic) MenuItem *model;
@property (strong, nonatomic) NSArray *menuItems;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
