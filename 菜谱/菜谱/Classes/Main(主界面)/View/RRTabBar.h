//
//  RRTabBar.h
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderViewController.h"
@class RRRBbtn;
@interface RRTabBar : UITabBar
/** 传值*/
@property (nonatomic,strong) void (^block)(RRRBbtn *str);
//@property(nonatomic,strong)SliderViewController *slider;

/** button*/
@property (nonatomic,strong) UIButton *publishBtn;
@end
