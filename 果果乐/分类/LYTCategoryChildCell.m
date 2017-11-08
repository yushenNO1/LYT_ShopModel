//
//  LYTCategoryChildCell.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTCategoryChildCell.h"

@implementation LYTCategoryChildCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.img];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UIImageView *)img
{
    if (!_img) {
        CGRect frame = CGRectMake(0 * kScreenWidth1, 0* kScreenHeight1, 93 * kScreenWidth1, 93* kScreenHeight1);
        self.img = [[UIImageView alloc] init];
        _img.frame = frame;
    }
    return _img;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame = CGRectMake(0 * kScreenWidth1, 93* kScreenHeight1, 93 * kScreenWidth1, 20* kScreenHeight1);
        _titleLabel = [[UILabel alloc]initWithFrame:frame ];
        _titleLabel.font = [UIFont systemFontOfSize:14 * kScreenHeight1];
        _titleLabel.textColor = [UIColor colorWithRed:78 / 255.0 green:78 / 255.0 blue:78 / 255.0 alpha:1];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
