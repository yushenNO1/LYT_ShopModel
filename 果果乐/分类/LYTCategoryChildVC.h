//
//  LYTCategoryChildVC.h
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTCategoryChildVC : UICollectionViewController
@property(nonatomic,assign)int index;
@property(nonatomic,retain)NSArray *dataArr;
-(void)categoryWithData:(NSArray *)arr;
@end
