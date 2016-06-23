//
//  SliderViewController.h
//  CeHuaDemo
//
//  Created by 任前辈 on 16/1/6.
//  Copyright © 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderViewController;

@protocol SliderViewDelegate <NSObject>

/**
 *  已经显示左边
 *
 *  @param slider 滑动视图控制器
 *  @param vc     显示的左视图控制器
 */
-(void)sliderView:(SliderViewController *)slider  didShowLeftVC:(UIViewController *)vc;


-(void)sliderView:(SliderViewController *)slider  didShowRightVC:(UIViewController *)vc;



@end

/**
 *  封装容器视图控制器 
 
 */
@interface SliderViewController : UIViewController
/**
 *  数组中第一个vc是左边 第二个是右边
 */
@property(nonatomic,strong)NSArray * viewControllers;

@property(nonatomic,weak)id<SliderViewDelegate>delegate;


/**
 *  展示右边视图
 */

-(void)showRightVC;



@end



