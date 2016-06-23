//
//  RRChefImageItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRChefImageItem : NSObject
/** userId*/
@property (nonatomic,strong) NSString *userId;
/** zhaop*/
@property (nonatomic,strong) NSString *imageurl;
/** title*/
@property (nonatomic,strong) NSString *title;
/** 描述*/
@property (nonatomic,strong) NSString *des;
@end
