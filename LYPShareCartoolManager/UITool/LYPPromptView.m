//
//  LYPPromptView.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPPromptView.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LYPPromptView

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        imageV.image = [UIImage imageNamed:imageName];
        [self addSubview:imageV];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame LabelString:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = string;
        [self addSubview:label];
    }
    return  self;
}

@end
