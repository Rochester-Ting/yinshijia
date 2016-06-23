//
//  RRPopoverViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPopoverViewController.h"

@interface RRPopoverViewController ()

@end

@implementation RRPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)btnClick:(id)sender {

    if (_btnBlock) {
        _btnBlock(@"关闭");
    }
}



@end
