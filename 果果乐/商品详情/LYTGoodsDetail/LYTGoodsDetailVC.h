//
//  LYTGoodsDetailVC.h
//  addProject
//
//  Created by 云盛科技 on 2017/7/31.
//  Copyright © 2017年 神廷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTGoodsDetailVC : UIViewController
@property(nonatomic,copy)NSString *goodsId;
@property(nonatomic,retain)NSMutableArray       *defaultSelectArr; //选择规格属性-重新出现时默认选择

@end
