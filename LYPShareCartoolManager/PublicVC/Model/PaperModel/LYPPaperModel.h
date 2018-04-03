//
//  LYPPaperModel.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/30.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYPErrorModel.h"
#import "LYPPaperDataMOdel.h"
@interface LYPPaperModel : NSObject

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) LYPErrorModel *error;

@end
