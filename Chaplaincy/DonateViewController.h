//
//  DonateViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <iAd/iAd.h>

@interface DonateViewController : UIViewController<MFMailComposeViewControllerDelegate, ADBannerViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *feedbackButton;
@property (strong, nonatomic) IBOutlet UIButton *rateButton;
@property (strong, nonatomic) IBOutlet UIButton *donateButton;
@property (weak, nonatomic) IBOutlet UILabel *aboutHeader;
@property (weak, nonatomic) IBOutlet UILabel *devHeader;

@end
