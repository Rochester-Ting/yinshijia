//
//  RRFairItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 21/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRFairItem : NSObject
/** id*/
@property (nonatomic,strong) NSString *goodsId;
/** title*/
@property (nonatomic,strong) NSString *title;
/** description*/
@property (nonatomic,strong) NSString *des;
/** 价格*/
@property (nonatomic,strong) NSString *subtitle;
/** 图片的url*/
@property (nonatomic,strong) NSString *properties_image;
@end
