//
//  LYPOperationVC.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/17.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYPDevicesModel,LYPDataListModel;
@interface LYPOperationVC : UIViewController

-(void)itemWithModel:(LYPDataListModel*)model withTopTitleArr:(NSArray *)titleArr andIndexRow:(NSIndexPath *)indexPath withIndexCol:(NSIndexPath *)indexCol IsBattery:(BOOL)isBattery;

@end
