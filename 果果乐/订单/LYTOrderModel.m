//
//  LYTOrderModel.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTOrderModel.h"

@implementation LYTOrderModel
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
    if ([key isEqualToString:@"num"]) {
        self.num = [value intValue];
    }
    if ([key isEqualToString:@"price"]) {
        self.price = value;
    }
    if ([key isEqualToString:@"goods_id"]) {
        self.goods_id = value;
    }
    if ([key isEqualToString:@"sn"]) {
        self.sn = value;
    }
    if ([key isEqualToString:@"spec_key"]) {
        self.spec_key = value;
    }
    if ([key isEqualToString:@"spec_key_name"]) {
        self.spec_key_name = value;
    }
    if ([key isEqualToString:@"order_id"]) {
        self.order_id = value;
    }
    if ([key isEqualToString:@"product_id"]) {
        self.product_id = value;
    }
    if ([key isEqualToString:@"image"]) {
        self.image = value;
    }
    
   
    
    
}
@end
