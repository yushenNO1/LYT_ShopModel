//
//  LYTLifeTableModel.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTLifeTableModel.h"

@implementation LYTLifeTableModel
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
        self.name = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"thumbnail"]) {
        self.thumbnail = [NSString stringWithFormat:@"%@", value];
    }
    
    
    if ([key isEqualToString:@"tag_id"]) {
        self.tag_id = [value integerValue];
    }
    if ([key isEqualToString:@"ordernum"]) {
            self.ordernum = [value integerValue];
    }
    if ([key isEqualToString:@"goods_id"]) {
        self.goods_id = [value integerValue];
    }
    if ([key isEqualToString:@"price"]) {
        self.price = [value doubleValue];
    }
    if ([key isEqualToString:@"point"]) {
        self.point = [value integerValue];
    }
}
@end
