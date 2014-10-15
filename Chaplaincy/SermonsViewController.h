//
//  SermonsViewController.h
//  Chaplaincy
//
//  Created by Anas Faris on 2014-06-02.
//  Copyright (c) 2014 mcuoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SermonsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSTimer *timer;

@end
