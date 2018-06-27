//
//  LYPOperationHeadView.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/17.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPOperationHeadView.h"
@interface LYPOperationHeadView()
@property (weak, nonatomic) IBOutlet UIImageView *placeImg;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImg;
@property (weak, nonatomic) IBOutlet UIImageView *holeImg;
@property (weak, nonatomic) IBOutlet UILabel *holeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *promptImg;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation LYPOperationHeadView

//是否重新开启
- (IBAction)resetClick:(id)sender {
    
    
}

+(LYPOperationHeadView *)awakeFormXib{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.resetButton.layer.masksToBounds = YES;
    self.resetButton.layer.borderColor = [UIColor redColor].CGColor;
    self.resetButton.layer.borderWidth = 1;
    self.resetButton.layer.cornerRadius = 5;
}

-(void)setDataListModel:(LYPDataListModel *)dataListModel{
    _dataListModel = dataListModel;
    LYPDevicesModel *deviceModel = dataListModel.devices[self.indePath.row];
    self.placeLabel.text = dataListModel.location;
    self.numberLabel.text = deviceModel.toiletId;
    self.holeLabel.text = deviceModel.seatId;
    self.typeLabel.text = deviceModel.toiletType;
}

-(void)setSuccessOpen:(BOOL)successOpen{
    _successOpen = successOpen;
    if (successOpen) {
        self.resetButton.hidden = YES;
        self.promptLabel.text = @"设备已开启";
    }else{
        self.resetButton.hidden = NO;
        self.promptLabel.text = @"设备开启失败";
    }
    
}

@end
