//
//  RRChooseItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRChooseItem : NSObject
/** 名称*/
@property (nonatomic,strong) NSString *title;
/** 时间*/
@property (nonatomic,strong) NSString *datetime;
/** 地址*/
@property (nonatomic,strong) NSString *district;
/** 展示图片*/
@property (nonatomic,strong) NSString *imageurl;
/** 厨师照片*/
@property (nonatomic,strong) NSString *chefImageurl;
/** 价钱*/
@property (nonatomic,strong) NSString *price;
/** 类型*/
@property (nonatomic,assign) NSInteger dinnerType;
/** dinnerId*/
@property (nonatomic,strong) NSString *dinnerId;
/** themeDinnerId*/
@property (nonatomic,strong) NSString *themeDinnerId;




/** 名称*/
@property (nonatomic,strong) NSString *themeDinnerTitle;
/** 最低价*/
@property (nonatomic,strong) NSString *themeDinnerMinPrice;
/** 最高价*/
@property (nonatomic,strong) NSString *themeDinnerMaxPrice;
/** 菜的图片*/
@property (nonatomic,strong) NSString *themeDinnerImageurl;
/** 店址*/
@property (nonatomic,strong) NSString *themeDinnerDistrict;
/** 开始的时间*/
@property (nonatomic,strong) NSString *themeDinnerStartTime;
/** 结束的时间*/
@property (nonatomic,strong) NSString *themeDinnerEndTime;
/** 厨师ID*/
@property (nonatomic,assign) NSInteger themeDinnerChefId;
/** 厨师照片*/
@property (nonatomic,strong) NSString *themeDinnerChefImageurl;
/** 厨师的姓名*/
@property (nonatomic,strong) NSString *themeDinnerChefName;
/** 店铺的名字*/
@property (nonatomic,strong) NSString *themeDinnerChefShopName;




@end
