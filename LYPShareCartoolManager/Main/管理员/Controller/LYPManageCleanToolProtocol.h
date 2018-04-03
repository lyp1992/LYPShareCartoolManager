//
//  LYPManageCleanToolProtocol.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/26.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYPManageCleanToolProtocol <NSObject>

-(void)didSelectToolRow:(NSIndexPath *)indexPath withUnSelect:(BOOL)unSelect;

@end
