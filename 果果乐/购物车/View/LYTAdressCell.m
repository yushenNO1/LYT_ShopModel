//
//  LYTAdressCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏

#import "LYTAdressCell.h"

@implementation LYTAdressCell

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
        [self addSubview:self.image];
        
        
    }
    return self;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*kScreenWidth1, 20*kScreenHeight1, 150*kScreenWidth1, 30*kScreenHeight1)];
        _nameLabel.font = [UIFont systemFontOfSize:16*kScreenWidth1];
        _nameLabel.text = @"宇";
        _nameLabel.textColor = [UIColor xiaobiaotiColor];
    }
    return _nameLabel;
}
//-(UIImageView *)image
//{
//    if (!_image )
//    {
//        _image = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.size.height+30*kScreenHeight1, 20*kScreenWidth1, 20*kScreenHeight1)];
//        _image.image = [UIImage imageNamed:@"local_paintAgain"];
//    }
//    return _image;
//}
-(UILabel *)adressLabel
{
    if (!_adressLabel)
    {
        _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.size.height+20, kScreenWidth-_nameLabel.frame.origin.x-80*kScreenWidth1, 40*kScreenHeight1)];
        _adressLabel.numberOfLines = 0;
        _adressLabel.text = @"qwwewsdd54546a54s5645845454545145141651651651d6a5";
        _adressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _adressLabel.font = [UIFont systemFontOfSize:14*kScreenWidth1];
        _adressLabel.textColor = [UIColor xiaobiaotiColor];
    }
    return _adressLabel;
}
-(UILabel *)phone
{
    if (!_phone)
    {
        _phone = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x+_nameLabel.frame.size.width+40*kScreenWidth1, _nameLabel.frame.origin.y, kScreenWidth-(_nameLabel.frame.size.width+80*kScreenWidth1+20*kScreenWidth1), _nameLabel.frame.size.height)];
        _phone.font = [UIFont systemFontOfSize:16*kScreenWidth1];
        _phone.text = @"15225700234";
        _phone.textColor = [UIColor xiaobiaotiColor];
    }
    return _phone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
