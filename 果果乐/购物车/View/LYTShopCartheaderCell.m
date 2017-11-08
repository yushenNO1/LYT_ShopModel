//
//  LYTShopCartheaderCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/14.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTShopCartheaderCell.h"

@implementation LYTShopCartheaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.isChooseAllBtn];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 160, 20)];
        _titleLabel.text = @"果果乐精品";
//        _titleLabel.textColor = [UIColor xiaobiaotiColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
-(UIButton *)isChooseAllBtn{
    if (!_isChooseAllBtn) {
        _isChooseAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _isChooseAllBtn.frame = CGRectMake(10, 10, 20, 20);
    }
    return _isChooseAllBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
