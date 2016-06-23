//
//  RRSqlite.h
//  菜谱
//
//  Created by 丁瑞瑞 on 20/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import <FMDB.h>
@interface RRSqlite : NSObject
SingleH(RRSqlite)
/** 数据库对象*/
@property (nonatomic,strong) FMDatabaseQueue *dbQueue;
- (void)openNoticeDB:(NSString *)name;
@end
