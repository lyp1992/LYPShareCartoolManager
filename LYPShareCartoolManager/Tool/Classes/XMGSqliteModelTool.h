//
//  XMGSqliteModelTool.h
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGSqliteModelProtocol.h"


typedef NS_ENUM(NSUInteger, RelationType) {
    RelationTypeGreater,
    RelationTypeLess,
    RelationTypeEqual,
    RelationTypeGreaterEqual,
    RelationTypeLessEqual,
    RelationTypeNotEqual
};


@interface XMGSqliteModelTool : NSObject

+ (BOOL)saveOrUpdateModel:(id)model uid:(NSString *)uid;

+ (BOOL)saveOrUpdateModels:(Class)cls uid:(NSString *)uid;

// 删除

// 0. 删除所有的模型
+ (BOOL)deleteAllModel:(Class)cls uid:(NSString *)uid;
// 1. 删除指定的某个具体模型
+ (BOOL)deleteModel:(id)model uid:(NSString *)uid;

// 2. 根据某一个条件, 去删除批量模型
// delete from stu where age = '10';
// delete from stu where age > '10';
+ (BOOL)deleteModels:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid;

// age >= 10
+ (BOOL)deleteModels:(Class)cls key:(NSString *)key relation:(RelationType)relation value:(id)value uid:(NSString *)uid;

// sql 语句 灵活
// sql 语句
// 封装 -> 让用户, 直接操作模型, 尽可能少的写sql
// sql 拼接, 你来做 外界传递过来足够的信息 -> 内部拼接
// 查询所有
+ (NSArray *)queryAllModels:(Class)cls uid:(NSString *)uid;
+ (NSArray *)queryModels:(Class)cls key:(NSString *)key relation:(RelationType)relation value:(id)value uid:(NSString *)uid;
+ (NSArray *)queryModels:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid;

+ (NSArray *)queryModels:(Class)cls querySQL:(NSString *)sql uid:(NSString *)uid;





// 多条件
// age >= 10 and score > 20
//+ (BOOL)deleteModels:(Class)cls keys:(NSArray *)keys relations:(NSArray *)relations values:(NSArray *)values naos:(NSArray *)naos uid:(NSString *)uid;


//+ (BOOL)updateModel:(Class)cls uid:(NSString *)uid;



//+ (BOOL)isTableExists:(Class)cls uid:(NSString *)uid;
//
//+ (BOOL)createTable:(Class)modelClass uid:(NSString *)uid;
//
//+ (BOOL)isTableRequiredUpdate:(Class)cls uid:(NSString *)uid;
//
//+ (BOOL)updateTable:(Class)cls uid:(NSString *)uid;

@end
