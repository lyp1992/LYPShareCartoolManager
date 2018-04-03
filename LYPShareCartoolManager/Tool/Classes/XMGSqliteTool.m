//
//  XMGSqliteTool.m
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGSqliteTool.h"
#import "sqlite3.h"
#define  kCache   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

@implementation XMGSqliteTool

sqlite3 *ppDb;

+ (BOOL)dealWithSql:(NSString *)sql uid:(NSString *)uid {
  
    // 1. 打开数据库
    if (![self openDBWithUID:uid]) {
        NSLog(@"失败");
        return NO;
    }
    
    // 2. 执行语句
    // 1. 一个已经打开的数据库对象
    // 2. sql
    // 3. 系统回调, 一般是执行查询的时候才有
    // 4. 错误
    char *errmsg;
    int rus = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, &errmsg);
    BOOL result = rus == SQLITE_OK;
    
    NSLog(@"%s==%d",errmsg,rus);
        // 3.关闭数据库
    [self closeDB];
    
    return result;
}


+ (BOOL)dealWithSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid {
    [self openDBWithUID:uid];
    // 1. 手动开启事务
    sqlite3_exec(ppDb, @"begin transaction;".UTF8String, nil, nil, nil);
    
    // 2. 执行语句
    for (NSString *sql in sqls) {
       BOOL result = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
        if (result == NO) {
            
            // 回滚
            sqlite3_exec(ppDb, @"rollback transaction;".UTF8String, nil, nil, nil);
            // return NO;
            return NO;
            
        }
    }
    sqlite3_exec(ppDb, @"commit transaction;".UTF8String, nil, nil, nil);

    // 3. 判定执行成功, 如果有一条有问题, -> 回滚  全正确 -> 提交

    [self closeDB];
    // 4. 关闭数据库
    
    return YES;
    
    
}


// 一条记录
// 列明1 = 列值1  列名2 = 列值2
+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid {
    
    [self openDBWithUID:uid];
    // 1. 创建准备语句, 预处理语句
    // 1. 操作的数据库
    // 2. sql
    // 3. 字节长度(从sql字符串里面, 按照这个字节长度进行截取) -1 自动计算 \0
    // 4. 准备语句对象
    // 5. 按照参数3长度, 从参数2, 里面截取字符串, 剩下的字符串
    sqlite3_stmt *ppStmt;
    BOOL result = sqlite3_prepare_v2(ppDb, sql.UTF8String, -1, &ppStmt, nil) == SQLITE_OK;
    if (!result) {
        NSLog(@"准备语句变异失败");
        return nil;
    }
    // 2. 绑定数据(省略)
    
    // 3. 执行语句
    NSMutableArray *rowDicArray = [NSMutableArray array];
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
     
        // 每次循环, 代表给过来一条记录
        // 解析这条记录
        
        // 1. 获取列的个数
        int columnCount = sqlite3_column_count(ppStmt);
        // 遍历所有的字段
        NSMutableDictionary *rowDic = [NSMutableDictionary dictionary];
        [rowDicArray addObject:rowDic];
        for (int i = 0; i < columnCount; i++) {
//            insert into stu(image) values ('010101010');
//            sqlite3_bind_blob(<#sqlite3_stmt *#>, <#int#>, <#const void *#>, <#int n#>, <#void (*)(void *)#>)
            // 解析一列
            // 列名
            const char *cn = sqlite3_column_name(ppStmt, i);
            NSString *columnName = [NSString stringWithUTF8String:cn];
            
            // 列值
            // 1. 获取这一列什么类型, 根据不同的类型, 使用不同的函数, 进行获取响应的数值
            int type = sqlite3_column_type(ppStmt, i);
            id value;
            switch (type) {
                case SQLITE_INTEGER:
                {
                    value = @(sqlite3_column_int(ppStmt, i));
                    break;
                }
                case SQLITE_FLOAT:
                {
                    value = @(sqlite3_column_double(ppStmt, i));
                    break;
                }
                case SQLITE_BLOB:
                {
                    value = CFBridgingRelease(sqlite3_column_blob(ppStmt, i));
                    break;
                }
                case SQLITE_NULL:
                {
                    value = @"";
                    break;
                }
                case SQLITE3_TEXT:
                {
                   const char *temp = (const char *)sqlite3_column_text(ppStmt, i);
//
                    NSString *tempR = [NSString stringWithUTF8String:temp];
                    value = tempR;
                    
                    break;
                }
                default:
                    break;
            }
            
            [rowDic setValue:value forKey:columnName];
            
        }
        
    }
    
    // 4. 重置数据(省略)

    // 5. 释放资源
    sqlite3_finalize(ppStmt);

    [self closeDB];
    
    return rowDicArray;
}



+ (BOOL)openDBWithUID:(NSString *)uid {
    
    // uid == nil cache/common.sqlite
    // uid == @"zhangsan" cache/zhangsan.sqlite
    
//    如果选择的是空客，那么数据库读取的就是空客，
    
    NSString *dbPath;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Boeing"]) {
        dbPath = [kCache stringByAppendingPathComponent:@"Boeing"];
        
    }else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Airbus"]){
        dbPath = [kCache stringByAppendingPathComponent:@"Airbus"];
        
    }
    if (uid.length > 0) {
        dbPath = [dbPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", uid]];
    }
    NSLog(@"dbPath==%@",dbPath);

    // 1. 数据库路径
    // 2. 一个已经打开的数据库,
    BOOL result = sqlite3_open(dbPath.UTF8String, &ppDb) == SQLITE_OK;
    if (result) {
        NSLog(@"数据库创建并且打开成功");
    }else {
        NSLog(@"数据库创建并且打开失败");
    }

    return result;
}

+ (void)closeDB {
    sqlite3_close(ppDb);
}






@end
