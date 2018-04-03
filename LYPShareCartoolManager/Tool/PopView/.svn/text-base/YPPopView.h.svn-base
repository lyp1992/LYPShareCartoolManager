//
//  YPPopView.h
//  遮罩框架
//
//  Created by 赖永鹏 on 16/2/27.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

// 写代理
@protocol YPPopViewDelegate <NSObject>

- (void)handlePopViewWithClick:(UIButton *)view;

@end

@interface YPPopView : UIView

// 背景颜色
@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;
@property (nonatomic, weak) id<YPPopViewDelegate> delegate;

// 对象的封装
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popViewWithContentView:(UIView *)contentView;

// 设置背景图片
// 设置contentView 的大小
- (void)showInRect:(CGRect)rect;

@end
