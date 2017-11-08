//
//  LYTConfirmGoodsCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTConfirmGoodsCell.h"

@implementation LYTConfirmGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.specLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.daoFuLabel];
    }
    return self;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        _imgView.backgroundColor = [UIColor grayColor];
    }
    return _imgView;
}



-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(100, 10, 160, 40)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"121254asdas5d4asdasdasd很长很长   需要折行a56sd4a";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor biaotiColor];
    }
    return _titleLabel;
}
-(UILabel *)specLabel{
    if (!_specLabel) {
        _specLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(100, 50, 160, 20)];
        _specLabel.numberOfLines = 1;
        _specLabel.text = @"asdadasdadasd";
        _specLabel.font = [UIFont systemFontOfSize:13];
        _specLabel.textColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1];
    }
    return _specLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375 - 90, 70, 80, 20)];
        _countLabel.numberOfLines = 1;
        _countLabel.textColor = [UIColor redColor];
        _countLabel.text = @"x1";

        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(100, 70, 100, 20)];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = @"";
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
//        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}
-(UILabel *)daoFuLabel{
    if (!_daoFuLabel) {
        _daoFuLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(_moneyLabel.frame.origin.x + _moneyLabel.frame.size.width, 70, 160, 20)];
        _daoFuLabel.numberOfLines = 1;
        _daoFuLabel.text = @"";
        _daoFuLabel.textColor = [UIColor redColor];
        _daoFuLabel.font = [UIFont systemFontOfSize:10];
//        _daoFuLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _daoFuLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
