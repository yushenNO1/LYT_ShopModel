//
//  LYTGGLMineCell1.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/12.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTGGLMineCell1.h"

@implementation LYTGGLMineCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.img];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
    }
    return self;
    
    
}

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(10, 7, 30, 30)];
//        _img.backgroundColor = [UIColor redColor];
    }
    return _img;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(45, 7, 150, 30)];
        _titleLabel.text = @"收货地址地址";
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(200, 7, 150, 30)];
        _contentLabel.text = @"收货地址地址";
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
