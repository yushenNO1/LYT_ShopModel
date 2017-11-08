//
//  WSSShippingAddressModel.h
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSSShippingAddressModel : NSObject
@property (nonatomic, copy) NSString * addr_id;//地址ID
@property (nonatomic, copy) NSString * name;//名字
@property (nonatomic, copy) NSString * mobile;//手机
@property (nonatomic, copy) NSString * tel;//固话
@property (nonatomic, copy) NSString * province_id;//省份ID
@property (nonatomic, copy) NSString * city_id;//城市ID
@property (nonatomic, copy) NSString * region_id;//地区ID
@property (nonatomic, copy) NSString * town_id;//城镇ID
@property (nonatomic, copy) NSString * province;//省份
@property (nonatomic, copy) NSString * city;//城市
@property (nonatomic, copy) NSString * region;//地区
@property (nonatomic, copy) NSString * town;//城镇

@property (nonatomic, copy) NSString * def_addr;//默认
@property (nonatomic, copy) NSString * addr;//地址

- (id)initWithDictionary:(NSDictionary *)dic;

@end
