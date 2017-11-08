//
//  AppDelegate.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "MainVC.h"
#import <UMSocialCore/UMSocialCore.h>

#import <AlipaySDK/AlipaySDK.h>
#import "BaseTabBarController.h"

@interface AppDelegate ()<UIAlertViewDelegate>
@property(nonatomic,copy)NSString *downLoadUrl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];

    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"595c85bc75ca3570b80018e1"];
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106192945"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106192945"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2702912421"  appSecret:@"1685e17ba280961b89c22c7eef02cd74" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx0d07212345d8349b" appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx0d07212345d8349b" appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];

    [self initializeTheNotificationCenter];
    //更新
    [self JudgeNetworkUpdateApp];
    
    
    BaseTabBarController * baseVC = [[BaseTabBarController alloc] init];
    self.window.rootViewController = baseVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}




- (void)JudgeNetworkUpdateApp {
    NSLog(@"什么结果");
    //当前运行程序的版本信息，可以在 mainBundle 里面获取：
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"https://m.caiyun156.com/update/ipa"];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    NSData *response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([[response class] isEqual:[NSNull class]]) {

    }else if (response==nil){

    }else{
        NSDictionary *dict=  [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        if ([[dict class] isEqual:[NSNull class]]) {
            
        }else if (dict==nil){
            
        }else{
            NSString *res= [dict objectForKey:@"VERSION"];
            NSLog(@"什么结果---%@-----data---%@",dict,response);
            if(![nowVersion isEqualToString:res])
            {
                _downLoadUrl = dict[@"PLIST_PATH"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新" message:dict[@"NOTE"] delegate:self cancelButtonTitle:@"更新" otherButtonTitles: nil];
                [alert show];
                
            }
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",_downLoadUrl]];
    [[UIApplication sharedApplication] openURL:url];
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enterActive" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [[UMSocialManager defaultManager] handleOpenURL:url];
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        // 其他如支付等SDK的回调
        return result;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            // 其他如支付等SDK的回调
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                /*这里面不走*/
            }];
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"resuaaa支付宝lt = %@",resultDic);
                if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlipaySDKSuccsess" object:resultDic];
                }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlipaySDKdissMiss" object:resultDic];
                }else{
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AlipaySDKSuccsess" object:resultDic];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AlipaySDKdissMiss" object:resultDic];
                }
            }];
            return YES;
            
        }
        
    }

    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        // 其他如支付等SDK的回调
        return result;
        
    }
    return YES;
    
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"___"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark    注册一些通知,添加观察者 在APPDelegate中添加通知和以下方法,在需要全屏的界面强制全屏,需要勾选Targets->General->Deployment Info->Device Orientation->Landscape Left & Landscape Right

- (void)initializeTheNotificationCenter
{
    //在进入需要全屏的界面里面发送需要全屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:@"startFullScreen" object:nil];//进入全屏
    
    //在退出需要全屏的界面里面发送退出全屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:@"endFullScreen" object:nil];//退出全屏
}

#pragma mark 进入全屏
-(void)startFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}

#pragma mark    退出横屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    //强制归正：
    if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
        SEL selector =     NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}

#pragma mark    禁止横屏
- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}


@end
