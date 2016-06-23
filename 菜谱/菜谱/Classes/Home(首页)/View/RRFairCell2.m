//
//  RRFairCell2.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairCell2.h"
#import <UIImageView+WebCache.h>

@interface RRFairCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation RRFairCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 40;
    self.iconImageView.clipsToBounds = YES;
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.iconImageView sd_setImageWithURL:arr[0]];
    self.nameLabel.text = arr[1];
    self.contentLabel.text = arr[2];
}

@end
