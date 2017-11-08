//
//  LYTShopCartCell.h
//  LSK
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTShopCartCell : UITableViewCell


@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UIImageView *isChooseImg;



@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *specLabel;
@property(nonatomic,retain)UILabel *countLabel;
@property(nonatomic,retain)UILabel *moneyLabel;



@property(nonatomic,retain)UIButton *isChooseBtn;
@property(nonatomic,retain)UIButton *addBtn;
@property(nonatomic,retain)UIButton *subBtn;
@property(nonatomic,retain)UIButton *deleteBtn;


@end
