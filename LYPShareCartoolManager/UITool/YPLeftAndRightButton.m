//
//  YPLeftAndRightButton.m
//  xydspace
//
//  Created by 赖永鹏 on 16/9/9.
//  Copyright © 2016年 LYP. All rights reserved.
//

#import "YPLeftAndRightButton.h"

@implementation YPLeftAndRightButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    if (self.currentImage == nil) return;
    
    // title
    self.titleLabel.x = 15;
    
    // image
    self.imageView.x = self.width - 13 - self.imageView.width;
}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
    [self setNeedsDisplay];
}

@end
