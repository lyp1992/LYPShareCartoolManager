//
//  XMGModel.m
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGModel.h"
#import <objc/message.h>
#import "XMGSqliteModelProtocol.h"

@implementation XMGModel


+ (NSString *)tableName:(Class)cls {
    return NSStringFromClass(cls);
}

+ (NSString *)tmpTableName:(Class)cls {
    return [NSStringFromClass(cls) stringByAppendingString:@"_tmp"];
}


// 获取所有的这个类里卖弄的成员变量
+ (NSDictionary *)modelIvarNameAndIvarType:(Class)cls {
    
    unsigned int outCount;
    Ivar *ivarList = class_copyIvarList(cls, &outCount);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i++) {
        

        //        Ivar
        // 获取成员变量名称, 类型
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        
        // 1.获取忽略字段的数组, 查看是否包含, 这个字段
        NSArray *ignoreNames = nil;
        if ([cls respondsToSelector:@selector(ignoreColumnNames)]) {
            ignoreNames = [cls ignoreColumnNames];
        }
        if ([ignoreNames containsObject:ivarName]) {
            continue;
        }
        
        NSString *ivarType = [NSString stringWithUTF8String: ivar_getTypeEncoding(ivarList[i])];
        
        ivarType = [ivarType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        
        [dic setValue:ivarType forKey:ivarName];
        
    }
    
    return dic;
    
    
}

+ (NSDictionary *)modelIvarNameAndSqliteType:(Class)cls {
    
    NSDictionary *nameTypeDic = [self modelIvarNameAndIvarType:cls];
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [result setValue:[self ivarTypeToSqliteTypeDic][obj] forKey:key];
        
        
    }];
    
    return result;
    
}


+ (NSString *)modelIvarNameAndSqliteTypeStr:(Class)cls {
    
    NSDictionary *dic = [self modelIvarNameAndSqliteType:cls];
    
    
    NSMutableArray *array = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // a integer
        // name2 text
        NSString *tmp = [NSString stringWithFormat:@"%@ %@", key, obj];
        [array addObject:tmp];
        
        
    }];
    
    // a integer,name2 text
    //
    return [array componentsJoinedByString:@","];
    
}


+ (NSArray *)modelIvarSortedNames:(Class)cls {
    
    // key 列名称 , value type
    NSDictionary *dic = [self modelIvarNameAndIvarType:cls];
    NSArray *columnNames = dic.allKeys;
    columnNames = [columnNames sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    return columnNames;
    
}


+ (NSDictionary *)ivarTypeToSqliteTypeDic {
    return @{
                    @"d": @"real", // double
                    @"f": @"real", // float
                    
                    @"i": @"integer",  // int
                    @"q": @"integer", // long
                    @"Q": @"integer", // long long
                    @"B": @"integer", // bool
                    
                    @"NSData": @"blob",
                    @"NSDictionary": @"text",
                    @"NSMutableDictionary": @"text",
                    @"NSArray": @"text",
                    @"NSMutableArray": @"text",
                    
                    @"NSString": @"text"
                    };

}




@end
