//
//  WDHRequest.m
//  LSK
//
//  Created by 云盛科技 on 2017/3/1.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "WDHRequest.h"
#import "LoginVC.h"
#import "MainVC.h"
@implementation WDHRequest
+(void)requestAllListWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    if ([urlStr rangeOfString:@"/App/"].location != NSNotFound) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if ([error code] == -1009) {

        } else if ([error code] == -1001) {
            
        } else{
            if([[error localizedDescription] rangeOfString:@"("].location !=NSNotFound){
                NSArray *arr = [[error localizedDescription] componentsSeparatedByString:@"("];
                NSArray *arr1 = [arr[1] componentsSeparatedByString:@")"];
                if ([arr1[0] integerValue] == 401) {
                    errorBlock(@"1");
                } else if ([arr1[0] integerValue] == 403){
                    errorBlock(@"1");
                }
            }
        }
        NSLog(@"登录请求失败%@",error);
    }];
}
+(void)requestTypePostWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        errorBlock([NSString stringWithFormat:@"%@",error]);
        if ([error code] == -1009) {
            
        } else if ([error code] == -1001) {
            
        } else{
            if([[error localizedDescription] rangeOfString:@"("].location !=NSNotFound){
                NSArray *arr = [[error localizedDescription] componentsSeparatedByString:@"("];
                NSArray *arr1 = [arr[1] componentsSeparatedByString:@")"];
                if ([arr1[0] integerValue] == 401) {
                    errorBlock(@"1");
                } else if ([arr1[0] integerValue] == 403){
                    errorBlock(@"1");
                }
            }
        }
        NSLog(@"登录请求失败%@",error);
    }];
    
    
    
    
}

+(void)requestZFBOrderWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"支付宝------成功-------%@",responseObject);
        block(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"支付宝------失败-------%@",error);
    }];

}

+(void)requestWXOrderWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"微信------成功-------%@",responseObject);
        block(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"微信------失败-------%@",error);
    }];
}



@end
