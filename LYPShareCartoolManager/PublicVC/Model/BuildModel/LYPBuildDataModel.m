//
//  LYPBuildDataModel.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/16.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPBuildDataModel.h"
#import "LYPBuildListModel.h"
@implementation LYPBuildDataModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[LYPBuildListModel class]};
}

@end
