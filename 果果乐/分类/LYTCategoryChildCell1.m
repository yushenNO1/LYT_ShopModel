//
//  LYTCategoryChildCell1.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTCategoryChildCell1.h"

@implementation LYTCategoryChildCell1
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.titleLabel];
    }
    return self;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect frame = CGRectMake(10 * kScreenWidth1, 5* kScreenHeight1, 200 * kScreenWidth1, 20* kScreenHeight1);
        _titleLabel = [[UILabel alloc]initWithFrame:frame];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithRed:78 / 255.0 green:78 / 255.0 blue:78 / 255.0 alpha:1];
        _titleLabel.text = @"小魔仙服装有限公司";
    }
    return _titleLabel;
}
@end
