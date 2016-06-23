//
//  RRBtn.m
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRBtn.h"

@implementation RRBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.rr_x = self.rr_width * 0.2;
    self.imageView.rr_y = RRMargin;
    self.imageView.rr_height = self.rr_height * 0.6;
    self.imageView.rr_width = self.imageView.rr_height;
    self.titleLabel.rr_x = self.rr_width * 0.2;
    self.titleLabel.rr_y = self.imageView.rr_height;
    self.titleLabel.rr_width = self.rr_width;
    self.titleLabel.rr_height = self.rr_height - self.imageView.rr_height;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel.contentMode = UIViewContentModeCenter;
    self.titleLabel.textColor = [UIColor grayColor];
    
    self.imageView.layer.cornerRadius = self.imageView.rr_width * 0.5;
    self.imageView.clipsToBounds = YES;
}
@end
