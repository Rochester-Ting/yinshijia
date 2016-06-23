//
//  chefViewItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chefViewItem : NSObject
/** 图片*/
@property (nonatomic,strong) NSString *imageurl;
/** name*/
@property (nonatomic,strong) NSString *name;
//shopName
@property (nonatomic,strong) NSString *shopName;
/** introduce*/
@property (nonatomic,strong) NSString *introduce;
/** 预定*/
@property (nonatomic,assign) NSInteger orderedCount;
/** 喜欢*/
@property (nonatomic,assign) NSInteger likeCount;

/** userId*/
@property (nonatomic,strong) NSString *userId;
@end
