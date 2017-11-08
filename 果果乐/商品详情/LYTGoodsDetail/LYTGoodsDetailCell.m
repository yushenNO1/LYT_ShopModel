//
//  LYTGoodsDetailCell.m
//  addProject
//
//  Created by 云盛科技 on 2017/8/1.
//  Copyright © 2017年 神廷. All rights reserved.
//

#import "LYTGoodsDetailCell.h"

@implementation LYTGoodsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.YLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.soldLabel];
    }
    return self;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame = CGRectMake(10 * kScreenWidth1, 5* kScreenHeight1, 355 * kScreenWidth1, 40* kScreenHeight1);
        _titleLabel = [[UILabel alloc]initWithFrame:frame];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithRed:78 / 255.0 green:78 / 255.0 blue:78 / 255.0 alpha:1];
        _titleLabel.text = @"小魔仙服装有限公司小魔仙服装有限公司小魔仙服装有限公司小魔仙服装有限公司";
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        CGRect frame = CGRectMake(10 * kScreenWidth1, 45* kScreenHeight1, 355 * kScreenWidth1, 20* kScreenHeight1);
        _contentLabel = [[UILabel alloc]initWithFrame:frame];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor colorWithRed:78 / 255.0 green:78 / 255.0 blue:78 / 255.0 alpha:1];
        _contentLabel.text = @"小魔仙服装有限公司内容";
    }
    return _contentLabel;
}

- (UILabel *)YLabel {
    if (!_YLabel) {
        CGRect frame = CGRectMake(10 * kScreenWidth1, 75* kScreenHeight1, 15 * kScreenWidth1, 20* kScreenHeight1);
        _YLabel = [[UILabel alloc]initWithFrame:frame];
        _YLabel.font = [UIFont systemFontOfSize:14];
        _YLabel.textColor = [UIColor colorWithRed:255/255.0 green:81/255.0 blue:113/255.0 alpha:1];
        _YLabel.text = @"¥";
    }
    return _YLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        CGRect frame = CGRectMake(20 * kScreenWidth1, 70* kScreenHeight1, 180 * kScreenWidth1, 30* kScreenHeight1);
        _moneyLabel = [[UILabel alloc]initWithFrame:frame];
        _moneyLabel.font = [UIFont systemFontOfSize:22];
        _moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:81/255.0 blue:113/255.0 alpha:1];
        _moneyLabel.text = @"9898";
    }
    return _moneyLabel;
}

- (UILabel *)soldLabel {
    if (!_soldLabel) {
        CGRect frame = CGRectMake(200 * kScreenWidth1, 80* kScreenHeight1, 175 * kScreenWidth1, 20* kScreenHeight1);
        _soldLabel = [[UILabel alloc]initWithFrame:frame];
        _soldLabel.font = [UIFont systemFontOfSize:12];
        _soldLabel.textColor = [UIColor colorWithRed:78 / 255.0 green:78 / 255.0 blue:78 / 255.0 alpha:1];
        //        _soldLabel.textAlignment = NSTextAlignmentRight;
        _soldLabel.text = @"已售200";
    }
    return _soldLabel;
}



@end
