//
//  XMGTable.m
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGTable.h"
#import "XMGSqliteTool.h"

@implementation XMGTable

+ (NSArray *)columnSortedNames:(NSString *)tableName uid:(NSString *)uid {
    
    NSString *sql = [NSString stringWithFormat:@"select sql from sqlite_master where name = '%@'", tableName];
    
    
    NSArray *result = [XMGSqliteTool querySql:sql uid:uid];
    
    NSLog(@"==%@", result);
    
    // "CREATE TABLE XMGStu(name text,score real,stu_id integer, primary key(stu_id))"
    NSString *createTableSQL = result.firstObject[@"sql"];
    
    // name text,score real,stu_id integer,primary key
    NSString *sql1 = [createTableSQL componentsSeparatedByString:@"("][1];
    
    NSArray *columnNameTypes = [sql1 componentsSeparatedByString:@","];
    
    // name text
    // score real
    NSMutableArray *results = [NSMutableArray array];
    for (NSString *columnNameType in columnNameTypes) {
        
        if ([columnNameType containsString:@"primary"]) {
            continue;
        }
        
       NSString *columnName = [columnNameType componentsSeparatedByString:@" "].firstObject;
        [results addObject:columnName];
 
    }
    
    
    [results sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    return results;
}


@end
