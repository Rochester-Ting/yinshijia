//
//  RRNavViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRNavViewController.h"

@interface RRNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RRNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    全局滑动返回
    id target = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.enabled = NO;
    //    添加一个手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}
#pragma mark - 手势识别代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [btn sizeToFit];
        
//        监听点击
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController popViewControllerAnimated:YES];
    }
    [super pushViewController:viewController animated:YES];
}
- (void)btnClick{
    [self popToRootViewControllerAnimated:YES];
}
@end
