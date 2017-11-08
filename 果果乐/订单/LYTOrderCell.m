//
//  LYTOrderCell.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTOrderCell.h"
#import "LYTOrderModel.h"

@implementation LYTOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [_shopView removeFromSuperview];
        self.backgroundColor = [UIColor  whiteColor];
        self.contentView.backgroundColor = [UIColor  whiteColor];
        [self addSubview:self.shopName];
    }
    return self;
}
-(void)PutDataWithDic:(NSDictionary *)dic{
    self.dataDic = dic;
    [self addSubview:self.yu_eLabel];
    [self addSubview:self.yunFeiLabel];
    [self addSubview:self.shiFuLabel];
    [self addSubview:self.orderSn];
    [_shopView removeFromSuperview];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic1  in dic[@"itemList"])
    {
        LYTOrderModel *model = [[LYTOrderModel alloc]initWithDictionary:dic1];
        [arr addObject:model];
    }
   
    for (int i = 0; i < [arr count]; i ++) {
        LYTOrderModel *model = arr[i];
        _shopView = [[UIView alloc]initWithFrame:CGRectMake(0, 20+100*i, kScreenWidth, 100)];
        _shopView.backgroundColor = [UIColor backGray];;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        [_shopView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 160, 40)];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor xiaobiaotiColor];
        titleLabel.text = @"121254asdas5d4asdasdasd很长很长   需要折行a56sd4a";
        titleLabel.font = [UIFont systemFontOfSize:14];
        [_shopView addSubview:titleLabel];

        UILabel *specLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 160, 20)];
        specLabel.textColor = [UIColor lightGrayColor];
        specLabel.numberOfLines = 1;
        specLabel.text = @"asdadasdadasd";
        specLabel.font = [UIFont systemFontOfSize:13];
        [_shopView addSubview:specLabel];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 90, 70, 80, 20)];
        countLabel.numberOfLines = 1;
        countLabel.text = @"x1";
        countLabel.textColor = [UIColor xiaobiaotiColor];
        countLabel.font = [UIFont systemFontOfSize:14];
        countLabel.textAlignment = NSTextAlignmentRight;
        [_shopView addSubview:countLabel];
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 160, 20)];
        moneyLabel.numberOfLines = 1;
        moneyLabel.textColor = [UIColor xiaobiaotiColor];
        moneyLabel.text = @"";
        moneyLabel.font = [UIFont systemFontOfSize:14];
        moneyLabel.textColor = [UIColor redColor];
        [_shopView addSubview:moneyLabel];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image]] placeholderImage:[UIImage imageNamed:@"img_error"]];
        titleLabel.text = model.name;
        countLabel.text = [NSString stringWithFormat:@"x%d",model.num];
        specLabel.text = [NSString stringWithFormat:@"%@",@""];
        moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.price doubleValue]];
        [self addSubview:_shopView];
    }
    self.yu_eLabel.frame = CGRectMake(kScreenWidth-170, [arr count]*100+20, 160, 20);
    self.yu_eLabel.text = [NSString stringWithFormat:@"赠送%d积分",[dic[@"gainedpoint"] intValue]/100];
    self.yu_eLabel.textColor = [UIColor xiaobiaotiColor];
    self.yunFeiLabel.frame = CGRectMake(kScreenWidth-170, _yu_eLabel.frame.origin.y+20, 160, 20);
    self.yunFeiLabel.text = [NSString stringWithFormat:@"运费:%.2f",[dic[@"shipping_amount"] doubleValue]];
    self.yunFeiLabel.textColor = [UIColor xiaobiaotiColor];
    self.shiFuLabel.frame = CGRectMake(kScreenWidth-170, _yunFeiLabel.frame.origin.y+20, 160, 20);
    
    self.shiFuLabel.text = [NSString stringWithFormat:@"实付金额:%.2f",[dic[@"order_amount"] doubleValue]];
    self.shiFuLabel.textColor = [UIColor xiaobiaotiColor];
    self.orderSn.text = [NSString stringWithFormat:@"订单号:%@",dic[@"sn"]];
}
//商家名


-(UILabel *)shopName{
    if (!_shopName) {
        _shopName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160, 20)];
        _shopName.numberOfLines = 0;
        _shopName.text = @"果果乐精品 >";
        _shopName.textColor = [UIColor xiaobiaotiColor];
        _shopName.font = [UIFont systemFontOfSize:12];
    }
    return _shopName;
}
-(UILabel *)orderSn{
    if (!_orderSn) {
        _orderSn = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 200, 20)];
        _orderSn.numberOfLines = 0;
        _orderSn.textAlignment = NSTextAlignmentRight;
        _orderSn.textColor = [UIColor xiaobiaotiColor];
        _orderSn.font = [UIFont systemFontOfSize:10];
    }
    return _orderSn;
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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 160, 40)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"121254asdas5d4asdasdasd很长很长   需要折行a56sd4a";
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
-(UILabel *)specLabel{
    if (!_specLabel) {
        _specLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 160, 20)];
        _specLabel.numberOfLines = 1;
        _specLabel.text = @"asdadasdadasd";
        _specLabel.font = [UIFont systemFontOfSize:13];
    }
    return _specLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 90, 70, 80, 20)];
        _countLabel.numberOfLines = 1;
        //        _countLabel.layer.borderWidth = 0.5f;
        _countLabel.text = @"x1";
        //        _countLabel.layer.borderColor = [[UIColor grayColor] CGColor];
        //        _countLabel.layer.masksToBounds = YES;
        _countLabel.font = [UIFont systemFontOfSize:16];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 160, 20)];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = @"";
        _moneyLabel.textColor = [UIColor redColor];
    }
    return _moneyLabel;
}

//金额
-(UILabel *)yu_eLabel{
    if (!_yu_eLabel) {
        _yu_eLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, _goodsView.frame.origin.y+20, 160, 20)];
        _yu_eLabel.numberOfLines = 0;
        _yu_eLabel.textAlignment = NSTextAlignmentRight;
        _yu_eLabel.text = @"使用余额:100";
        _yu_eLabel.font = [UIFont systemFontOfSize:14];
    }
    return _yu_eLabel;
}
-(UILabel *)yunFeiLabel{
    if (!_yunFeiLabel) {
        _yunFeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, _yu_eLabel.frame.origin.y+100, 160, 20)];
        _yunFeiLabel.numberOfLines = 0;
        _yunFeiLabel.textAlignment = NSTextAlignmentRight;
        _yunFeiLabel.text = @"运费:----";
        _yunFeiLabel.font = [UIFont systemFontOfSize:14];
    }
    return _yunFeiLabel;
}

-(UILabel *)shiFuLabel{
    if (!_shiFuLabel) {
        _shiFuLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, _yunFeiLabel.frame.origin.y+20, 160, 20)];
        _shiFuLabel.numberOfLines = 0;
        _shiFuLabel.textAlignment = NSTextAlignmentRight;
        _shiFuLabel.text = @"总计消费:----";
        _shiFuLabel.font = [UIFont systemFontOfSize:14];
    }
    return _shiFuLabel;
}


@end
