//
//  UIAlertController+Extension.h
//  EFBFileDownload
//
//  Created by 陈园 on 16/6/8.
//  Copyright © 2016年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Block)

/**
 *  提示确认
 *
 *  @param title       标题
 *  @param sureblock   确认操作
 *  @param cancelblock 取消操作
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertNoticeWithTitle:(NSString *)title Message:(NSString *)message sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock;
/**
 *  提示是否
 *
 *  @param title       标题
 *  @param sureblock   是
 *  @param cancelblock 否
 *
 *  @return UIAlertController
 */
+ (UIAlertController *)alertWhetherWithTitle:(NSString *)title Message:(NSString *)message sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock;

/**
 *  提示确认
 *
 *  @param message   标题
 *  @param sureblock 确认操作
 *
 *  @return UIAlertController
 */
+(UIAlertController *)alertSureWithMessage:(NSString *)message sureblock:(void (^)(void))sureblock;

/**
 自定义button名称

 @param title             标题
 @param message           内容
 @param SureButtonTitle   按钮标题
 @param CancelButtonTitle 按钮标题
 @param sureblock         确认操作
 @param cancelblock       取消操作

 @return UIAlertController
 */
+ (UIAlertController *)alertViewWithTitle:(NSString *)title Message:(NSString *)message andSureButtonTitle:(NSString *)SureButtonTitle andCancelButtonTitle:(NSString *)CancelButtonTitle sureblock:(void (^)(void))sureblock cancelblock:(void (^)(void))cancelblock;

/**
 *  提示确认
 *
 *  @param message   标题
 *  @param title     标题头
 *  @param sureblock 确认操作
 *
 *  @return UIAlertController
 */
+(UIAlertController *)alertSureWithMessage:(NSString *)message AndTitle:(NSString *)title sureblock:(void (^)(void))sureblock;

@end
