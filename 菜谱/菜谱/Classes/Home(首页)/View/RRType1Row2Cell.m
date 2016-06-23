//
//  RRType1Row2Cell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType1Row2Cell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
@interface RRType1Row2Cell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation RRType1Row2Cell

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.btn setTitle:arr[0] forState:UIControlStateNormal];
//    [self.btn setImage:arr[] forState:<#(UIControlState)#>];
//    [self.btn sd_setImageWithURL:[NSURL URLWithString:arr[1]] forState:UIControlStateNormal];
}
- (IBAction)btnClick:(id)sender {
}

@end
