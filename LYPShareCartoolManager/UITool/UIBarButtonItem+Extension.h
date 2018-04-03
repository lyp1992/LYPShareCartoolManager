//
//  UIBarButtonItem+Extension.h
//  百思不得姐
//
//  Created by 赖永鹏 on 16/3/19.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(instancetype)itemWithNomalImage:(NSString *)image selectImage:(NSString *)selecltImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage color:(UIColor *)color highColor:(UIColor *)highColor title:(NSString *)title;


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action color:(UIColor *)color highColor:(UIColor *)highColor title:(NSString *)title highTitle:(NSString *)highTitle;
@end
