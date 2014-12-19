//
//  ThirtyLivesViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirtyLivesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *thirtyItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property float contentMemoryOffset;

@end
