//
//  CustomView.m
//  NeteaseNews
//
//  Created by rongfzh on 13-2-25.
//  Copyright (c) 2013年 rongfzh. All rights reserved.
//
/*
 
这个交互效果主要用到两个手势，一个是pan拖拽，一个是tap点击。拖拽可以把抽屉拉出来，再推回去。点击可以把抽屉推回去。
 
 
 2、实现思路和步骤
 思路：
 从实现的效果分析出来，可以这样实现：
 
 这个交互是由两个View组成，
 
 左侧导航的View在下面，显示内容列表的View在上面，
 
 内容列表的View覆盖住了导航View,拖动内容列表的View向右，这时候导航View就显示出来了。
 
 实现步骤：
 自定义一个View，它做为显示内容的View。给这个View添加两个手势，pan拖拽，tap点击。
 
 当拖拽这个View时，让view.center向右移动，这样就能看到内容View向右移动了。
 
 定义一个抽屉打开停止时的x值为：OPENCENTERX，这个是内容View最终停止的位置
 
 当内容View越过中间靠右的一个x值时，view自动向右动画移动到右边位置停下。
 
 当内容View在打开的状态下，点击内容View，利用UIView动画把内容View.center移动回到中间。
 
 设置内容View的阴影效果
 
 
 3、代码实现
 新建CustomView继承UIView
 
 两个手势在Custom里实现，并在初始化的时候传入内容View和父视图。
 
 
 4、viewController的调用
 为了实现自定义视图的阴影，添加需要使用QuartzCore框架。在项目里添加QuartzCore框架后引入头文件。

 */



//#import "ScreenMarco.h"

#import "CustomView.h"


@interface CustomView()
{
    CGPoint  _leftCenter;//显示左边时 custom的中心点
    CGPoint  _rightCenter;//显示右边时 custom的中心点
}

@end

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*设置阴影效果*/
-(void)customShadow{
    
    [[self layer] setShadowOffset:CGSizeMake(10, 10)];
    [[self layer] setShadowRadius:20];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    
}

- (id)initWithView:(UIView *)contentview parentView:(UIView *)parentview
{
    //视图控制器view的大小 正常情况下应该是于屏幕一样大
    //如果加在了 容器视图控制器上 可能会发生改变
    
    contentview.frame = CGRectMake(0,0,KscreenWidth , KscreenHeight);//设置了一下控制器视图的大小
    
    self = [super initWithFrame:contentview.bounds];
    
    if (self) {
        
        [self customShadow];
        
        self.contenView = contentview;
        self.parentView = parentview;
        
        [self addSubview:contentview];
        
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
       
        //不需要这个点击手势
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
//                                                        initWithTarget:self
//                                                        action:@selector(handleTap:)];
//        
//        [self addGestureRecognizer:tapGestureRecognizer];
       
        
        
        //显示左边时  当前视图中心的位置
        _leftCenter = CGPointMake(1.5*self.frame.size.width, self.parentView.center.y);
        //显示右边时  当前视图中心的位置
        _rightCenter = CGPointMake(self.frame.size.width/2 + 62, self.parentView.center.y);
        //默认显示左边
        self.center = _leftCenter;
        
    }
    
    
    
    return self;
}

-(void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.parentView];
    
    float x = self.center.x + translation.x;
//    NSLog(@"translation x:%f", translation.x);
    
    if (x < self.parentView.center.x) {
        x = self.parentView.center.x;
    }
    self.center = CGPointMake(x, _leftCenter.y);
    
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        CGPoint velocy = [recognizer velocityInView:self.parentView];//获取手势 速度
        
        //弹性动画
        //Damping 阻尼 越大 速度减的越快
        //Velocity 初始速度
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:0
                         animations:^(void)
         {
             if (velocy.x>0) {//手势滑动方向向右
                //显示左边
                 self.center = _leftCenter;
             }else{
                 //显示右边
                 self.center = _rightCenter;
                 
             }
             
         }completion:^(BOOL isFinish){
           //动画结束
             //调 代理方法 显示 左边  或者显示 右边
             //
             if (self.center.x > self.parentView.center.x) {
                 //显示左边
                 if ([self.delegate respondsToSelector:@selector(customViewDidShowleft)]) {
                    
                     [self.delegate customViewDidShowleft];
                 }
                 
             }else{
                 //显示右边
                 
                 if ([self.delegate respondsToSelector:@selector(customViewDidShowRight)]) {
                     
                     [self.delegate customViewDidShowRight];
                 }
                 
             }
             
             
         }];
    }
    
    [recognizer setTranslation:CGPointZero inView:self.parentView];
}

//点击手势
-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    [UIView animateWithDuration:0.25
                          delay:0.01
                        options:UIViewAnimationTransitionCurlUp animations:^(void){
                            
                            self.center = _leftCenter;
                            
                        }completion:nil];
    
}

/**
 *  展示右边视图的方法
 */

-(void)showRight{
    
    
    [UIView animateWithDuration:0.2 animations:^{
       self.center = _rightCenter;
    }];
    
    
}



@end
