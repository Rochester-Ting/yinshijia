//
//  CustomView.h
//  NeteaseNews
//
//  Created by rongfzh on 13-2-25.
//  Copyright (c) 2013年 rongfzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomViewDelegate <NSObject>

/*
 显示左边
 */
-(void)customViewDidShowleft;
/**
 *  显示右边
 */
-(void)customViewDidShowRight;


@end



@interface CustomView : UIView
{
   
}

-(id)initWithView:(UIView*)contentview parentView:(UIView*) parentview;

@property (nonatomic, strong) UIView *parentView; //抽屉视图的父视图
@property (nonatomic, strong) UIView *contenView; //抽屉显示内容的视图

@property (nonatomic,weak)id<CustomViewDelegate>delegate;

/**
 *  展示右边视图的方法
 */

-(void)showRight;


@end
