//
//  LogisitcsTableViewCell.m
//  YSApp
//
//  Created by 云盛科技 on 2016/10/26.
//  Copyright © 2016年 云盛科技. All rights reserved.
//

#import "LogisitcsTableViewCell.h"
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width / 375)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height / 667)
@implementation LogisitcsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.image];
        [self addSubview:self.placeLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (UIImageView *)image{
    if (!_image)
    {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(20*kScreenWidth, 10*kScreenHeight, 10*kScreenWidth, 40*kScreenHeight)];
        _image.image = [UIImage imageNamed:@""];
    }
    return _image;
}

- (UILabel *)placeLabel{
    if (!_placeLabel)
    {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*kScreenWidth, 10*kScreenHeight, 300*kScreenWidth, 40*kScreenHeight)];
        _placeLabel.font = [UIFont systemFontOfSize:13*kScreenHeight];
        _placeLabel.numberOfLines = 0;
//        _placeLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = [_placeLabel sizeThatFits:CGSizeMake(_placeLabel.frame.size.width, MAXFLOAT)];
//        _placeLabel.frame =CGRectMake(40*kScreenWidth, 10*kScreenHeight, 300*kScreenWidth, size.height);
        _placeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_placeLabel];
    }
    return _placeLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*kScreenWidth, 50*kScreenHeight, 230*kScreenWidth, 15*kScreenHeight)];
        _timeLabel.font = [UIFont systemFontOfSize:13*kScreenHeight];
        _placeLabel.numberOfLines = 1;
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}


@end
