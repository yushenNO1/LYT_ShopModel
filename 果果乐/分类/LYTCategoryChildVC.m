//
//  LYTCategoryChildVC.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/15.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTCategoryChildVC.h"
#import "LYTCategoryChildCell.h"
#import "LYTCategoryChildCell1.h"

#import "LYTGoodsDetailVC.h"
#import "ZjwSearchVC.h"
@interface LYTCategoryChildVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation LYTCategoryChildVC
static NSString * const CategoryChildCell = @"LYTCategoryChildCell";
static NSString * const CategoryChildCell1 = @"LYTCategoryChildCell1";
static NSString * const reuseIdentifier = @"Cell";



-(id)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if (self=[super initWithCollectionViewLayout:layout]) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    UICollectionViewFlowLayout * Layout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:Layout];
    self.collectionView.delegate =self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[LYTCategoryChildCell class] forCellWithReuseIdentifier:CategoryChildCell];
    [self.collectionView registerClass:[LYTCategoryChildCell1 class] forCellWithReuseIdentifier:CategoryChildCell1];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)categoryWithData:(NSArray *)arr{
//    NSLog(@"sadad----adself.%ld",arr.count);
    self.dataArr = arr;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArr[section][@"tmenu"] count]+1;
    
}

//每个item的规格
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(295 * kScreenWidth1, 30 * kScreenHeight1);
    }else{
        return CGSizeMake(93 * kScreenWidth1 , 113 * kScreenHeight1);
    }
    
}

//每个item横向之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f * kScreenWidth1;
    
}
//每个item纵向之间的间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f * kScreenHeight1;
    
}
//设置边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5 * kScreenHeight1, 5 * kScreenWidth1, 5 * kScreenHeight1, 5 * kScreenWidth1) ;
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        LYTCategoryChildCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryChildCell1 forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        NSDictionary *dic = self.dataArr[indexPath.section];
        cell.titleLabel.text = dic[@"text"];
        return cell;
    }else{
        LYTCategoryChildCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryChildCell forIndexPath:indexPath];
        NSDictionary *dic = self.dataArr[indexPath.section];    //多少区
        NSArray *rowArr = dic[@"tmenu"];                        //多少行
        NSDictionary *rowData = rowArr[indexPath.row - 1];      //每个itme数据
        [cell.img sd_setImageWithURL:[NSURL URLWithString:rowData[@"image"]] placeholderImage:[UIImage imageNamed:@"img_error"]];
        cell.titleLabel.text = rowData[@"text"];
        
        return cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"第%ld区----第%ld行------啥也不干",indexPath.section,indexPath.row);
    }else{
        NSDictionary *dic = self.dataArr[indexPath.section];    //多少区
        NSArray *rowArr = dic[@"tmenu"];                        //多少行
        NSDictionary *rowData = rowArr[indexPath.row - 1];      //每个itme数据
        
        NSLog(@"第%ld区----第%ld行------数据----%@",indexPath.section,indexPath.row,rowData);
        
        
        ZjwSearchVC * zjwVC = [[ZjwSearchVC alloc] init];
        zjwVC.cai_id = rowData[@"id"];
        [self.navigationController pushViewController:zjwVC animated:YES];
        
//        LYTGoodsDetailVC *vc = [[LYTGoodsDetailVC alloc]init];
//        vc.goodsId = rowData[@"id"];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
