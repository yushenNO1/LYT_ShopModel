//
//  WSSAdressView.m
//  cccc
//
//  Created by 王松松 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "WSSAdressView.h"

@implementation WSSAdressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
    }
    return self;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}
-(UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        _textField.borderStyle = UITextBorderStyleNone;
    }
    return _textField;
}

@end
