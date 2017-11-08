//
//  LYTVendorsListCell.h
//  LSK
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTVendorsListCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *img;            //图片
@property(nonatomic,strong)UILabel *titleLabel;         //商品名称
@property(nonatomic,strong)UILabel *contentLabel;          //内容
@property(nonatomic,strong)UILabel *priceLabel;         //商品价格
@property(nonatomic,strong)UILabel *jiFenLabel;         //赠送积分
@property(nonatomic,strong)UIButton *buyBtn;            //加入购物车
@end
