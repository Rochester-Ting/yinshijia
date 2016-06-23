//
//  RRWebViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRWebViewController.h"
#import <SVProgressHUD.h>
@interface RRWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webImage;

@end

@implementation RRWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@"人家已经很努力了嘛/(ㄒoㄒ)/~~!"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:_web];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webImage loadRequest:request];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
