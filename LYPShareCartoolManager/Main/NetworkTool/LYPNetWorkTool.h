//
//  LYPNetWorkTool.h
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/9.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id responseData, NSInteger responseCode);
typedef void(^failureBlock)(id responseData, NSInteger responseCode);

@interface LYPNetWorkTool : NSObject

//用户登录
-(void)userLoginWithUserDic:(NSDictionary *)parames Success:(successBlock)success failue:(failureBlock)failure;

//用户重置密码
-(void)resetPasswordWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;
//获取手机验证码
-(void)getVerificationCodeWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;

//获取设备列表
-(void)getEquipmentListWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;

//设备开放料锁
-(void)openDeviceWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;
//开取料锁
-(void)openDevice2WithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;

//设备换纸
-(void)openEquipmentInPaperWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;

//获取纸品列表
-(void)getPaperListWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;

//换电池记录
-(void)inBatteryRecordWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;
//换纸记录

-(void)InPaperRecordsWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure;
@end
