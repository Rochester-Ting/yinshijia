//
//  UIView+Frame.h
//  UIView+Frame
//
//  Created by rui on 15/1/18.
//  Copyright © 2015年 ruirui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat rr_x;
@property CGFloat rr_y;
@property CGFloat rr_width;
@property CGFloat rr_height;
@property CGFloat rr_centerX;
@property CGFloat rr_centerY;

/**
 *  判断self和view是否重叠
 */
- (BOOL)rr_intersectWithView:(UIView *)view;

@end
