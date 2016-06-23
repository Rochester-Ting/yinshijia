//
//  RRChefCell5.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefCell5.h"
#import <UIImageView+WebCache.h>
@interface RRChefCell5 ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *introduce;

@end

@implementation RRChefCell5

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    self.title.text = arr[0];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:arr[2]]];
    self.introduce.text = arr[1];
}
@end
