//
//  RRChefCell3.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefCell3.h"
#import <UIImageView+WebCache.h>

@interface RRChefCell3 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
@implementation RRChefCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[0]]]];
//    NSLog(@"%@",arr[0]);
}

@end
