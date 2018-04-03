//
//  LYPUserSingle.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/1/24.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPUserSingle.h"

@implementation LYPUserSingle


+(LYPUserSingle *)shareUserSingle{
    static LYPUserSingle *single;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        single = [[LYPUserSingle alloc]init];
    });
    return single;
}

-(NSMutableArray *)managerControlArr{
    if (!_managerControlArr) {
        _managerControlArr = [NSMutableArray array];
    }
    return _managerControlArr;
}

@end
