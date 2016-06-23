//
//  UIView+Frame.m
//  UIView+Frame
//
//  Created by rui on 15/1/18.
//  Copyright © 2015年 ruirui. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (BOOL)rr_intersectWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}

- (CGFloat)rr_height
{
    return self.frame.size.height;
}
- (void)setRr_height:(CGFloat)rr_height
{
    CGRect frame = self.frame;
    frame.size.height = rr_height;
    self.frame = frame;
}
- (CGFloat)rr_width
{
     return self.frame.size.width;
}

- (void)setRr_width:(CGFloat)rr_width
{
    CGRect frame = self.frame;
    frame.size.width = rr_width;
    self.frame = frame;
}

- (void)setRr_x:(CGFloat)rr_x
{
    CGRect frame = self.frame;
    frame.origin.x = rr_x;
    self.frame = frame;

}
- (CGFloat)rr_x
{
    return self.frame.origin.x;
}

- (void)setRr_y:(CGFloat)rr_y
{
    CGRect frame = self.frame;
    frame.origin.y = rr_y;
    self.frame = frame;
}
- (CGFloat)rr_y
{
    return self.frame.origin.y;
}

- (void)setRr_centerX:(CGFloat)rr_centerX
{
    CGPoint center = self.center;
    center.x = rr_centerX;
    self.center = center;
}
- (CGFloat)rr_centerX
{
    return self.center.x;
}
- (void)setRr_centerY:(CGFloat)rr_centerY
{
    CGPoint center = self.center;
    center.y = rr_centerY;
    self.center = center;
}
- (CGFloat)rr_centerY
{
    return self.center.y;
}
@end
