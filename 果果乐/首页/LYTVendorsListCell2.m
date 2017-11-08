//
//  LYTVendorsListCell2.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTVendorsListCell2.h"


@implementation btnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.btnTitle];
        [self addSubview:self.btnImg];
        [self addSubview:self.clickBtn];
    }
    return self;
}
-(UIButton *)clickBtn{
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame = WDH_CGRectMake(0, 0, 63, 80);
    }
    return _clickBtn;
}
-(UIImageView *)btnImg{
    if (!_btnImg) {
        _btnImg = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(10, 10, 43, 43)];

    }
    return _btnImg;
}
-(UILabel *)btnTitle{
    if (!_btnTitle) {
        _btnTitle = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0, 60, 63, 20)];
        _btnTitle.textAlignment = NSTextAlignmentCenter;
        _btnTitle.font = [UIFont systemFontOfSize:12];
    }
    return _btnTitle;
}
@end
@implementation LYTVendorsListCell2
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.headerScroll];

        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
        [self.contentView addSubview:self.btn3];
        [self.contentView addSubview:self.btn4];
//        [self addSubview:self.btn5];
    }
    return self;
}


-(UIScrollView *)headerScroll{
    if (!_headerScroll) {
        _headerScroll = [[UIScrollView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 240  )];
        _headerScroll.pagingEnabled = YES;
        NSArray *arr = @[@"积分.jpg",@"ios(3)"];
        _headerScroll.contentSize = CGSizeMake(375 * kScreenWidth1 * arr.count, 240 * kScreenHeight1);
        
        for (int i = 0; i < arr.count; i ++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(375 * i, 0, 375, 240)];
            [_headerScroll addSubview:img];
            img.image = [UIImage imageNamed:arr[i]];
//            CGFloat colorF = arc4random()%255;
//            img.backgroundColor = [UIColor colorWithRed:colorF/255.0 green:colorF/255.0 blue:colorF/255.0 alpha:1];
        }
        
        
    }
    return _headerScroll;
    
}


-(btnView *)btn1{
    if (!_btn1) {
        _btn1 = [[btnView alloc]initWithFrame:WDH_CGRectMake(24.6 , 250, 63, 80)];
        _btn1.btnTitle.text = @"分类";
        _btn1.btnImg.image = [UIImage imageNamed:@"分类@3x"];

    }
    return _btn1;
}

-(btnView *)btn2{
    if (!_btn2) {
        _btn2 = [[btnView alloc]initWithFrame:WDH_CGRectMake(24.6 + 87.6, 250, 63, 80)];
        _btn2.btnTitle.text = @"果果乐";
        _btn2.btnImg.image = [UIImage imageNamed:@"果果乐@3x"];

    }
    return _btn2;
}
-(btnView *)btn3{
    if (!_btn3) {
        _btn3 = [[btnView alloc]initWithFrame:WDH_CGRectMake(24.6 + 87.6 * 2, 250, 63, 80)];
        _btn3.btnTitle.text = @"我的订单";
        _btn3.btnImg.image = [UIImage imageNamed:@"订单@3x"];

    }
    return _btn3;
}
-(btnView *)btn4{
    if (!_btn4) {
        _btn4 = [[btnView alloc]initWithFrame:WDH_CGRectMake(24.6 + 87.6 * 3 , 250, 63, 80)];
        _btn4.btnTitle.text = @"个人中心";
        _btn4.btnImg.image = [UIImage imageNamed:@"个人中心@3x"];

    }
    return _btn4;
}
-(btnView *)btn5{
    if (!_btn5) {
        _btn5 = [[btnView alloc]initWithFrame:WDH_CGRectMake(24.6 + 87.6 * 4, 250, 63, 80)];
        _btn5.btnTitle.text = @"商家入驻";
        _btn5.btnImg.image = [UIImage imageNamed:@"商家入驻icon"];

    }
    return _btn5;
}

@end
