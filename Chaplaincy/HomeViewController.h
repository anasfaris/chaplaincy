//
//  HomeViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItem.h"
#import "HomeModel.h"

@interface HomeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *homeItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
