//
//  LYTOrderModel.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTOrderModel : NSObject
@property (nonatomic, assign) int num;       //
@property (nonatomic, copy) NSString * name;  //
@property (nonatomic, copy) NSString * price;      //
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * sn;
@property (nonatomic, copy) NSString * spec_key;
@property (nonatomic, copy) NSString * spec_key_name;
@property (nonatomic, copy) NSString * product_id;

@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * order_id;
//@property (nonatomic, copy) NSString * is_send;
//@property (nonatomic, copy) NSString * is_comment;
//@property (nonatomic, copy) NSString * give_integral;

















- (id)initWithDictionary:(NSDictionary *)dic;

@end
