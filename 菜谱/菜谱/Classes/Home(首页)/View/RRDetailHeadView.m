//
//  RRDetailHeadView.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDetailHeadView.h"
#import <UIImageView+WebCache.h>
@interface RRDetailHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *HimageView;

@end
@implementation RRDetailHeadView

-(void)awakeFromNib
{
//    self.rr_height = 150;
}
- (void)setStr:(NSString *)str
{
    _str = str;
    [self.HimageView sd_setImageWithURL:[NSURL URLWithString:str]];
}

@end
