//
//  LYTPayTypeTableCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTPayTypeTableCell.h"

@implementation LYTPayTypeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.chooseBtn];
        
    }
    return self;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//        _imgView.backgroundColor = [UIColor grayColor];
    }
    return _imgView;
}

-(UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.frame = CGRectMake(kScreenWidth-30, 10, 20  , 20);
//        _chooseBtn.backgroundColor = [UIColor grayColor];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_no"] forState:UIControlStateNormal];
    }
    return _chooseBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
        _titleLabel.text = @"余额";
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
