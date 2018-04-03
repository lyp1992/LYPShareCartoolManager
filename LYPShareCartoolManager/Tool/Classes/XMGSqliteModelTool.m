//
//  XMGSqliteModelTool.m
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGSqliteModelTool.h"
#import "XMGSqliteTool.h"
#import "XMGModel.h"
#import "XMGTable.h"


@implementation XMGSqliteModelTool


+ (NSArray *)queryAllModels:(Class)cls uid:(NSString *)uid {
    
    NSString *tableName = [XMGModel tableName:cls];
    NSString *querySql = [NSString stringWithFormat:@"select * from %@", tableName];
    
    NSArray <NSDictionary *>*results = [XMGSqliteTool querySql:querySql uid:uid];
    
    return [self handleResults:results toModelClass:cls];
}

+ (NSArray *)queryModels:(Class)cls key:(NSString *)key relation:(RelationType)relation value:(id)value uid:(NSString *)uid {
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ %@ '%@'", tableName, key, [self ralationToStr][@(relation)], value];
    
    NSArray <NSDictionary *>*results = [XMGSqliteTool querySql:sql uid:uid];
    return [self handleResults:results toModelClass:cls];
    
}

+ (NSArray *)queryModels:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid {
    
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@", tableName, whereStr];

    NSArray <NSDictionary *>*results = [XMGSqliteTool querySql:sql uid:uid];
    return [self handleResults:results toModelClass:cls];
}


// sql as
// select name, age
// cls 属性名称保持一致
+ (NSArray *)queryModels:(Class)cls querySQL:(NSString *)sql uid:(NSString *)uid {
    
    NSArray <NSDictionary *>*results = [XMGSqliteTool querySql:sql uid:uid];
    return [self handleResults:results toModelClass:cls];
    
}

+ (NSArray *)handleResults:(NSArray <NSDictionary *>*)results toModelClass:(Class)cls {
    
    NSMutableArray *modelR = [NSMutableArray array];
    
    NSDictionary *ivarNameTypeDic = [XMGModel modelIvarNameAndIvarType:cls];
    
    for (NSDictionary *rowDic in results) {
        id model = [[cls alloc] init];
        [modelR addObject:model];
        
        [rowDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull columnName, id  _Nonnull value, BOOL * _Nonnull stop) {
            
            
            // 对value<进行处理(这一列对应的类型, 是数组/字典)
            // 1. 拿到类型
            NSString *type = ivarNameTypeDic[columnName];
            
            id tmpValue = value;
            if ([type isEqualToString:@"NSArray"] || [type isEqualToString:@"NSDictionary"]) {
                
                // array -> data -> str
                // str -> data -> array
                NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
                // NSJSONReadingMutableContainers 可变容器
                // 0 解析出来的集合, 是不可变
                NSError *error;
                tmpValue = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                }
                
                
            } else if ([type isEqualToString:@"NSMutableArray"] || [type isEqualToString:@"NSMutableDictionary"]) {
                // array -> data -> str
                // str -> data -> array
                NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
                // NSJSONReadingMutableContainers 可变容器
                // 0 解析出来的集合, 是不可变
                tmpValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
            
            // 2. 转换 string -> array / dic
            
            [model setValue:tmpValue forKeyPath:columnName];
            
        }];
        
        
//        [model setValuesForKeysWithDictionary:rowDic];
    }
    return modelR;
}



+ (BOOL)deleteAllModel:(Class)cls uid:(NSString *)uid {
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"delete from %@", tableName];
    return [XMGSqliteTool dealWithSql:sql uid:uid];
}

+ (BOOL)deleteModel:(id)model uid:(NSString *)uid {
    
    Class cls = [model class];
//    NSString *tableName = [XMGModel tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要使用这个框架, 操作你的模型, 必须要实现+ (NSString *)primaryKey;");
        return NO;
    }
    NSString *primaryKey = [cls primaryKey];
    id primaryKeyValue = [model valueForKeyPath:primaryKey];
//    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", tableName, primaryKey, primaryKeyValue];
//    
//    return [XMGSqliteTool dealWithSql:sql uid:uid];
    
    return [self deleteModels:cls key:primaryKey relation:RelationTypeEqual value:primaryKeyValue uid:uid];
    
    
}

+ (BOOL)deleteModels:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid {
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ ", tableName];
    if (whereStr.length > 0) {
        sql = [sql stringByAppendingFormat:@"where %@", whereStr];
    }
    return [XMGSqliteTool dealWithSql:sql uid:uid];
}


