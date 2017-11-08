//
//  LYTShopCartCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTShopCartCell.h"

@implementation LYTShopCartCell

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
        [self addSubview:self.isChooseBtn];
        [self addSubview:self.isChooseImg];
        [self addSubview:self.addBtn];
        [self addSubview:self.subBtn];
        [self addSubview:self.deleteBtn];
    }
    return self;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 80, 80)];
        _imgView.backgroundColor = [UIColor grayColor];
    }
    return _imgView;
}



-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 160, 40)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"121254asdas5d4asdasdasd很长很长   需要折行a56sd4a";
        _titleLabel.font = [UIFont systemFontOfSize:14];
//        _titleLabel.textColor = [UIColor biaotiColor];
    }
    return _titleLabel;
}
-(UILabel *)specLabel{
    if (!_specLabel) {
        _specLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 50, 160, 20)];
        _specLabel.numberOfLines = 1;
        _specLabel.textColor = [UIColor grayColor];
        _specLabel.text = @"asdadasdadasd";
        _specLabel.font = [UIFont systemFontOfSize:14];
    }
    return _specLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 70, 60, 20)];
        _countLabel.numberOfLines = 1;
        _countLabel.layer.borderWidth = 0.5f;
        _countLabel.text = @"1";
        _countLabel.layer.borderColor = [[UIColor grayColor] CGColor];
        _countLabel.layer.masksToBounds = YES;
        _countLabel.font = [UIFont systemFontOfSize:16];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 40, 100, 20)];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = @"";
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}


-(UIButton *)isChooseBtn{
    if (!_isChooseBtn) {
        _isChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _isChooseBtn.frame = CGRectMake(0, 0, 30, 100);
    }
    return _isChooseBtn;
}
-(UIImageView *)isChooseImg{
    if (!_isChooseImg) {
        _isChooseImg = [[UIImageView alloc]init];
        _isChooseImg.frame = CGRectMake(10, 40, 20, 20);
    }
    return _isChooseImg;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(210, 70, 20, 20);
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
//        _addBtn.backgroundColor = [UIColor anniuColor];
    }
    return _addBtn;
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn.frame = CGRectMake(130, 70, 20, 20);
        [_subBtn setTitle:@"-" forState:UIControlStateNormal];
//        _subBtn.backgroundColor = [UIColor anniuColor];
    }
    return _subBtn;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(kScreenWidth - 30, 70, 20, 20);
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"shopcar_del"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
