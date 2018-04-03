//
//  YPPopView.m
//  遮罩框架
//
//  Created by 赖永鹏 on 16/2/27.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import "YPPopView.h"
#import "UIView+Extension.h"

@interface YPPopView ()

@property (nonatomic ,strong) UIView *contentView;
@property (nonatomic ,strong) UIScrollView *slideScrollView; // 弹出键盘底部滑动
@property (nonatomic ,strong) UIView *containerView;

@end

@implementation YPPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *slideScrollView = [[UIScrollView alloc]init];
        self.slideScrollView = slideScrollView;
        [self addSubview:self.slideScrollView];
        
        UIView *containerView = [[UIView alloc]init];
        containerView.backgroundColor = [UIColor grayColor];
        self.containerView = containerView;
        [self addSubview:self.containerView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.slideScrollView.frame = self.bounds;
}

// 封装对象
- (instancetype)initWithContentView:(UIView *)contentView {
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView {
    return [[self alloc] initWithContentView:contentView];
}

// 设置背景颜色
- (void)setDimBackground:(BOOL)dimBackground {
    _dimBackground = dimBackground;
    if (!dimBackground) {
        [self.slideScrollView setBackgroundColor:[UIColor blackColor]];
    } else {
//        [self.slideScrollView setBackgroundColor:RGBACOLOR(23, 46, 46, 1)];
        [self.slideScrollView setBackgroundColor:RGBACOLOR(0, 0, 0, 1)];
        
        self.slideScrollView.alpha = 0.3;
    }
}

- (void)showInRect:(CGRect)rect {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    self.frame = win.bounds;
    [win addSubview:self];
    
    // 设置容器
    self.containerView.frame = rect;
     self.containerView.layer.cornerRadius = 10.0f;
    self.contentView.layer.cornerRadius = 10.0f;
    [self.containerView addSubview:self.contentView];
    
    self.contentView.height = rect.size.height;
    self.contentView.width = rect.size.width;
    self.contentView.x = 0;
    self.contentView.y = 0;
}

-(void)closeButton:(UIButton *)sender{
    
    
}

@end
