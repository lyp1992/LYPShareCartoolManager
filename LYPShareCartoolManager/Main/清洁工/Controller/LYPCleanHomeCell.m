//
//  LYPCleanHomeCell.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPCleanHomeCell.h"

@interface LYPCleanHomeCell()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *label;

@end

@implementation LYPCleanHomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label];
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(self.width - 5, 0, 5, 5);
    self.label.frame = CGRectMake(0, 0, self.width, self.height);
}
//-(void)setTitleStr:(NSString *)titleStr{
//    _titleStr = titleStr;
//    self.label.text = titleStr;
//}

-(void)setBuildListModel:(LYPBuildListModel *)buildListModel{
    _buildListModel = buildListModel;
   
    self.label.text = [NSString stringWithFormat:@"大楼:%@  楼层：%d",buildListModel.build, buildListModel.floor];
}


-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.backgroundColor = [UIColor redColor];
        _imageV.layer.masksToBounds = YES;
        _imageV.layer.cornerRadius = 2;
    }
    return _imageV;
}

@end
