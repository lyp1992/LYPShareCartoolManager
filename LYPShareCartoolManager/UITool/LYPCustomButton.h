//
//  LYPCustomButton.h
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPCustomButton : UIButton

-(instancetype)initWithFrame:(CGRect)frame nomalImage:(NSString *)nomalImage highLightImage:(NSString *)highImage backgroundImage:(NSString *)backgrouImage backgroundHightImage:(NSString *)backHightImage title:(NSString *)title titleColor:(UIColor *)titleColor;

@end
