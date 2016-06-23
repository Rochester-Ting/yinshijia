//
//  RRDisItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRDisItem : NSObject
/*头部*/
/** catalogId*/
@property (nonatomic,strong) NSString *catalogId;
/** 主题*/
@property (nonatomic,strong) NSString *catalogTitle;
/** 图片*/
@property (nonatomic,strong) NSString *catalogImage;

/*cell*/
/** userId*/
@property (nonatomic,strong) NSString *userId;
/** 厨师的照片*/
@property (nonatomic,strong) NSString *imageurl;
/** 姓名*/
@property (nonatomic,strong) NSString *name;
/** 店铺名字*/
@property (nonatomic,strong) NSString *shopName;
/** 介绍*/
@property (nonatomic,strong) NSString *introduce;
/** 预定*/
@property (nonatomic,assign) NSInteger orderedCount;
/** 喜欢*/
@property (nonatomic,assign) NSInteger likeCount;
/** 是否添加为关注*/
@property (nonatomic,assign) BOOL favorite;

@end
