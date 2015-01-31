//
//  HomeViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface HomeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    Reachability *internetReachableFoo;
}

@property (strong, nonatomic) NSArray *homeItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property float contentMemoryOffset;

@property (strong, nonatomic) IBOutlet UIButton *hamburgerImg;

@end
