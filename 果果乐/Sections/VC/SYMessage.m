//
//  SYMessage.m
//  MainPage
//
//  Created by 云盛科技 on 2017/1/14.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "SYMessage.h"

@implementation SYMessage

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.bannerPic = dic[@"news_info"][@"thumb"];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"content"]) {
        self.messageContent = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"createDate"]) {
        self.messageTime = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"id"]) {
        self.messageType = [value integerValue];
    }
}

+ (instancetype)messageWithDic:(NSDictionary *)dic{
    return [[SYMessage alloc]initWithDictionary:dic];
}

@end
