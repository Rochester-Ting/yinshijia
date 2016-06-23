//
//  RRTabBar.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTabBar.h"
#import "RRLoginOrRegisterViewController.h"
#import "RRRBbtn.h"
#import "RRMeViewController.h"
@interface RRTabBar()


/** <#注释#>*/
@property (nonatomic,strong) UIView *view;
/** 最后一个按钮*/
@property (nonatomic,strong) RRRBbtn *lastBtn;
@end
@implementation RRTabBar
//
//- (SliderViewController *)slider
//{
//    if (!_slider) {
//        self.slider = [[SliderViewController alloc]init];
//    }
//    return _slider;
//}
- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_publishBtn setImage:[UIImage imageNamed:@"custom_tabbar"] forState:UIControlStateHighlighted];
//        [_publishBtn setImage:[UIImage imageNamed:@"custom_tabbar"] forState:UIControlStateNormal];
//        [_publishBtn setTitle:@"一键定制" forState:UIControlStateNormal];
        [_publishBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_publishBtn setTitle:@"已登录" forState:UIControlStateDisabled];
        [_publishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_publishBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:_publishBtn];
        [_publishBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

- (RRRBbtn *)lastBtn
{
    if (!_lastBtn) {
        _lastBtn = [RRRBbtn buttonWithType:UIButtonTypeCustom];
        [_lastBtn setImage:[UIImage imageNamed:@"dock_self_unselected"] forState:UIControlStateNormal];
        [self addSubview:_lastBtn];
        [_lastBtn addTarget:self action:@selector(lastBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_lastBtn setTitle:@"我" forState:UIControlStateNormal];
    }
    return _lastBtn;
}
- (void)addBtn:(UIButton *)btn{
    RRLoginOrRegisterViewController *loginVC = [RRLoginOrRegisterViewController shareRRLoginOrRegisterViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVC animated:YES completion:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tintColor = [UIColor orangeColor];
    //    获取一个tabBar的宽度
    CGFloat width = self.frame.size.width * 0.2;
    CGFloat height = self.frame.size.height;
    CGFloat index = 0;
    for (UIView * item in self.subviews) {
        if (item.class != NSClassFromString(@"UITabBarButton")) {
            continue;
        }
        item.frame = CGRectMake(index * width, 0, width, height);
        if (index >= 2) {
            item.frame = CGRectMake((index + 1) * width, 0, width, height);
        }
        index++;
    }
    self.publishBtn.frame = CGRectMake(2 * width, 0, width, height);
    self.lastBtn.frame = CGRectMake(4 * width, 0, width, height);
//    判断状态
}
//点击我
- (void)lastBtnClick:(RRRBbtn *)btn{
//    NSLog(@"122");
    if (_block) {
        _block(btn);
    }
    
}
@end
