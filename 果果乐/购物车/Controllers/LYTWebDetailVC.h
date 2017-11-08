//
//  LYTWebDetailVC.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WebViewJavascriptBridge.h"
@interface LYTWebDetailVC : UIViewController
//@property (nonnull,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic,strong)UIWebView *webView1;
@property (nonatomic, copy) NSString * picName;
@property (nonatomic, copy) NSString * contentStr;

@property (nonatomic, copy) NSString * str;
@property (nonatomic, copy) NSString * goods_id;


@end
