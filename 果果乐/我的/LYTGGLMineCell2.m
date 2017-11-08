//
//  LYTGGLMineCell2.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/22.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTGGLMineCell2.h"

@implementation LYTGGLMineCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self addSubview:self.titleLabel];

    }
    return self;
    
    
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 44)];
        _titleLabel.text = @"注销";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
