//
//  LSKPrefix.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/10.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#ifndef LSKPrefix_h
#define LSKPrefix_h

//添加经常用到的第三方库
#import <AFNetworking.h>            //网络加载
#import <MJRefresh.h>               //刷新加载
#import <UIImageView+WebCache.h>    //图片加载
#import <SVProgressHUD.h>           //加载时的菊花圈
#import <SDCycleScrollView.h>       //轮播图

//经常用到的类
#import "ErrorCode.h"               //包含所有错误码
#import "NetURL.h"                  //包含所有的接口
#import "UIColor+Addition.h"        //颜色
#import "WDHRequest.h"              //整理所有请求
#import "APPSpecClass.h"            //转换上线测试的数据
#import "PublicToors.h"             //添加公共方法


//添加常用的宏
#define kScreenWidth       [UIScreen mainScreen].bounds.size.width      //适配宽度
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height     //适配高度

#define kScreenWidth1       ([UIScreen mainScreen].bounds.size.width / 375)     //适配宽度
#define kScreenHeight1      ([UIScreen mainScreen].bounds.size.height / 667)    //适配高度


#define kScreenWidth2       ([UIScreen mainScreen].bounds.size.width / 667)     //适配宽度
#define kScreenHeight2      ([UIScreen mainScreen].bounds.size.height / 375)    //适配高度


//常用的提示框
#define Alert_Show(str) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];[alert addAction:action];[self presentViewController:alert animated:YES completion:nil];


#define returnLogin     if ([IsLogin LoginRequest] == 0) {SYLoginPage *vc = [[SYLoginPage alloc]init];vc.type = 1;[self presentViewController:vc animated:YES completion:nil];return;}else{[IsLogin MyInfo];}





#endif /* LSKPrefix_h */