+ (BOOL)deleteModels:(Class)cls key:(NSString *)key relation:(RelationType)relation value:(id)value uid:(NSString *)uid {
    
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ %@ '%@'", tableName, key, [self ralationToStr][@(relation)], value];
    
    return [XMGSqliteTool dealWithSql:sql uid:uid];
}


+ (NSDictionary *)ralationToStr {
    
    return @{
             @(RelationTypeGreater): @">",
             @(RelationTypeLess): @"<",
             @(RelationTypeEqual): @"=",
             @(RelationTypeGreaterEqual): @">=",
             @(RelationTypeLessEqual): @"<=",
             @(RelationTypeNotEqual): @"!="
             };
    
}


// 如果记录不存在 -> 写入
// 如果记录存在 -> 根据主键进行更新
+ (BOOL)saveOrUpdateModel:(id)model uid:(NSString *)uid {
    Class cls = [model class];
    // 0. 判断是否存在这个表格, 如果不存在 根据这个模型创建一个表格
    if (![self isTableExists:cls uid:uid]) {
        [self createTable:cls uid:uid];
    }
    // 1. 判断表格是否需要更新, 如果需要, 你更新表格
    if ([self isTableRequiredUpdate:cls uid:uid]) {
        [self updateTable:cls uid:uid];
    }
    
    // 表格肯定有, 而且,最新
    
    
    // 2. 应该判断, 记录是否存在
    NSString *tableName = [XMGModel tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要使用这个框架, 操作你的模型, 必须要实现+ (NSString *)primaryKey;");
        return NO;
    }
    NSString *primaryKey = [cls primaryKey];
    id primaryKeyValue = [model valueForKeyPath:primaryKey];
    NSString *rowExists = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",tableName, primaryKey, primaryKeyValue];
    NSArray *rows = [XMGSqliteTool querySql:rowExists uid:uid];
    
    
    // 所有的字段名称
    NSDictionary *ivarNameTypeDic = [XMGModel modelIvarNameAndIvarType:cls];
    NSArray *columnNames = ivarNameTypeDic.allKeys;
    
    // 所有的字段值
    NSMutableArray *columnNameValues = [NSMutableArray array];
    for (NSString *columnName in columnNames) {
        id value = [model valueForKeyPath:columnName];
        
        // 对value, 进行处理
        // 处理方式: 把字典/数组 -> 字符串进行存储
        // 1. 获取这一列真正的类型
//        NSString *type = ivarNameTypeDic[columnName];
        // 2. 判断, 数组/字典 -> 字符串
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {

            NSData *data = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        
        [columnNameValues addObject:value];
    }
    
   
    
    
    if (rows.count > 0) {
        // 2.1 存在 -> 更新
        // update 表名 set 字段1='字段1值',字段2='字段2值'.. where 主键 = '主键值';
        // 拼接 字段1='字段1值',字段2='字段2值' set 部分
        NSInteger count = columnNames.count;
        NSMutableArray *setArray = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            
            NSString *columnName = columnNames[i];
            id value = columnNameValues[i];
            
            // 字段1='字段1值'
            NSString *setStr = [NSString stringWithFormat:@"%@='%@'", columnName, value];
            [setArray addObject:setStr];
        }
        
        // 字段1='字段1值',字段2='字段2值'
        NSString *setStrResult = [setArray componentsJoinedByString:@","];
        
        NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ where %@ = '%@'", tableName, setStrResult, primaryKey, primaryKeyValue];
        return [XMGSqliteTool dealWithSql:updateSql uid:uid];
        
    }
     // 2.2 不存在 -> 插入
    // insert into 表名(字段1, 字段2..) values ('字段1值', '字段2值');
    // 字段1, 字段2
    NSString *columnNameStr = [columnNames componentsJoinedByString:@","];
    
    // 10','wex','18
    NSString *columnValueStr = [columnNameValues componentsJoinedByString:@"','"];
    
    // insert sql
    // '010101001010101010101010' string nsdata
    // 借助 预处理语句

    NSString *insertSql = [NSString stringWithFormat:@"insert into %@(%@) values ('%@')", tableName, columnNameStr, columnValueStr];
//    @"insert into stu(stu_id, name) values ('1', 'sz'')";
    
    return [XMGSqliteTool dealWithSql:insertSql uid:uid];
    

}


+ (BOOL)isTableExists:(Class)cls uid:(NSString *)uid {
    
    NSString *tableName = [XMGModel tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"select * from sqlite_master where type = 'table' and name = '%@';", tableName];
    NSArray *result = [XMGSqliteTool querySql:sql uid:uid];
    return result.count >= 1;
}


