//
//  WSSShippingAddressModel.m
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "WSSShippingAddressModel.h"

@implementation WSSShippingAddressModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"name"]) {
        self.name = value;
    }
    if ([key isEqualToString:@"mobile"]) {
        self.mobile = value;
    }
    if ([key isEqualToString:@"tel"]) {
        self.tel = value ;
    }
    if ([key isEqualToString:@"province_id"]) {
        self.province_id = value;;
    }
    if ([key isEqualToString:@"city_id"]) {
        self.city_id = value;
    }
    if ([key isEqualToString:@"region_id"]) {
        self.region_id = value;
    }
    if ([key isEqualToString:@"province"]) {
        self.province = value ;
    }
    if ([key isEqualToString:@"city"]) {
        self.city = value ;
    }
    if ([key isEqualToString:@"region"]) {
        self.region = value ;
    }
    
    if ([key isEqualToString:@"town_id"]) {
        self.town_id = value;
    }
    if ([key isEqualToString:@"town"]) {
        self.town = value ;
    }
    if ([key isEqualToString:@"addr"]) {
        self.addr = value ;
    }
    if ([key isEqualToString:@"def_addr"]) {
        self.def_addr = value ;
    }
    if ([key isEqualToString:@"addr_id"]) {
        self.addr_id = value ;
    }
}

@end
