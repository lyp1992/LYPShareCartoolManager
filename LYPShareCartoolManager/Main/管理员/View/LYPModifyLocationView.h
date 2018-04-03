//
//  LYPModifyLocationView.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/30.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPModifyLocationView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

+(instancetype)aweakFromXib;

@end
