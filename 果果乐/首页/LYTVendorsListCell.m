//
//  LYTVendorsListCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTVendorsListCell.h"

@implementation LYTVendorsListCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.img];          //图片
        [self.contentView addSubview:self.titleLabel];   //商品名称
        [self.contentView addSubview:self.contentLabel];    //商品编号
        [self.contentView addSubview:self.priceLabel];   //商品价格
        [self.contentView addSubview:self.jiFenLabel];  //赠送积分
        
    }
    return self;
}

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 180*kScreenWidth1, 180*kScreenHeight1)];
    }
    return _img;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*kScreenWidth1,  183*kScreenHeight1, 163*kScreenWidth1, 40*kScreenHeight1)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"奥术大师多阿斯蒂芬斯蒂芬";
    }
    return _titleLabel;
}


-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*kScreenWidth1 ,203*kScreenHeight1, 163*kScreenWidth1, 20*kScreenHeight1)];
        _contentLabel.font = [UIFont systemFontOfSize:12*kScreenHeight1];
        //        _codeLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor colorWithRed:39 / 255.0 green:39 / 255.0 blue:39 / 255.0 alpha:1];
        _contentLabel.text = @"奥术大师多阿斯蒂芬斯蒂芬";
    }
    return _contentLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*kScreenWidth1 ,223*kScreenHeight1, 80*kScreenWidth1, 30*kScreenHeight1)];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.text = @"¥98";
    }
    return _priceLabel;
}
-(UILabel *)jiFenLabel{
    if (!_jiFenLabel) {
        _jiFenLabel = [[UILabel alloc]initWithFrame:CGRectMake(90*kScreenWidth1 ,223*kScreenHeight1, 85*kScreenWidth1, 30*kScreenHeight1)];
        _jiFenLabel.font = [UIFont systemFontOfSize:10];
        _jiFenLabel.textAlignment = NSTextAlignmentRight;
        _jiFenLabel.text = @"¥98";
    }
    return _jiFenLabel;
}
-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake(140*kScreenWidth1, 223*kScreenHeight1 , 30, 30);
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"收藏icon@3x"] forState:UIControlStateNormal];
        _buyBtn.backgroundColor = [UIColor redColor];
    }
    return _buyBtn;
}

@end
