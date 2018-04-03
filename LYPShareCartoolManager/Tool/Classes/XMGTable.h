//
//  XMGTable.h
//  数据库
//
//  Created by seemygo on 17/3/5.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGTable : NSObject

+ (NSArray *)columnSortedNames:(NSString *)tableName uid:(NSString *)uid;


@end
