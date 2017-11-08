//
//  LYTBackView.h
//  addProject
//
//  Created by 云盛科技 on 2017/7/25.
//  Copyright © 2017年 神廷. All rights reserved.
//          蒙板背景

#import <UIKit/UIKit.h>


@protocol LYTBackViewDelegate 
@required

-(void)touchBackView;

@end


@interface LYTBackView : UIView<LYTBackViewDelegate>
@property(nonatomic,retain)UIView *dissView;
@property(nonatomic,retain)id <LYTBackViewDelegate>delegate;

//单例创建
+ (instancetype)shareSingle;

//添加蒙板,并在蒙板上添加视图,topView为自己创建的蒙板上的视图
+(void)showWithView:(id)topView;
//视图和蒙板同时消失
+(void)dissMiss;


@end
