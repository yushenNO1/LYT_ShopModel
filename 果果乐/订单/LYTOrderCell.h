//
//  LYTOrderCell.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTOrderCell : UITableViewCell
//商家名
@property(nonatomic,retain)UILabel *shopName;

//商品
@property(nonatomic,retain)UIView *goodsView;
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *specLabel;
@property(nonatomic,retain)UILabel *countLabel;
@property(nonatomic,retain)UILabel *moneyLabel;
@property(nonatomic,retain)UILabel *orderSn;
@property(nonatomic,retain)UIView *shopView;


@property(nonatomic,retain)UILabel *yu_eLabel;//使用余额
@property(nonatomic,retain)UILabel *yunFeiLabel;//运费
@property(nonatomic,retain)UILabel *shiFuLabel;//实付款


@property(nonatomic,copy)NSDictionary *dataDic;
-(void)PutDataWithDic:(NSDictionary *)dic;

@end
