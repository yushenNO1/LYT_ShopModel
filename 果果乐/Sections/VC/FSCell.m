//
//  FSCell.m
//  果果乐
//
//  Created by 张敬文 on 2017/7/4.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "FSCell.h"

@implementation FSCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.LeftLabel];
        [self addSubview:self.rightLabel];
        
        [self addSubview:self.lightGrayLine];
        [self addSubview:self.priceLabel];
        [self addSubview:self.LeftImage];
    }
    return self;
}
- (UIImageView *)LeftImage  {
    if (!_LeftImage)
    {
        _LeftImage =[[UIImageView alloc]initWithFrame:CGRectMake(10*kScreenWidth2, 10*kScreenHeight2, 30*kScreenWidth2, 30*kScreenHeight2)];
        _LeftImage.layer.cornerRadius = 30*kScreenHeight2 / 2;
        _LeftImage.layer.masksToBounds = YES;
    }
    return _LeftImage;
}

- (UILabel *)priceLabel  {
    if (!_priceLabel)
    {
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(50*kScreenWidth2, 25*kScreenHeight2, 120*kScreenWidth2, 20*kScreenHeight2)];
        _priceLabel.font = [UIFont systemFontOfSize:12*kScreenWidth2];
        _priceLabel.textColor =[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    }
    return _priceLabel;
}

- (UILabel *)rightLabel  {
    if (!_rightLabel)
    {
        _rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(175, 0*kScreenHeight2, 50*kScreenWidth2, 50*kScreenHeight2)];
        _rightLabel.font =[UIFont systemFontOfSize:14*kScreenWidth2];
        _rightLabel.textColor =[UIColor colorWithRed:90 / 255.0 green:90 / 255.0 blue:90 / 255.0 alpha:1];
    }
    return _rightLabel;
}

- (UILabel *)LeftLabel  {
    if (!_LeftLabel)
    {
        _LeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(50, 5*kScreenHeight2, 120*kScreenWidth2, 20*kScreenHeight2)];
        _LeftLabel.font =[UIFont systemFontOfSize:12*kScreenWidth2];
        _LeftLabel.textColor =[UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1];
    }
    return _LeftLabel;
}

- (UILabel *)lightGrayLine  {
    if (!_lightGrayLine)
    {
        _lightGrayLine =[[UILabel alloc]initWithFrame:CGRectMake(0, 49*kScreenHeight2, 233*kScreenWidth2, 1*kScreenHeight2)];
        _lightGrayLine.backgroundColor = [UIColor backGray];
    }
    return _lightGrayLine;
}


@end
