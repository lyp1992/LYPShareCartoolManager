//
//  LYPCleanToolCell.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPToolModel.h"
@class LYPCleanToolCell;
@protocol LYPCleanToolCellDelegate <NSObject>
-(void)cleanToolView:(LYPCleanToolCell *)view selectButton:(UIButton *)sender withIndexPath:(NSIndexPath *)indexPath;
@end
@interface LYPCleanToolCell : UICollectionViewCell

@property (nonatomic, strong) LYPToolModel *toolModel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<LYPCleanToolCellDelegate>delegate;
@end
