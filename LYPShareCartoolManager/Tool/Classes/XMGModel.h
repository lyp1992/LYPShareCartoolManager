//
//  XMGModel.h
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGModel : NSObject

+ (NSString *)tableName:(Class)cls;
+ (NSString *)tmpTableName:(Class)cls;

+ (NSDictionary *)modelIvarNameAndIvarType:(Class)cls;

+ (NSDictionary *)modelIvarNameAndSqliteType:(Class)cls;

+ (NSString *)modelIvarNameAndSqliteTypeStr:(Class)cls;


+ (NSArray *)modelIvarSortedNames:(Class)cls;


@end

