//
//  LYPPersonTableViewCell.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPPersonTableViewCell.h"

@implementation LYPPersonTableViewCell

+(LYPPersonTableViewCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"PersonCell";
    LYPPersonTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[LYPPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addSubview:self.menuImageView];
        [self addSubview:self.menuLabel];
        [self addSubview:self.eventlabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.menuImageView.frame = CGRectMake(10, (height - 25)/2, 30, 30);
    self.menuLabel.frame = CGRectMake(CGRectGetMaxX(self.menuImageView.frame), 0, 80, height);
    self.eventlabel.frame = CGRectMake(CGRectGetMaxX(self.menuImageView.frame), 0, width - CGRectGetMaxX(self.menuLabel.frame), height);
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.menuImageView.image = [UIImage imageNamed:dataDic[@"image"]];
    self.menuLabel.text = dataDic[@"title"];
    
}
-(UILabel *)menuLabel{
    if(!_menuLabel){
        _menuLabel = [[UILabel alloc]init];
    }
    return _menuLabel;
}
-(UIImageView *)menuImageView{
    if(!_menuImageView){
        _menuImageView = [[UIImageView alloc]init];
    }
    return _menuImageView;
}
-(UILabel *)eventlabel{
    if(!_eventlabel){
        _eventlabel =[[UILabel alloc]init];
        
    }
    return _eventlabel;
}
@end
