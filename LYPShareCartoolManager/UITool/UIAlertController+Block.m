//
//  UIAlertController+Extension.m
//  EFBFileDownload
//
//  Created by 陈园 on 16/6/8.
//  Copyright © 2016年 陈园. All rights reserved.
//

#import "UIAlertController+Block.h"

@implementation UIAlertController (Block)

+ (UIAlertController *)alertNoticeWithTitle:(NSString *)title Message:(NSString *)message sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureblock) {
            sureblock();
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * _Nonnull action) {
        if (cancelblock) {
            cancelblock();
        }
    }]];
    return alertVC;

}

+ (UIAlertController *)alertWhetherWithTitle:(NSString *)title Message:(NSString *)message sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureblock) {
            sureblock();
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^ (UIAlertAction * _Nonnull action) {
        if (cancelblock) {
            cancelblock();
        }
    }]];
    return alertVC;
    
}

+(UIAlertController *)alertSureWithMessage:(NSString *)message sureblock:(void (^)(void))sureblock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureblock) {
            sureblock();
        }
    }]];
    return alertVC;
}

+ (UIAlertController *)alertViewWithTitle:(NSString *)title Message:(NSString *)message andSureButtonTitle:(NSString *)SureButtonTitle andCancelButtonTitle:(NSString *)CancelButtonTitle sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:SureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureblock) {
            sureblock();
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleDestructive handler:^ (UIAlertAction * _Nonnull action) {
        if (cancelblock) {
            cancelblock();
        }
    }]];
    return alertVC;
    
}

+(UIAlertController *)alertSureWithMessage:(NSString *)message AndTitle:(NSString *)title sureblock:(void (^)(void))sureblock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureblock) {
            sureblock();
        }
    }]];
    return alertVC;
}



@end
