//
//  LYPModifyLocationView.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/30.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPModifyLocationView.h"

@implementation LYPModifyLocationView

+(instancetype)aweakFromXib{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (IBAction)sureClick:(id)sender {
    [self.superview.superview removeFromSuperview];
}
- (IBAction)cancelButton:(id)sender {
    [self.superview.superview removeFromSuperview];
}
-(void)keyboardWillShow:(NSNotification*)notification
{
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    // 在这里调整UI位置
    CGPoint pt = [_sureButton convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    float txDistanceToBottom = SCREENHEIGHT - pt.y - _sureButton.frame.size.height;   // 距离底部多远
    if( txDistanceToBottom >= kbSize.height )  // 键盘不会覆盖
        return;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changePopViewFrame" object:nil userInfo:@{@"height":@(kbSize.height-txDistanceToBottom)}];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changePopViewFrame" object:nil userInfo:@{@"height":@(0)}];
}

#pragma mark --UITextFieldDelegate


@end
