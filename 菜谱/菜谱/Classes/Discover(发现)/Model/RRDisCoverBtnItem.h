//
//  RRDisCoverBtnItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRDisCoverBtnItem : NSObject
/** itemId*/
@property (nonatomic,strong) NSString *itemId;
/** type*/
@property (nonatomic,strong) NSString *type;
/** unit*/
@property (nonatomic,strong) NSString *unit;
/** dinnerTitle*/
@property (nonatomic,strong) NSString *dinnerTitle;
/** dinnerImage*/
@property (nonatomic,strong) NSString *dinnerImage;
/** dinnerStartTime*/
@property (nonatomic,strong) NSString *dinnerStartTime;
/** dinnerEndTime*/
@property (nonatomic,strong) NSString *dinnerEndTime;
/** dinnerPrice*/
@property (nonatomic,strong) NSString *dinnerPrice;
/** dinnerDistrict*/
@property (nonatomic,strong) NSString *dinnerDistrict;
@end
