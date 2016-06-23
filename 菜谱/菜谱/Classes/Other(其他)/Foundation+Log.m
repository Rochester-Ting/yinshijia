//
//  NSDictionary+Log.m
//  01-掌握-多值参数和中文输出
//
//  Created by xmg on 15/12/28.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

//控制输出:对字典或者是数组进行排版
-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //设置开始
    [string appendString:@"{\n"];
    
    //设置key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@,\n",obj];
    }];
    //设置结尾
    [string appendString:@"}"];
    
    //删除最后的逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}

/*
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    //设置开始
    [string appendString:@"{"];
    
    //设置key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@",obj];
    }];
    //设置结尾
    [string appendString:@"}"];
    return string;
}
 */
@end


@implementation NSArray (Log)

//控制输出:对字典或者是数组进行排版
-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //设置开始
    [string appendString:@"["];
    
    //设置key-value
   [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [string appendFormat:@"%@,",obj];
       
   }];
    //设置结尾
    [string appendString:@"]"];
    
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}

@end
