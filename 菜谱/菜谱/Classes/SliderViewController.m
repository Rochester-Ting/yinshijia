//
//  SliderViewController.m
//  CeHuaDemo
//
//  Created by 任前辈 on 16/1/6.
//  Copyright © 2016年 SingleProgrammers. All rights reserved.
//

#import "SliderViewController.h"
#import "CustomView.h"
@interface SliderViewController ()<CustomViewDelegate>

@property(nonatomic,strong)CustomView * customView;

@end

@implementation SliderViewController


-(void)setViewControllers:(NSArray *)viewControllers{
    
    /*做容错*/
    if (_viewControllers) {//原来有值 需要 清除原来的左右视图控制器
       
        UIViewController * originleftVC = _viewControllers[0];
        UIViewController * originrigthVC = _viewControllers[1];
        
        [originleftVC.view removeFromSuperview];
        [originrigthVC.view removeFromSuperview];
        
        [self.customView removeFromSuperview];
        
        [originrigthVC removeFromParentViewController];//对应的是 下面添加的子视图控制器 方法
        [originleftVC removeFromParentViewController];
        
    }
       
    
    
    _viewControllers = viewControllers;

    UIViewController * leftVC = _viewControllers[0];
    UIViewController * rigthVC = _viewControllers[1];
    
    [self.view addSubview:leftVC.view];//将左边视图 加到 容器视图控制器上
    
    //布局 怎么显示数组中的子视图控制器
    
    CustomView * custom =  [[CustomView alloc] initWithView:rigthVC.view parentView:leftVC.view];
    
    custom.delegate = self;
    
    self.customView = custom;
    
    [self.view addSubview:custom];
    
    //添加子视图控制器  这个方法没有什么实际效果 他只是规定  应该写 不写 可能会出现使用 官方其它容器视图控制器 跳转问题
    [self addChildViewController:leftVC];
    [self addChildViewController:rigthVC];

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customViewDidShowRight{
    
    //展示了右边
    if ([self.delegate respondsToSelector:@selector(sliderView:didShowRightVC:)]) {
        
        [self.delegate sliderView:self didShowRightVC:self.viewControllers[1]];
        
    }
    
}

-(void)customViewDidShowleft{
    
    //展示了 左边
    if ([self.delegate respondsToSelector:@selector(sliderView:didShowLeftVC:)]) {
        
        [self.delegate sliderView:self didShowLeftVC:self.viewControllers[0]];
        
    }
    
}

-(void)showRightVC{
    
    [self.customView showRight];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
