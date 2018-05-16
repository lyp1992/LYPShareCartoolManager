//
//  LYPBuildDataModel.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/16.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYPErrorModel.h"
@interface LYPBuildDataModel : NSObject

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) LYPErrorModel *error;

@end
