//
//  LYPDeviceListModel.h
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/28.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYPDataListModel.h"
#import "LYPErrorModel.h"

@interface LYPDeviceListModel : NSObject
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) LYPErrorModel *error;

@end
