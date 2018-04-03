//
//  LYPNetWorkTool.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/9.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPNetWorkTool.h"

@implementation LYPNetWorkTool
-(void)userLoginWithUserDic:(NSDictionary *)parames Success:(successBlock)success failue:(failureBlock)failure{
    
    AFHTTPSessionManager *mannger = [AFHTTPSessionManager manager];
    mannger.requestSerializer = [AFJSONRequestSerializer serializer];
    [mannger.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    
    [mannger POST:loginUrl parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        {"data":{"token":"f56e58020315728d"},"error":{"code":0,"msg":""}}
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
    
}
-(void)getVerificationCodeWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *mannger = [AFHTTPSessionManager manager];
    mannger.requestSerializer = [AFJSONRequestSerializer serializer];
    [mannger.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    NSString *url = [NSString stringWithFormat:@"%@/getcode?mobile=%@&ctype=%@",getCodeUrl,parames[@"mobile"],parames[@"ctype"]];
    [mannger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}
-(void)resetPasswordWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *mannger = [AFHTTPSessionManager manager];
    mannger.requestSerializer = [AFJSONRequestSerializer serializer];
    [mannger.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [mannger.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    [mannger POST:resetPassWordUrl parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        {"data":null,"error":{"code":0,"msg":""}}
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}

-(void)getEquipmentListWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //    本地登录成功之后的token，appkey
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@",deviceListUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}

-(void)openDeviceWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@",openLockUrl];
    [manager POST:url parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];

}

-(void)openEquipmentInPaperWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@",changePaperUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}
-(void)getPaperListWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@",getPapersUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}

-(void)inBatteryRecordWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    [manager POST:BatteryRecordUrl parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
    
}

-(void)InPaperRecordsWithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
   
    [manager POST:PaperRecordUrl parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error,-1);
    }];
}

-(void)openDevice2WithDic:(NSDictionary *)parames success:(successBlock)success failure:(failureBlock)failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKey forHTTPHeaderField:@"appkey"];
    [manager.requestSerializer setValue:[LYPSavePList readTokenPlist] forHTTPHeaderField:@"token"];
    
    [manager POST:openLockUrl2 parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
    }];
}

@end
