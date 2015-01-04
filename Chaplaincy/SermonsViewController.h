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
@property (strong, nonatomic) NSString *streamURL;
@property BOOL pausing;
@property BOOL playing;

@property (strong, nonatomic) IBOutlet UIButton *playButtonImg;
@property (strong, nonatomic) IBOutlet UIButton *pauseButtonImg;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *hamburgerImg;


@end
