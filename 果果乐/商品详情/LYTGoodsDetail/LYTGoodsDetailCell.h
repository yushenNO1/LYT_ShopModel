//
//  LYTGoodsDetailCell.h
//  addProject
//
//  Created by 云盛科技 on 2017/8/1.
//  Copyright © 2017年 神廷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTGoodsDetailCell : UITableViewCell

@property(nonatomic,retain)UILabel *titleLabel;         //标题
@property(nonatomic,retain)UILabel *contentLabel;       //内容
@property(nonatomic,retain)UILabel *soldLabel;          //已售
@property(nonatomic,retain)UILabel *YLabel;             //¥符号
@property(nonatomic,retain)UILabel *moneyLabel;         //金额
@property(nonatomic,retain)UILabel *inventoryLabel;     //库存

@end
