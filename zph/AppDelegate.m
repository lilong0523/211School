//
//  AppDelegate.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "LoginController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <Hyphenate/Hyphenate.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>



@interface AppDelegate ()<JPUSHRegisterDelegate,EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:EMAPPKEY];
    options.apnsCertName = nil;
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    

    //年后
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAPPKEY];
    
    [self configUSharePlatforms];
    [self configJpush];
    [self registerJPushStatusNotification];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKEY
                          channel:@""
                 apsForProduction:0 //0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应用
            advertisingIdentifier:nil];
    //sdimage 加载https图片配置
    [[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MainController *homePage = [[MainController alloc] init];
    //        UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:homePage];
    [self getArea];
    [self getIndustryType];
    
    LoginController *loginView = [[LoginController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:loginView];
    mainNav.navigationBarHidden = YES;
    // 实时通话单例与工程根控制器关联(很重要)
    [[DemoCallManager sharedManager] setMainController:homePage];
    self.window.rootViewController = mainNav;
    [self.window makeKeyAndVisible];
    return YES;
}


/**
 设置友盟初始化
 */
- (void)configUSharePlatforms
{
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIAPPKEY appSecret:WEISECRET redirectURL:@"http://mobile.umeng.com/social"];
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPKEY  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
}


/**
 设置极光推送初始化
 */
- (void)configJpush{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
}


/**
 极光推送的消息中心设置
 */
- (void)registerJPushStatusNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkIsConnecting:)
                          name:kJPFNetworkIsConnectingNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(receivePushMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    
}

// notification from JPush
- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"Event - networkDidSetup");
}

// notification from JPush
- (void)networkIsConnecting:(NSNotification *)notification {
    NSLog(@"Event - networkIsConnecting");
}

// notification from JPush
- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"Event - networkDidClose");
}

// notification from JPush
- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"Event - networkDidRegister");
}

// notification from JPush
- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"Event - networkDidLogin");
    
    self.RegistrationID = [JPUSHService registrationID];
    
}

//接收自定义消息
- (void)receivePushMessage:(NSNotification *)notification {
    NSLog(@"Event - receivePushMessage");
    
    NSDictionary *info = notification.userInfo;
    if (info) {
        
    }
}

/**
 获取省市信息
 */
- (void)getArea{
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:@"areaArry"] == nil) {
        //获取文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area_code_json2"ofType:@"js"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePath];
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *area = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSMutableDictionary *bbq in arry) {
            if ([[bbq objectForKey:@"parent_id"] isEqualToString:@"0000"]) {
                NSMutableArray *cityArry = [[NSMutableArray alloc] initWithCapacity:0];
                [bbq setObject:cityArry forKey:@"city"];
                [area addObject:bbq];
            }
            else{
                if ([[bbq objectForKey:@"parent_id"] isEqualToString:[[area lastObject] objectForKey:@"id"]]) {
                    NSMutableArray *districtArry = [[NSMutableArray alloc] initWithCapacity:0];
                    [bbq setObject:districtArry forKey:@"district"];
                    [[[area lastObject] objectForKey:@"city"] addObject:bbq];
                    
                }
                else{
                    [[[[[area lastObject] objectForKey:@"city"] lastObject] objectForKey:@"district"] addObject:bbq];
                }
            }
        }
        [defaults setObject: area forKey:@"areaArry"];
        [defaults synchronize];
    }
    
}


/**
 获得行业类别
 */
- (void)getIndustryType{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:@"industryArry"] == nil) {
        //获取文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"position_json2"ofType:@"js"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePath];
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *area = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSMutableDictionary *bbq in arry) {
            if ([[bbq objectForKey:@"fid"] isEqualToString:@"0000"]) {
                NSMutableArray *cityArry = [[NSMutableArray alloc] initWithCapacity:0];
                [bbq setObject:cityArry forKey:@"industry"];
                [area addObject:bbq];
            }
            else{
                if ([[bbq objectForKey:@"fid"] isEqualToString:[[area lastObject] objectForKey:@"id"]]) {
                    NSMutableArray *districtArry = [[NSMutableArray alloc] initWithCapacity:0];
                    [bbq setObject:districtArry forKey:@"Occupation"];
                    [[[area lastObject] objectForKey:@"industry"] addObject:bbq];
                    
                }
                else{
                    [[[[[area lastObject] objectForKey:@"industry"] lastObject] objectForKey:@"Occupation"] addObject:bbq];
                }
            }
        }
        [defaults setObject: area forKey:@"industryArry"];
        [defaults synchronize];
    }
    
}


- (void)userAccountDidLoginFromOtherDevice{
    NSLog(@"被踢了被踢了");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号已在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"好的",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        LoginController *loginView = [[LoginController alloc] init];
        UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:loginView];
        mainNav.navigationBarHidden = YES;
       
        self.window.rootViewController = mainNav;
        [self.window makeKeyAndVisible];
    }];
    [alert addAction:alertAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - JPUSH相关回调

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


// iOS 10 Support

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//禁用第第三方输入法
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return YES;
}


- (NSString *)siteid{
    if (_siteid == nil) {
        _siteid = @"28";
    }
    return _siteid;
}

- (UserModel *)userModel{
    if (_userModel == nil) {
        _userModel = [[UserModel alloc] init];
    }
    return _userModel;
}

@end
