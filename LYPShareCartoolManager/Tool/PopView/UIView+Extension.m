//
//  UIView+Extension.m
//  老赖微博
//
//  Created by 赖永鹏 on 15/9/23.
//  Copyright © 2015年 赖永鹏. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
-(void)setX:(CGFloat)x{

    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;

}
-(CGFloat)x{
    
    return self.frame.origin.x;//返回的是计算完了的值

}
-(void)setY:(CGFloat)y{
    
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
    
}
-(CGFloat)y{
    
    return self.frame.origin.y;//返回的是计算完了的值
    
}
-(void)setWidth:(CGFloat)width{
    
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
    
}
-(CGFloat)width{
    
    return self.frame.size.width;//返回的是计算完了的值
    
}
-(void)setHeight:(CGFloat)height{
    
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
    
}
-(CGFloat)height{
    
    return self.frame.size.height;//返回的是计算完了的值
    
}
- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;

}
-(CGFloat)centerX{

    return self.center.x;
    
}
-(void)setCenterY:(CGFloat)centerY{

    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;

}
-(CGFloat)centerY{

    return self.center.y;
}
@end
