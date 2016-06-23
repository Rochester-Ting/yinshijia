//
//  RRAnimatedTransition.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRAnimatedTransition.h"
#import "UIView+Frame.h"
#define time 0.8

@interface RRAnimatedTransition ()
/** tabBar*/
@property (nonatomic,assign) BOOL tabBar;

@property (nonatomic,assign) BOOL agg;
@end

@implementation RRAnimatedTransition
#pragma mark - UIViewControllerAnimatedTransitioning
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
// 返回转场动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return time;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
// 弹出和消失动画都会执行方法
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    // UITransitionContextFromViewKey : 做消失动画:取出消失的View
    // UITransitionContextToViewKey : 做弹出动画:取出弹出的View
    if(self.presented){ // presented
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        if (_isTabBar) {
            toView.rr_y = screenH;
        }else{
            toView.rr_x = screenW;
        }

        
        [UIView animateWithDuration:time animations:^{
            
            // 执行动画
            if (_isTabBar) {
                
                toView.rr_y = screenH - toView.rr_height;
                self.tabBar = 1;
                self.agg = 0;
            }else{
                toView.rr_x = screenW - toView.rr_width;
            }

        } completion:^(BOOL finished) {
            
            // 必须设置, 完成动画
            [transitionContext completeTransition:YES];
        }];
    }else{ // dismiss
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:time animations:^{
            fromView.rr_x = screenW;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}


@end
