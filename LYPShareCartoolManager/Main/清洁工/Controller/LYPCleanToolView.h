//
//  LYPCleanToolView.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPManageCleanToolProtocol.h"
@class LYPCleanToolView;
@protocol LYPCleanToolViewDelegate<NSObject>

//选择
-(void)LYPCleanToolView:(LYPCleanToolView*)toolView didSelectRow:(NSIndexPath *)indexPath;
//未选择
-(void)LYPCleanToolView:(LYPCleanToolView *)toolView didUnSelectRow:(NSIndexPath *)indexPath;

@end

@interface LYPCleanToolView : UICollectionView

@property (nonatomic, strong) NSArray *numArr;

@property (nonatomic, weak) id <LYPCleanToolViewDelegate> toolDelegate;


@end
