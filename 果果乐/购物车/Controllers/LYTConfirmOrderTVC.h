//
//  LYTConfirmOrderTVC.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTConfirmOrderTVC : UIViewController
@property(nonatomic,retain)NSArray *goodsArr;
@property(nonatomic,assign)int type;

@property(nonatomic,copy)NSString *sendJiFen;              //赠送积分
@property(nonatomic,copy)NSString *yunfei;              //运费
@property(nonatomic,copy)NSString *goodsAllPrice;       //商品总金额
@end
