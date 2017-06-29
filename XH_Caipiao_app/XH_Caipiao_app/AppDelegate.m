//
//  AppDelegate.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarContrllerViewController.h"
#import "AdvertiseView.h"
#import "gaode_Location.h"
#import "UMessage.h"

#import "Zixun_Web.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bmob registerWithAppKey:Bobm_Application_ID];
   
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    NSString *myurl = [us objectForKey:@"myurl"];
    [us synchronize];
    if (myurl.length > 0) {
        Zixun_Web *vc = [[Zixun_Web alloc]init];
      
            vc.url = myurl;


        
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];

        //查找GameScore表
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Caipiao_app_jump"];
        //查找GameScore表里面id为0c6db13c的数据
        [bquery getObjectInBackgroundWithId:@"4MkY0003" block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                //表里有id为0c6db13c的数据
                if (object) {
                    //得到playerName和cheatMode
                    NSString *ifjump = [object objectForKey:@"isshowwap"];
                    NSString *myurl = [object objectForKey:@"myurl"];
                    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                    [us setObject:myurl forKey:@"myurl"];
                    [us synchronize];
                    if([ifjump isEqual:@"1"]){

                            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                            [us setObject:myurl forKey:@"myurl"];
                            [us synchronize];
         
                        
                    }else{
                        
                        
                        
                    }
                }
            }
        }];


    }else{
        //查找GameScore表
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Caipiao_app_jump"];
        //查找GameScore表里面id为0c6db13c的数据
        [bquery getObjectInBackgroundWithId:@"4MkY0003" block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                //表里有id为0c6db13c的数据
                if (object) {
                    //得到playerName和cheatMode
                    NSString *ifjump = [object objectForKey:@"isshowwap"];
                    NSString *myurl = [object objectForKey:@"myurl"];
                    if([ifjump isEqual:@"1"]){
                        
                        Zixun_Web *vc = [[Zixun_Web alloc]init];
                        if (myurl.length > 0) {
                            vc.url = myurl;
                            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                            [us setObject:myurl forKey:@"myurl"];
                            [us synchronize];
                            
                        }
                        
                        
                        
                        UIWindow *w2 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        w2.backgroundColor = [UIColor yellowColor];
                        
                        w2.rootViewController =vc;
                        
                        [w2 makeKeyAndVisible];
                        
                        [self.window addSubview:w2];
                        
                        
                    }else{
                        
                        
                        
                    }
                }
            }
        }];
        self.window = [[UIWindow alloc] init];
        self.window.frame = [UIScreen mainScreen].bounds;
        
        
        if ([NSUSER_OBJECTFORRKEY(QDWSaveUserId) length] > 0) {
            
            [QDWUser shareManager].Userid      = NSUSER_OBJECTFORRKEY(QDWSaveUserId);
            [QDWUser shareManager].Username = [QDWLoginManager shareManager].UserAcount.name;
            
        }else{
            
            [QDWUser shareManager].Userid       = nil;
            
        }
        TabBarContrllerViewController *TaB = [[TabBarContrllerViewController alloc]init];
        
        self.window.rootViewController = TaB;

 
    }
    
    
    
    
      [AMapServices sharedServices].apiKey = Gaode_appkey;
    [[gaode_Location shareInstance]getLocation:^(CLLocation *location, AMapLocationReGeocode *code) {
        [QDWUser shareManager].latitude = location.coordinate.latitude;
        [QDWUser shareManager].longitude = location.coordinate.longitude;
    }];
    
   #pragma mark -- 友盟
    [UMessage startWithAppkey:Umeng_AppKey launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];

    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];

    [UMessage setLogEnabled:YES];
    
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
