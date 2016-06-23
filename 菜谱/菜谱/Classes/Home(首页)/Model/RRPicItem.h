//
//  RRPicItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRPicItem : NSObject
/*campaign*/
/** id*/
//@property (nonatomic,strong) NSString *nameID;
///** title*/
//@property (nonatomic,strong) NSString *title;
///** banner_image*/
//@property (nonatomic,strong) NSString *banner_image;
///** description*/
//@property (nonatomic,strong) NSString *des;
///** show_order*/
//@property (nonatomic,strong) NSString *show_order;

/******item*******/
/** 图片*/
@property (nonatomic,strong) NSString *dinner_imageurl;
/** 主题描述*/
@property (nonatomic,strong) NSString *dinner_title;
/** 地址*/
@property (nonatomic,strong) NSString *dinner_district;
/** 价格*/
@property (nonatomic,strong) NSString *dinner_price;
/** 开始日期*/
@property (nonatomic,strong) NSString *dinner_datetime;
/** 结束日期*/
@property (nonatomic,strong) NSString *dinner_endOrderTime;
/** <#注释#>*/
@property (nonatomic,strong) NSString *dinner_id;
/** */
@property (nonatomic,assign) NSInteger type;
@end
