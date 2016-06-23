//
//  RRSqlite.m
//  菜谱
//
//  Created by 丁瑞瑞 on 20/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRSqlite.h"

@implementation RRSqlite
SingleM(RRSqlite)
- (void)openNoticeDB:(NSString *)name
{
    
    //        创建数据库的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:name];
    NSLog(@"%@",fileName);
    //        创建数据库
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    //        打开数据库
    NSString *sql = @"CREATE TABLE IF NOT EXISTS t_notice (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL);";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql values:nil error:nil];
        if (result) {
            RRLog(@"建表成功!");
        }else{
            RRLog(@"建表失败");
        }
    }];
    
}
@end
