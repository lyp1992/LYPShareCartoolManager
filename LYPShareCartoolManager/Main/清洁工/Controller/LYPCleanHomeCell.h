//
//  LYPCleanHomeCell.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPBuildListModel.h"
@interface LYPCleanHomeCell : UICollectionViewCell

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, strong) LYPBuildListModel *buildListModel;

@end
