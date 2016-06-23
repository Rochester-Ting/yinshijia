//
//  UIView+RRLoad.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "UIView+RRLoad.h"

@implementation UIView (RRLoad)
+(instancetype)loadWithXib
{
    return [[NSBundle mainBundle] loadNibNamed:(NSStringFromClass(self)) owner:nil options:nil].firstObject;
}
@end
