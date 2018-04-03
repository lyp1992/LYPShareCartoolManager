//
//  LYPPersonHeadView.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPPersonHeadView.h"

@implementation LYPPersonHeadView

+(LYPPersonHeadView *)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"headCell";
    LYPPersonHeadView *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[LYPPersonHeadView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.headImageV];
        [self.contentView addSubview:self.iphoneLabel];
        [self.contentView addSubview:self.memberButton];
        [self.contentView addSubview:self.creditButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat maginW = 10;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.headImageV.frame = CGRectMake(maginW, 5+(height-60)/2, 60, 60);
    
    self.iphoneLabel.frame = CGRectMake(maginW+CGRectGetMaxX(self.headImageV.frame), CGRectGetMinY(self.headImageV.frame), width -(CGRectGetMaxX(self.headImageV.frame)+maginW), 20);
    self.memberButton.frame = CGRectMake(CGRectGetMaxX(self.headImageV.frame) +maginW, CGRectGetMaxY(self.headImageV.frame)-30, 50, 25);
    self.creditButton.frame = CGRectMake(CGRectGetMaxX(self.memberButton.frame)+5, CGRectGetMaxY(self.headImageV.frame)-30, 80, 25);
//    NSDictionary *dic = @{@"mobile":self.phoneTextF.text,@"password":passW,@"deviceToken":[LYPUserSingle shareUserSingle].deviceToken,@"ios":@(1)};
   NSDictionary *dic = [LYPSavePList readUserInfo];
    self.iphoneLabel.text = dic[@"mobile"];
    
}

-(UIImageView *)headImageV{
    if(!_headImageV){
        _headImageV = [[UIImageView alloc]init];
        _headImageV.image = [UIImage imageNamed:@"avatar_default"];
    }
    return _headImageV;
}
-(UILabel *)iphoneLabel{
    if(!_iphoneLabel){
        _iphoneLabel = [[UILabel alloc]init];
        _iphoneLabel.text = @"152*****9251";
        _iphoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _iphoneLabel;
}
-(UIButton *)memberButton{
    if(!_memberButton){
        _memberButton = [[UIButton alloc]init];
        [_memberButton setTitle:@"会员" forState:UIControlStateNormal];
        [_memberButton setBackgroundImage:[UIImage imageNamed:@"pager_bg"] forState:UIControlStateNormal];
    }
    return _memberButton;
}
-(UIButton *)creditButton{
    if(!_creditButton){
        _creditButton = [[UIButton alloc]init];
        [_creditButton setTitle:@"信用积分" forState:UIControlStateNormal];
        [_creditButton setBackgroundImage:[UIImage imageNamed:@"credit_bg"] forState:UIControlStateNormal];
        [_creditButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _creditButton;
}
@end
