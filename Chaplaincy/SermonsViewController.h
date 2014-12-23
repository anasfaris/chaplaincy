//
//  SermonsViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SermonsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *programItem;
@property (strong, nonatomic) NSDictionary *item;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *trackLabel;
@property (strong, nonatomic) IBOutlet UIImageView *albumCover;

@end
