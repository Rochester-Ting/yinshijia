//
//  RRTextField.m
//  百思不得姐
//
//  Created by 丁瑞瑞 on 30/1/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTextField.h"

@implementation RRTextField

- (void)awakeFromNib
{
    self.tintColor  = [UIColor whiteColor];
//    NSLog(@"%@",self.placeholder);
}
//当uitextfiled成为第一响应者
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
//当uitextfiled不是第一响应者
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forKeyPath:@"placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
