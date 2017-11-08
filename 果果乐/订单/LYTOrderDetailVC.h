//
//  LYTOrderDetailVC.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/18.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTOrderDetailVC : UIViewController
@property(nonatomic,retain)NSArray *goodsArr;
@property(nonatomic,retain)NSDictionary *goodsDic;
//地址信息
@property(nonatomic,copy)NSString *useraddress;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *addressID;
@property(nonatomic,copy)NSString *mobile;

@property(nonatomic,assign)int typeCode;
@end
