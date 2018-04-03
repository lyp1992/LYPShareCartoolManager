//
//  LYPLocationView.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/29.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPLocationView : UIView
@property (weak, nonatomic) IBOutlet UILabel *buildLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *toilteLabel;
@property (weak, nonatomic) IBOutlet UILabel *toiletIdLabel;

+(instancetype)aweakFromXib;

@property (nonatomic, strong) id model;

@end
