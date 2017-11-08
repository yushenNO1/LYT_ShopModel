//
//  ZDCell.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "ZDCell.h"

@implementation ZDCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.priceLabel];
        [self addSubview:self.LeftLabel];
        [self addSubview:self.lightGrayLine];
    }
    return self;
}
- (UILabel *)priceLabel  {
    if (!_priceLabel)
    {
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(125*kScreenWidth2, 0*kScreenHeight2, 100*kScreenWidth2, 29*kScreenHeight2)];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _priceLabel;
}


- (UILabel *)LeftLabel  {
    if (!_LeftLabel)
    {
        _LeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0*kScreenHeight2, 110*kScreenWidth2, 29*kScreenHeight2)];
        _LeftLabel.font =[UIFont systemFontOfSize:12*kScreenWidth2];
        _LeftLabel.textColor =[UIColor lightGrayColor];
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
