//
//  LYPmanagerExcelVC.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/23.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPManageCleanToolProtocol.h"
#import "SheetView.h"

@interface LYPmanagerExcelVC : BaseViewController<LYPManageCleanToolProtocol,SheetViewDelegate, SheetViewDataSource>
-(void)didSelectToolRow:(NSIndexPath *)indexPath withUnSelect:(BOOL)unSelect;

@end
