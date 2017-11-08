//
//  WSSShippingAddressTableViewCell.m
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//



//添加常用的宏
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width           //屏宽
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height          //屏高
#define kScreenWidth1       ([UIScreen mainScreen].bounds.size.width / 375)     //适配宽度
#define kScreenHeight1      ([UIScreen mainScreen].bounds.size.height / 667)    //适配高度

#import "WSSShippingAddressTableViewCell.h"

@implementation WSSShippingAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.nameLabel];
        [self addSubview:self.adressLabel];
        [self addSubview:self.phone];
        [self addSubview:self.defaulBtn];
        [self addSubview:self.defaulLabel];
        [self addSubview:self.defaulBtnImg];
        [self addSubview:self.lineLabel];
         [self addSubview:self.modifyBtn];
         [self addSubview:self.deleteBtn];
        
    }
    return self;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * kScreenWidth1, 5 *kScreenHeight1, 150 * kScreenWidth1, 30 * kScreenHeight1)];
        _nameLabel.font = [UIFont systemFontOfSize:15 * kScreenHeight1];
        _nameLabel.textColor = [UIColor xiaobiaotiColor];
    }
    return _nameLabel;
}
-(UILabel *)phone
{
    if (!_phone)
    {
        _phone = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 160 * kScreenWidth1), _nameLabel.frame.origin.y, 150 * kScreenWidth1, _nameLabel.frame.size.height)];
        _phone.textColor = [UIColor xiaobiaotiColor];
        _phone.font = [UIFont systemFontOfSize:15 * kScreenHeight1];
        _phone.textAlignment =2;
    }
    return _phone;
}
-(UILabel *)adressLabel
{
    if (!_adressLabel)
    {
        _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.size.height , kScreenWidth - 10 * kScreenWidth1, 40 * kScreenHeight1)];
        _adressLabel.textColor = [UIColor xiaobiaotiColor];
        _adressLabel.numberOfLines = 0;
        _adressLabel.font = [UIFont systemFontOfSize:12 * kScreenHeight1];
    }
    return _adressLabel;
}
-(UILabel *)lineLabel
{
    if (!_lineLabel)
    {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * kScreenWidth1, _adressLabel.frame.size.height + 30 * kScreenHeight1, kScreenWidth - 20 * kScreenWidth1 , 1 * kScreenHeight1)];
        _lineLabel.backgroundColor = [UIColor lineColor];

    }
    return _lineLabel;
}

-(UIButton *)defaulBtn
{
    if (!_defaulBtn)
    {
        _defaulBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _defaulBtn.frame = CGRectMake(_nameLabel.frame.origin.x, 80 * kScreenHeight1, 20 * kScreenWidth1, 20 * kScreenHeight1);
    }
    return _defaulBtn;
}
//-(UIImageView *)defaulBtnImg
//{
//    if (!_defaulBtnImg)
//    {
//        _defaulBtnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuan@3x"]];
//        _defaulBtnImg.frame = CGRectMake(_nameLabel.frame.origin.x, 75 * kScreenHeight1, 30 * kScreenWidth1, 30 * kScreenHeight1);
//    }
//    return _defaulBtnImg;
//}
-(UILabel *)defaulLabel
{
    if (!_defaulLabel)
    {
        _defaulLabel = [[UILabel alloc]initWithFrame:CGRectMake(_defaulBtn.frame.origin.x + 30 * kScreenWidth1, _defaulBtn.frame.origin.y , 100 * kScreenWidth1, 20 * kScreenHeight1)];
        _defaulLabel.font = [UIFont systemFontOfSize:12 * kScreenHeight1];
        _defaulLabel.textColor = [UIColor xiaobiaotiColor];
    }
    return _defaulLabel;
}



//-(UIButton *)modifyBtn
//{
//    if (!_modifyBtn)
//    {
//        _modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _modifyBtn.frame = CGRectMake((kScreenWidth - 120 * kScreenWidth1), 75 * kScreenHeight1, 40 * kScreenWidth1, 30 * kScreenHeight1);
//        [_modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [_modifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _modifyBtn.titleLabel.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
//    }
//    return _modifyBtn;
//}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake((kScreenWidth - 50 * kScreenWidth1), 75 * kScreenHeight1, 40 * kScreenWidth1, 30 * kScreenHeight1);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor anniuColor] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
    }
    return _deleteBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
