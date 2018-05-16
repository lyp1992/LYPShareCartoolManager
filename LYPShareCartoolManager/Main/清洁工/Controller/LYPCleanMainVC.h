//
//  LYPCleanMainVC.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/19.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheetView.h"
@class LYPBuildListModel;
@interface LYPCleanMainVC : BaseViewController<SheetViewDelegate, SheetViewDataSource>

@property (nonatomic, strong) LYPBuildListModel *buildListModel;

@end
