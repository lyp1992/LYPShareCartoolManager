//
//  LYPLocationView.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/29.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPLocationView.h"
#import "LYPDevicesModel.h"

@implementation LYPLocationView

+(instancetype)aweakFromXib{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

-(void)setModel:(id)model{
    _model = model;
    if ([model isKindOfClass:[LYPDevicesModel class]]) {
        LYPDevicesModel *listModel = model;
        self.buildLabel.text = listModel.build;
        self.floorLabel.text = [NSString stringWithFormat:@"%d",listModel.floor];
        self.toilteLabel.text = listModel.toiletType;
        self.toiletIdLabel.text = listModel.seatId;
    }
}
- (IBAction)clickButton:(id)sender {
    [self.superview.superview removeFromSuperview];
}

@end
