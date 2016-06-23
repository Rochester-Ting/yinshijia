//
//  RRExtension.m
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRExtension.h"
#import <MJExtension/MJExtension.h>
#import "RRImageItem.h"
#import "RRFairItem.h"
@implementation RRExtension
+(void)load{
    [RRImageItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"des" : @"description",
                 @"id" : @"nameID"
                 };
    }];
    [RRFairItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"des" : @"description",
                 @"id" : @"nameID"
                 };
    }];
}
@end
