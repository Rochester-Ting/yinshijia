//
//  RRType2RowCell2.m
//  菜谱
//
//  Created by 丁瑞瑞 on 24/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//
//type2  row2
#import "RRType2RowCell2.h"
#import <UIImageView+WebCache.h>
@interface RRType2RowCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduce;

@end
@implementation RRType2RowCell2

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = self.iconImageView.rr_width * 0.5;
    self.iconImageView.clipsToBounds = YES;
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    self.titleLabel.text = arr[2];
    self.introduce.text = arr[1];
}
@end
