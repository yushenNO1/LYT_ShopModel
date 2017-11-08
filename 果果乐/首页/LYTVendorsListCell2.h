//
//  LYTVendorsListCell2.h
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface btnView : UIView
@property(nonatomic,retain)UIButton     *clickBtn;
@property(nonatomic,retain)UIImageView  *btnImg;
@property(nonatomic,retain)UILabel      *btnTitle;
@end

@interface LYTVendorsListCell2 : UICollectionViewCell
@property(nonatomic,strong)btnView *btn1;              //按钮1
@property(nonatomic,strong)btnView *btn2;              //按钮1
@property(nonatomic,strong)btnView *btn3;              //按钮1
@property(nonatomic,strong)btnView *btn4;              //按钮1
@property(nonatomic,strong)btnView *btn5;              //按钮1

@property(nonatomic,retain)UIImageView  *btnImg;
@property(nonatomic,retain)UILabel      *btnTitle;
@property(nonatomic,strong)UIScrollView *headerScroll;  //加入购物车
@end
