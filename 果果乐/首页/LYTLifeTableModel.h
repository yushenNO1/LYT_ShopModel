//
//  LYTLifeTableModel.h
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTLifeTableModel : NSObject
@property(nonatomic,copy)NSString *name;                    //名称
@property(nonatomic,copy)NSString *thumbnail;               //图片url



@property(nonatomic,assign)NSInteger goods_id;              //商品id
@property(nonatomic,assign)NSInteger ordernum;              //订单数量
@property(nonatomic,assign)double price;                    //价格
@property(nonatomic,assign)NSInteger tag_id;                //类型
@property(nonatomic,assign)NSInteger point;                //积分


- (id)initWithDictionary:(NSDictionary *)dic;
@end
