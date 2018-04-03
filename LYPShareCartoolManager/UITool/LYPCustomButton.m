//
//  LYPCustomButton.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPCustomButton.h"

@implementation LYPCustomButton

-(instancetype)initWithFrame:(CGRect)frame nomalImage:(NSString *)nomalImage highLightImage:(NSString *)highImage backgroundImage:(NSString *)backgrouImage backgroundHightImage:(NSString *)backHightImage title:(NSString *)title titleColor:(UIColor *)titleColor{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:backgrouImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:backHightImage] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:nomalImage] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}
@end
