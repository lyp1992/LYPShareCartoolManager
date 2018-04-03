//
//  UIBarButtonItem+Extension.m
//  百思不得姐
//
//  Created by 赖永鹏 on 16/3/19.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)itemWithNomalImage:(NSString *)image selectImage:(NSString *)selecltImage target:(id)target action:(SEL)action{

    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selecltImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    button.size = button.currentBackgroundImage.size;

    return [[self alloc]initWithCustomView:button];
}


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage color:(UIColor *)color highColor:(UIColor *)highColor title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置文字颜色
    // 设置文字颜色
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    // 往左边偏移一些
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    // 设置尺寸
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [btn sizeToFit];
   
    
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
}

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param color     颜色
 *  @param highColor 高亮显示颜色
 *  @param title     标题
 *  @param highTitle 高亮显示颜色
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action color:(UIColor *)color highColor:(UIColor *)highColor title:(NSString *)title highTitle:(NSString *)highTitle
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:highTitle forState:UIControlStateHighlighted];
    // 设置文字颜色
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    // 设置尺寸
    [btn sizeToFit];
    
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
}

@end
