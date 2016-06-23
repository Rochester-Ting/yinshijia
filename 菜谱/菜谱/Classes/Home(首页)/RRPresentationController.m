//
//  RRPresentationController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPresentationController.h"

@implementation RRPresentationController

// 开始 转场
- (void)presentationTransitionWillBegin
{
    // 设置
    //    self.presentedView.frame = self.containerView.bounds;
    
    // 手动将要展示的View, 添加到容器中
    [self.containerView addSubview:self.presentedView];
    
    //    LogRed(@"presentationTransition ---  WillBegin");
}
// 转场动画结束
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    //    LogRed(@"presentationTransition ---  DidEnd");
}
//dismiss即将开始的时候
- (void)dismissalTransitionWillBegin
{
    //    LogRed(@"dismissalTransition --- WillBegin --- ");
}
//dismiss已经结束
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    
    [self.presentedView removeFromSuperview];
    //    LogGreen(@"dismissalTransition --- DidEnd --- ");
}

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
//    设置frame
    self.presentedView.frame = _rr_frame;
//    self.presentedView.frame = CGRectMake(0,screenH - 300, screenW, 300);
//    添加遮盖
    [self setupCoverView];
}
- (void)setupCoverView{
    UIView *coverView = [[UIView alloc] initWithFrame:self.containerView.bounds];
//    将遮盖插入到当前弹出的控制器下
    [self.containerView insertSubview:coverView belowSubview:self.presentedView];
    coverView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
//    给遮盖添加一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];

    [self.containerView addGestureRecognizer:tap];
    
}
- (void)tap{
//    执行dismiss
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
