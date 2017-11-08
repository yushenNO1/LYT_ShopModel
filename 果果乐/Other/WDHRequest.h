//
//  WDHRequest.h
//  LSK
//
//  Created by 云盛科技 on 2017/3/1.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDHRequest : NSObject

/*
 *  用于所有GET请求
 */
+(void)requestAllListWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock;


/*
 *  用于所有POST请求
 */
+(void)requestTypePostWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock;

/*
 *  用于请求支付宝订单号
 */
+(void)requestZFBOrderWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block WithError:(void(^)(NSString *errorStr))errorBlock;

/*
 *  用于请求微信订单号
 */
+(void)requestWXOrderWith:(NSString *)urlStr completeWithBlock:(void(^)(NSDictionary *responseObject))block;



@end
