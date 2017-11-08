//
//  logisitecsModel.h
//  YSApp
//
//  Created by 云盛科技 on 2016/10/26.
//  Copyright © 2016年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface logisitecsModel : NSObject

@property (nonatomic, copy) NSString *time_url;
@property (nonatomic, copy) NSString *context_url;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
