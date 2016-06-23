//
//  NSString+RRString.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "NSString+RRString.h"

@implementation NSString (RRString)
-(NSString *)subString
{
    NSString * str = [self componentsSeparatedByString:@","].firstObject;
    return str;
}
- (NSString *)subStringLast
{
    NSString * str = [self componentsSeparatedByString:@"-"].lastObject;
    return str;
}
- (NSString *)subStringMiddle
{
    NSString *str = [self componentsSeparatedByString:@"-"].lastObject;
    NSString *str2 = [str componentsSeparatedByString:@" "].firstObject;
    return str2;
}
@end