+ (BOOL)createTable:(Class)modelClass uid:(NSString *)uid {
    
    NSString *tableName = [XMGModel tableName:modelClass];
    
    NSString *nameTypeStr = [XMGModel modelIvarNameAndSqliteTypeStr:modelClass];

    if (![modelClass respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要使用这个框架, 操作你的模型, 必须要实现+ (NSString *)primaryKey;");
        return NO;
    }
    
    NSString *primaryKey = [modelClass primaryKey];
    
     NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(%@,primary key(%@))", tableName, nameTypeStr, primaryKey];
    
//    "create table 表名(字段名 字段类型 , 字段2名 字段类型, primary key(主键))";
    
    return [XMGSqliteTool dealWithSql:sql uid:uid];

}

+ (BOOL)isTableRequiredUpdate:(Class)cls uid:(NSString *)uid {
    
    // 1. 获取 模型里面的字段数组
    NSArray *array1 = [XMGModel modelIvarSortedNames:cls];
    
    // 2. 获取 表格里面所有的字段数组
    NSArray *array2 = [XMGTable columnSortedNames:[XMGModel tableName:cls] uid:uid];
    
    // 3. 比较
    return ![array1 isEqualToArray:array2];

}

+ (BOOL)updateTable:(Class)cls uid:(NSString *)uid {
    
    
    NSMutableArray *sqls = [NSMutableArray array];
    
    // 1. 创建一个临时表格(表格结构,肯定是最正确)
    NSString *tmpTableName = [XMGModel tmpTableName:cls];
    NSString *oldTableName = [XMGModel tableName:cls];
    
    NSString *nameTypeStr = [XMGModel modelIvarNameAndSqliteTypeStr:cls];
    
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要使用这个框架, 操作你的模型, 必须要实现+ (NSString *)primaryKey;");
        return NO;
    }
    
    NSString *primaryKey = [cls primaryKey];
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(%@,primary key(%@));", tmpTableName, nameTypeStr, primaryKey];
    [sqls addObject:sql];
    //    "create table 表名(字段名 字段类型 , 字段2名 字段类型, primary key(主键))";

    
    // 2. 从旧表里面, 把数据 -> 临时表格
    // 2.1 应该按照主键, 插入数据到临时表
    // insert into xmgstu_tmp(stu_id) select stu_id from xmgstu;
    // insert into 临时表格名称(主键) select 主键 from 旧的表格;
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@(%@) select %@ from %@;", tmpTableName, primaryKey, primaryKey, oldTableName];
    [sqls addObject:insertSql];
    
    NSDictionary *renameDic;
    if ([cls respondsToSelector:@selector(renameNewKeyToOldKeyDic)]) {
        renameDic = [cls renameNewKeyToOldKeyDic];
    }
    
    NSArray *newColumnNames = [XMGModel modelIvarSortedNames:cls];
    NSArray *oldColumnNames = [XMGTable columnSortedNames:oldTableName uid:uid];
    
    for (NSString *newColumnName in newColumnNames) {
        // 2.2 根据主键, 旧的表格里面更新数据到 临时表格
        // update xmgstu_tmp set name = (select name from xmgstu where xmgstu.stu_id = xmgstu_tmp.stu_id);
        // update 临时表格名称 set 新字段名称 = (select 旧的字段名称 from 旧的表格 where 旧的表格.主键 = 临时表格名称.主键);
        // name2  name2 name
        NSString *oldName = [renameDic valueForKey:newColumnName];
        // name
        if(oldName.length == 0 || ![oldColumnNames containsObject:oldName])
        {
            oldName = newColumnName;
        }
        if ((![oldColumnNames containsObject:newColumnName] && ![oldColumnNames containsObject:oldName]) || [newColumnName isEqualToString:primaryKey]) {
            continue;
        }
        
        NSString *updateDataSQL = [NSString stringWithFormat:@"update %@ set %@ = (select %@ from %@ where %@.%@ = %@.%@);", tmpTableName, newColumnName, oldName, oldTableName, oldTableName, primaryKey, tmpTableName, primaryKey];
        [sqls addObject:updateDataSQL];
        
    }

    // 3. 删除旧表格
    NSString *deleteSql = [NSString stringWithFormat:@"drop table if exists %@;", oldTableName];
    [sqls addObject:deleteSql];
    
    // 4. 更新临时表格名称 xmgstu
    NSString *renameTable = [NSString stringWithFormat:@"alter table %@ rename to %@;", tmpTableName, oldTableName];
    [sqls addObject:renameTable];
    
//    NSLog(@"%@", sqls);
    
    [XMGSqliteTool dealWithSqls:sqls uid:uid];
    
    return YES;
}



@end
