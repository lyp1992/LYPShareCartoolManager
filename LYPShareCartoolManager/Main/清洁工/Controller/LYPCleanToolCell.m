//
//  LYPCleanToolCell.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPCleanToolCell.h"
@interface LYPCleanToolCell ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *label;

@end

@implementation LYPCleanToolCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.label];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.selectBtn.frame = CGRectMake(5, (self.frame.size.height - 25)/2, 25, 25);
    self.label.frame = CGRectMake(CGRectGetMaxX(self.selectBtn.frame)+5, 0, self.frame.size.width -CGRectGetMaxX(self.selectBtn.frame) , self.frame.size.height);
    
}
-(void)setToolModel:(LYPToolModel *)toolModel
{
    _toolModel = toolModel;
    if (toolModel.isSelect) {
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
    }
    self.label.text = toolModel.name;
}

-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"ic_selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:13];
    }
    return _label;
}

-(void)selectButton:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(cleanToolView:selectButton: withIndexPath:)]) {
        [self.delegate cleanToolView:self selectButton:sender withIndexPath:self.indexPath];
    }
}

@end
