//
//  XMGSqliteTool.h
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSqliteTool : NSObject

// CRUD 增删改  查 -> 记录的集合
//

+ (BOOL)dealWithSql:(NSString *)sql uid:(NSString *)uid;

+ (BOOL)dealWithSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid;

// 一条记录
// 列明1 = 列值1  列名2 = 列值2
+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid;


@end
