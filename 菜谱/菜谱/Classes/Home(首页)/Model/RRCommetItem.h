//
//  RRCommetItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 11/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRCommetItem : NSObject
/** createtime*/
@property (nonatomic,strong) NSString *createtime;
/** content*/
@property (nonatomic,strong) NSString *content;
/** rank*/
@property (nonatomic,strong) NSString *rank;
/** name*/
@property (nonatomic,strong) NSString *name;
/** headImageurl*/
@property (nonatomic,strong) NSString *headImageurl;
@end
