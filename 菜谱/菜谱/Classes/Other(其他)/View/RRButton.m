//
//  RRButton.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRButton.h"

@implementation RRButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.rr_x = 0;
    self.imageView.rr_x = self.titleLabel.rr_width + 5;
}

@end
