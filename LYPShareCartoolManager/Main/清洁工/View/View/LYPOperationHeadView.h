//
//  LYPOperationHeadView.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/17.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPDevicesModel.h"
#import "LYPDataListModel.h"

@interface LYPOperationHeadView : UIView

+(LYPOperationHeadView *)awakeFormXib;

@property (nonatomic, strong) LYPDataListModel *dataListModel;
@property (nonatomic, strong) NSIndexPath *indePath;

@property (nonatomic, assign) BOOL successOpen;

@end
