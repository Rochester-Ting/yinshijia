//
//  AppDelegate.m
//  菜谱
//
//  Created by 丁瑞瑞 on 9/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "AppDelegate.h"
#import "RRTabBarViewController.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "RRSqlite.h"
#import "EaseMob.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    环信
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"dingrui123#rrchat" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
//    打开数据库
    [[RRSqlite shareRRSqlite] openNoticeDB:@"caipu.db"];
    
    
//    设置分享的appKey
    [UMSocialData setAppKey:@"56f9347ae0f55a19aa001109"];
//    打开sso授权
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    添加微信
    [UMSocialWechatHandler setWXAppId:@"wx82fcee00c5e507de" appSecret:@"baea707463510cfdfd714adaaa92564a" url:@"http://www.umeng.com/social"];
//    创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    设置根控制器
    self.window.rootViewController = [[RRTabBarViewController alloc] init];
//    显示window
    [self.window makeKeyAndVisible];
    return YES;
}
//新浪SSO回调函数
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
