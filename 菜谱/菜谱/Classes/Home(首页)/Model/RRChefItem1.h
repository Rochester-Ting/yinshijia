//
//  RRChefItem1.h
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRChefItem1 : NSObject
/** shopName*/
@property (nonatomic,strong) NSString *shopName;
/** headImageurl*/
@property (nonatomic,strong) NSString *headImageurl;
/** converurl*/
@property (nonatomic,strong) NSString *converurl;
/** introduce*/
@property (nonatomic,strong) NSString *introduce;
/** tags*/
@property (nonatomic,strong) NSString *tags;
/** name*/
@property (nonatomic,strong) NSString *name;
/** environmentText*/
@property (nonatomic,strong) NSString *environmentText;
/** custom_order_flag*/
@property (nonatomic,strong) NSString *custom_order_flag;
/** orderedCount*/
@property (nonatomic,strong) NSString *orderedCount;
/** likeCount*/
@property (nonatomic,strong) NSString *likeCount;
@end
