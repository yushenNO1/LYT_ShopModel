//
//  LYTShopCartModel.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTShopCartModel : NSObject
@property(nonatomic,assign)int isChoose;
@property(nonatomic,assign)int goods_num;
@property(nonatomic,assign)int selected;
@property(nonatomic,copy)NSString *  idCode;//id
@property(nonatomic,copy)NSString * goods_name;//名字
@property(nonatomic,copy)NSString * goods_price;//价格
@property(nonatomic,copy)NSString * spec_key_name;//规格
@property(nonatomic,copy)NSString * original_img;//图片
@property(nonatomic,copy)NSString * freight_type;//是否到付

@property(nonatomic,copy)NSString * sn;//货号
@property(nonatomic,copy)NSString * catid;//货号
@property(nonatomic,copy)NSString * product_id;//修改选中时用

@property(nonatomic,copy)NSString * goods_freight;//运费
- (id)initWithDictionary:(NSDictionary *)dic;
@end
