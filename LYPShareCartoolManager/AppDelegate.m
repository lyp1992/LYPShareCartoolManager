//
//  AppDelegate.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/8.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LYPLoginVC.h"
#import "LYPCleanMainVC.h"
#import "LYPManagerVC.h"
#import "XGPush.h"
#import "LYPCleanHomePageVC.h"

@interface AppDelegate ()<XGPushDelegate>

@end

@implementation AppDelegate
#pragma mark - XGPushDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);

    
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"LYPLoginVC" bundle:nil];
//    LYPLoginVC *loginVC = [board instantiateViewControllerWithIdentifier:@"LYPLoginVC"];
//     self.window.rootViewController = loginVC;
    LYPCleanHomePageVC *homeVC = [[LYPCleanHomePageVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = nav;


//    LYPManagerVC *managerVC = [[LYPManagerVC alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:managerVC];
//    self.window.rootViewController = nav;
    
    [ self.window makeKeyAndVisible];
    
    
    //    注册远程通知
    [self registRemoteNotification];
    [[XGPush defaultManager] setEnableDebug:YES];
    [[XGPush defaultManager]startXGWithAppID:2200280203 appKey:@"I1M3I83GQB4U" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    return YES;
}
//     此方法现在不是必须的，SDK内部已经在内部处理
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[XGPushTokenManager defaultTokenManager] registerDeviceToken:deviceToken]; // 此方法可以不需要调用，SDK已经在内部处理
    NSLog(@"[XGDemo] device token is %@", [[XGPushTokenManager defaultTokenManager] deviceTokenString]);
    //获取token，保存到本地
    [LYPUserSingle shareUserSingle].deviceToken = [[XGPushTokenManager defaultTokenManager] deviceTokenString];
    NSLog(@"%@",[LYPUserSingle shareUserSingle].deviceToken);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}
/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"[XGDemo] receive Notification");
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
}

//收到本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    NSDictionary *apsDic = notification.userInfo[@"aps"];
    
    UIAlertController *alertVC = [UIAlertController alertSureWithMessage:apsDic[@"alert"] sureblock:^{
        
    }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];

}

/**
 收到静默推送的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);

    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)registRemoteNotification{
    
#ifdef __IPHONE_8_0
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    }
    
#else
    
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    
#endif
    
}


// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"[XGDemo] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSDictionary *apsDic = notification.request.content.userInfo[@"aps"];
    UIAlertController *alertVC = [UIAlertController alertSureWithMessage:apsDic[@"alert"] sureblock:^{
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
//    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

#endif
@end
