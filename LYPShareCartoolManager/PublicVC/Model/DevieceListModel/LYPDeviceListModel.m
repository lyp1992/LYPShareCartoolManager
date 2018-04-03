//
//  LYPDeviceListModel.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/28.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPDeviceListModel.h"

@implementation LYPDeviceListModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[LYPDataListModel class]};
}

@end
