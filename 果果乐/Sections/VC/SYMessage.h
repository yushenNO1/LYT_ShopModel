//
//  SYMessage.h
//  MainPage
//
//  Created by 云盛科技 on 2017/1/14.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYMessage : NSObject

/** 图片 */
@property (nonatomic, strong) NSString *picName;
/** 消息标题 */
@property (nonatomic, strong) NSString *messageTitle;
/** 消息内容 */
@property (nonatomic, strong) NSString *messageContent;
/** 消息时间*/
@property (nonatomic, strong) NSString *messageTime;
/** 弹窗时间*/
@property (nonatomic, strong) NSString *bannerTime;
/** 弹窗图片 */
@property (nonatomic, strong) NSString *bannerPic;
/** 连接 */
@property (nonatomic, strong) NSString *pic_url;
/** 消息类型 */
@property (nonatomic, assign) NSInteger messageType;
/** 是否已读 */
@property (nonatomic, strong) NSString *hasRead;
@property (nonatomic, assign) NSInteger cellHight;

+ (instancetype)messageWithDic:(NSDictionary *)dic;

@end
