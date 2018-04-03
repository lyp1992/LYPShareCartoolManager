//
//  XMGSqliteModeProtocol.h
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol XMGSqliteModelProtocol <NSObject>

@required
+ (NSString *)primaryKey;

@optional
+ (NSArray *)ignoreColumnNames;

+ (NSDictionary *)renameNewKeyToOldKeyDic;


@end
