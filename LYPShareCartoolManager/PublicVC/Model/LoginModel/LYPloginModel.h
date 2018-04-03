//
//  LYPloginModel.h
//  YPSharingCarton
//
//  Created by laiyp on 2018/2/7.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYPErrorModel.h"
#import "LYPTokenModel.h"
@interface LYPloginModel : NSObject

@property (nonatomic, strong) LYPTokenModel *data;

@property (nonatomic, strong) LYPErrorModel *error;

@end
