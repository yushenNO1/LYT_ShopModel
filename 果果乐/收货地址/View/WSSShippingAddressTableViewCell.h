//
//  WSSShippingAddressTableViewCell.h
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSSShippingAddressTableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *image ;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *adressLabel;
@property(nonatomic,retain)UILabel *phone;
@property(nonatomic,retain)UIButton *defaulBtn;
@property(nonatomic,strong)UIView *backgrundView;
@property(nonatomic,retain)UIImageView *defaulBtnImg;
@property(nonatomic,retain)UILabel *defaulLabel;
@property(nonatomic,retain)UILabel *lineLabel;
@property(nonatomic,retain)UIButton *modifyBtn;
@property(nonatomic,retain)UIButton *deleteBtn;
@end
