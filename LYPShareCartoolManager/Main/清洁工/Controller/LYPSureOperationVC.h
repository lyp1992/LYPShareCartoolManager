//
//  LYPSureOperationVC.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/30.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheetView.h"
@class LYPDevicesModel;
@interface LYPSureOperationVC : BaseViewController<SheetViewDelegate, SheetViewDataSource>

-(void)itemWithModel:(LYPDevicesModel*)model withTopTitleArr:(NSArray *)titleArr andIndexRow:(NSIndexPath *)indexPath withIndexCol:(NSIndexPath *)indexCol IsBattery:(BOOL)isBattery;

@end
