//
//  RRChefCell2.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefCell2.h"
#import <UIImageView+WebCache.h>

@interface RRChefCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation RRChefCell2
- (void)awakeFromNib
{
    self.iconImageV.layer.cornerRadius = 30;
    self.iconImageV.clipsToBounds = YES;
}
- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    self.introduce.text = arr[1];
    self.name.text = arr[2];
}

@end
