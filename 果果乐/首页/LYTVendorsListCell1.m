//
//  LYTVendorsListCell1.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTVendorsListCell1.h"

@implementation LYTVendorsListCell1
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.titleLabel];   //商品名称
       
        
    }
    return self;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0,  5, 365, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"奥术大师多阿斯蒂芬斯蒂芬";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
