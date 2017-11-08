//
//  logisitecsModel.m
//  YSApp
//
//  Created by 云盛科技 on 2016/10/26.
//  Copyright © 2016年 云盛科技. All rights reserved.
//

#import "logisitecsModel.h"

@implementation logisitecsModel

- (id)initWithDictionary:(NSDictionary *)dic{
    self =[super init];
    if (self){
        _time_url = dic[@"time"];
        _context_url = dic[@"context"];
    }
    return self;
}

@end
