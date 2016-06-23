//
//  RRTransition.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTransition.h"
#import "RRPresentationController.h"
#import "RRAnimatedTransition.h" // 协议对象 // 设置过渡代理
@implementation RRTransition
SingleM(RRTransition)
#pragma mark - UIViewControllerTransitioningDelegate
// 控制modal出来的控制器
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    RRPresentationController *rrPreVC =  [[RRPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    rrPreVC.rr_frame = _rr_frame;
    return rrPreVC;
}

/**
 *  控制显示动画
 *
 *  @param presented  secondVC
 *  @param presenting 当前VC
 *  @param source
 *
 *  @return 遵守UIViewControllerAnimatedTransitioning协议的动画对象
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    RRAnimatedTransition *RRAT = [[RRAnimatedTransition alloc] init];
    RRAT.presented = YES;
    RRAT.isTabBar = _isTabBar;
    RRAT.isBuy = _isBuy;
    return RRAT;
}

/**
 *  控制dismiss
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    RRAnimatedTransition *RRAT = [[RRAnimatedTransition alloc] init];
    RRAT.presented = NO;
    return RRAT;
}

@end
