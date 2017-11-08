//
//  SZCell.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "SZCell.h"

@implementation SZCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.priceLabel];
        [self addSubview:self.LeftLabel];
        [self addSubview:self.Btn];
        [self addSubview:self.lightGrayLine];
    }
    return self;
}
- (UILabel *)priceLabel  {
    if (!_priceLabel)
    {
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(85*kScreenWidth2, 0*kScreenHeight2, 90*kScreenWidth2, 30*kScreenHeight2)];
        _priceLabel.font = [UIFont systemFontOfSize:17];
        
    }
    return _priceLabel;
}


- (UILabel *)LeftLabel  {
    if (!_LeftLabel)
    {
        _LeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0*kScreenHeight2, 70*kScreenWidth2, 29*kScreenHeight2)];
        _LeftLabel.font =[UIFont systemFontOfSize:12*kScreenWidth2];
        _LeftLabel.textColor =[UIColor lightGrayColor];
        _LeftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _LeftLabel;
}

- (UIButton *)Btn  {
    if (!_Btn)
    {
        _Btn =[UIButton buttonWithType:UIButtonTypeSystem];
        _Btn.frame = WDH_CGRectMake1(180, 5, 40, 20);
        _Btn.layer.cornerRadius = 5;
        _Btn.layer.masksToBounds = YES;
        _Btn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [_Btn setTitle:@"查收" forState:UIControlStateNormal];
        [_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _Btn;
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
