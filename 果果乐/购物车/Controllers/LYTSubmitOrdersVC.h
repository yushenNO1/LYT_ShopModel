//
//  LYTSubmitOrdersVC.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTSubmitOrdersVC : UIViewController
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *orderPay;
@property(nonatomic,copy)NSString *heji;
@property(nonatomic,copy)NSString *order_id;

@property(nonatomic,assign)int typecode;
@end
