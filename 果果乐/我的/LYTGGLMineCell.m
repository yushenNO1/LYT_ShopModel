//
//  LYTGGLMineCell.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/12.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTGGLMineCell.h"

@implementation LYTGGLMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        [self addSubview:self.btn4];
        
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self addSubview:self.line3];
        
        
    }
    return self;
}
-(UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = WDH_CGRectMake(10, 10, 73, 73);
//        _btn1.backgroundColor = [UIColor redColor];
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"my_wait_pay@3x"] forState:UIControlStateNormal];
    }
    return _btn1;
}
-(UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(93, 5, 1, 83)];
        _line1.backgroundColor = [UIColor backGray];
    }
    return _line1;
}
-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = WDH_CGRectMake(104, 10, 73, 73);
//        _btn2.backgroundColor = [UIColor redColor];
        [_btn2 setBackgroundImage:[UIImage imageNamed:@"my_wait__hair@3x"] forState:UIControlStateNormal];
    }
    return _btn2;
}
-(UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(187, 5, 1, 83)];
        _line2.backgroundColor = [UIColor backGray];
    }
    return _line2;
}
-(UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = WDH_CGRectMake(198, 10, 73, 73);
//        _btn3.backgroundColor = [UIColor redColor];
        [_btn3 setBackgroundImage:[UIImage imageNamed:@"my_wait_haircar@3x"] forState:UIControlStateNormal];
    }
    return _btn3;
}
-(UILabel *)line3{
    if (!_line3) {
        _line3 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(281, 5, 1, 83)];
        _line3.backgroundColor = [UIColor backGray];
    }
    return _line3;
}
-(UIButton *)btn4{
    if (!_btn4) {
        _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn4.frame = WDH_CGRectMake(292, 10, 73, 73);
//        _btn4.backgroundColor = [UIColor redColor];
        [_btn4 setBackgroundImage:[UIImage imageNamed:@"my_ok_haircar@3x"] forState:UIControlStateNormal];
    }
    return _btn4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
