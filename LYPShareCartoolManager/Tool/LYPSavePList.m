//
//  LYPSavePList.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/1.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPSavePList.h"
#import "StringEXtension.h"

#define UserInfoPlist @"/userInfo.plist"
#define TokenPlist @"/Token.plist"

@implementation LYPSavePList

+(void)saveTokenPlistWith:(NSString *)token{
    
    if ([StringEXtension isBlankString:token]) {
        return;
    }
    [token writeToFile:[LYPSavePList createFileManagerPath:TokenPlist] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}
+(void)savePassWAndUser:(NSDictionary *)dic{

    [dic writeToFile:[LYPSavePList createFileManagerPath:UserInfoPlist] atomically:YES];
}

+(NSString *)readTokenPlist{
    
    NSString *token = [NSString stringWithContentsOfFile:[LYPSavePList createFileManagerPath:TokenPlist] encoding:NSUTF8StringEncoding error:nil];
    return token;
}
+(NSDictionary *)readUserInfo{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[LYPSavePList createFileManagerPath:UserInfoPlist]];
    return dic;
}


+(NSString *)createFileManagerPath:(NSString *)pathComponent{
    
//    获取本地路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:pathComponent];
    
    return filePath;
}

@end
