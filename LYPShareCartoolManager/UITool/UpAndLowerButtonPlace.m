//
//  UpAndLowerButtonPlace.m
//  
//
//  Created by 赖永鹏 on 16/5/6.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import "UpAndLowerButtonPlace.h"

@implementation UpAndLowerButtonPlace

-(void)setup{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
//调整图片
    
    self.imageView.x = 0;
    self.imageView.y = 10 *ScreenFitHeight;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.height;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
// 调整文字
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
