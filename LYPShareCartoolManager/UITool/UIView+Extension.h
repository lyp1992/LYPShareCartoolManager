//
//  UIView+Extension.h
//  百思不得姐
//
//  Created by 赖永鹏 on 16/3/19.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (BOOL)isShowingOnKeyWindow;

+(instancetype)viewFromXib;

@end
