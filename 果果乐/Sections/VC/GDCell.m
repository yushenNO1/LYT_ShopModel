//
//  GDCell.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "GDCell.h"

@implementation GDCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.priceLabel];
        [self addSubview:self.LeftLabel];
        [self addSubview:self.rightLabel];
        [self addSubview:self.lightGrayLine];
    }
    return self;
}
- (UILabel *)priceLabel  {
    if (!_priceLabel)
    {
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*kScreenWidth2, 0*kScreenHeight2, 70*kScreenWidth2, 30*kScreenHeight2)];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textAlignment = 1;
        _priceLabel.textColor =[UIColor colorWithRed:140 / 255.0 green:140 / 255.0 blue:140 / 255.0 alpha:1];
    }
    return _priceLabel;
}

- (UILabel *)rightLabel  {
    if (!_rightLabel)
    {
        _rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(130, 0*kScreenHeight2, 100*kScreenWidth2, 30*kScreenHeight2)];
        _rightLabel.font =[UIFont systemFontOfSize:12*kScreenWidth2];
        _rightLabel.textColor =[UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}

- (UILabel *)LeftLabel  {
    if (!_LeftLabel)
    {
        _LeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0*kScreenHeight2, 50*kScreenWidth2, 30*kScreenHeight2)];
        _LeftLabel.font =[UIFont systemFontOfSize:12*kScreenWidth2];
        _LeftLabel.textColor =[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        _LeftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _LeftLabel;
}

- (UILabel *)lightGrayLine  {
    if (!_lightGrayLine)
    {
        _lightGrayLine =[[UILabel alloc]initWithFrame:CGRectMake(0, 29*kScreenHeight2, 233*kScreenWidth2, 1*kScreenHeight2)];
        _lightGrayLine.backgroundColor = [UIColor backGray];
    }
    return _lightGrayLine;
}

@end
