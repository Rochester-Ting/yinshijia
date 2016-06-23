//
//  RRRBbtn.m
//  菜谱
//
//  Created by 丁瑞瑞 on 6/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRRBbtn.h"

@implementation RRRBbtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.rr_x = 0.25 * self.rr_width;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.rr_y = 0;
    self.imageView.rr_height = 0.75 * self.rr_height;
    self.imageView.rr_width = self.rr_width * 0.5;
    self.titleLabel.rr_y = self.imageView.rr_height - 1.7;
    self.titleLabel.rr_x = self.imageView.rr_x + 14;
    self.titleLabel.rr_height = self.rr_height - self.imageView.rr_height;
//    self.titleLabel.rr_width = self.imageView.rr_width;
//    self.titleLabel.center = self.center;
//    [self.titleLabel sizeToFit];
    self.titleLabel.contentMode = NSTextAlignmentRight;
    self.titleLabel.font = [UIFont systemFontOfSize:9];
    self.titleLabel.textColor = [UIColor colorWithRed:160 / 256.0 green:160 / 256.0 blue:160 / 256.0 alpha:1];
}

@end
