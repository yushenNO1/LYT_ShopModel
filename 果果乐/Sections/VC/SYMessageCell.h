//
//  SYMessageCell.h
//  MainPage
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYMessage;

@interface SYMessageCell : UITableViewCell

/** Model */
@property (nonatomic, strong)  SYMessage *messageModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
