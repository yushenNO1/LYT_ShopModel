//
//  LYTShopCartModel.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTShopCartModel.h"

@implementation LYTShopCartModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.isChoose = 0;
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"num"]) {
        self.goods_num = [value intValue];
    }
    if ([key isEqualToString:@"is_check"]) {
        self.selected = [value intValue];
    }
    if ([key isEqualToString:@"name"]) {
        self.goods_name = value;
    }
    if ([key isEqualToString:@"price"]) {
        self.goods_price = value;
    }
    if ([key isEqualToString:@"specs"]) {
        self.spec_key_name = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.idCode = value;
    }
    if ([key isEqualToString:@"image_default"]) {
        self.original_img = value;
    }
    if ([key isEqualToString:@"goods_freight"]) {
        self.goods_freight = value;
    }
    if ([key isEqualToString:@"freight_type"]) {
        self.freight_type = value;
    }
    
    if ([key isEqualToString:@"sn"]) {
        self.sn = value;
    }
    if ([key isEqualToString:@"catid"]) {
        self.catid = value;
    }
    if ([key isEqualToString:@"product_id"]) {
        self.product_id = value;
    }
}

@end
