//
//  LYPDataListModel.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/28.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPDataListModel.h"
#import "LYPDevicesModel.h"
@implementation LYPDataListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"devices":[LYPDevicesModel class]};
}

@end
