//
//  LYTLifeTableVC.m
//  addProject
//
//  Created by 云盛科技 on 2017/7/24.
//  Copyright © 2017年 神廷. All rights reserved.
//
static NSString * const VendorsListCell = @"LYTVendorsListCell";
static NSString * const VendorsListCell1 = @"LYTVendorsListCell1";
static NSString * const VendorsListCell2 = @"LYTVendorsListCell2";
static NSString * const reuseIdentifier = @"Cell";

#import "LYTLifeTableVC.h"
#import "LYTVendorsListCell.h"
#import "LYTVendorsListCell1.h"
#import "LYTVendorsListCell2.h"



#import "LYTLifeTableModel.h"            //商家列表信息model

#import "MainVC.h"

#import "LYTGoodsDetailVC.h"

#import "LYTOrder.h"
#import "ZjwSearchVC.h"


@interface LYTLifeTableVC ()<UITextFieldDelegate>
{
    int offset;
}
@property(nonatomic,retain)NSArray          *titleArr;          //标题数组
@property(nonatomic,retain)NSMutableArray   *reXiaoArr;         //热销商品数组
@property(nonatomic,retain)NSMutableArray   *zuiXinArr;         //最新商品数组
@property(nonatomic,retain)NSMutableArray   *jingPinArr;        //精品推荐数组




@end

@implementation LYTLifeTableVC

-(NSMutableArray *)reXiaoArr{
    if (!_reXiaoArr) {
        _reXiaoArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _reXiaoArr;
}
-(NSMutableArray *)jingPinArr{
    if (!_jingPinArr) {
        _jingPinArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _jingPinArr;
}
-(NSMutableArray *)zuiXinArr{
    if (!_zuiXinArr) {
        _zuiXinArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _zuiXinArr;
}



-(id)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if (self=[super initWithCollectionViewLayout:layout]) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"endFullScreen" object:nil];
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle=UIBarStyleDefault;
    UIView *atusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    atusBarView.backgroundColor=[UIColor clearColor];
    atusBarView.alpha = 1;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.collectionView.contentInset = UIEdgeInsetsZero;
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor backGray];
    
    _titleArr = @[@"最新上架",@"精品推荐",@"热销商品"];
    
    offset = 0;
    
    [self configSeachVC];
    
    //请求热销商品
    [self requestHotSellGoods];
    //请求最新上架
    [self requestNewReleasesGoods];
    //请求精品推荐
    [self requestProductsRecommendGoods];
    
    UICollectionViewFlowLayout * Layout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:Layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.collectionView.backgroundColor = [UIColor backGray];
    [self.collectionView registerClass:[LYTVendorsListCell class] forCellWithReuseIdentifier:VendorsListCell];
    [self.collectionView registerClass:[LYTVendorsListCell1 class] forCellWithReuseIdentifier:VendorsListCell1];
    [self.collectionView registerClass:[LYTVendorsListCell2 class] forCellWithReuseIdentifier:VendorsListCell2];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    self.collectionView.frame = CGRectMake( 0, -64, 375 * kScreenWidth1, 667 * kScreenHeight1 + 20);
    
}
-(void)handleLoadMore{
    offset += 10;
    //请求热销商品
    [self requestHotSellGoods];
}

-(void)configSeachVC{
    
    UIView *textBackView = [[UIView alloc]initWithFrame:WDH_CGRectMake(0, 0,320, 30)];
    textBackView.backgroundColor = [UIColor backGray];
    textBackView.layer.cornerRadius = 15;
    textBackView.layer.masksToBounds = YES;
//    textBackView.alpha = 0.4;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(15, 5, 20, 20)];
    img.image = [UIImage imageNamed:@"搜索_搜索 copy 4@3x"];
    [textBackView addSubview:img];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:WDH_CGRectMake(45, 0, 260, 30)];
    textField.delegate = self;
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleNone;
    [textBackView addSubview:textField];
    self.navigationItem.titleView = textBackView;
    self.navigationItem.titleView.alpha = 0.7;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"点击确定键执行方法走不走---%@",textField.text);
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"是不是开始编辑就执行");
    ZjwSearchVC * zjwVC = [[ZjwSearchVC alloc] init];
    [self.navigationController pushViewController:zjwVC animated:YES];
    //加个蒙板
    return YES;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 3){
        return self.reXiaoArr.count + 1;
    }else{
        return 5;
    }
    
}

//每个item的规格
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        return CGSizeMake(375 * kScreenWidth1 , 340 * kScreenHeight1);
        
    } else  {
        if (indexPath.row == 0) {
            return CGSizeMake(365 * kScreenWidth1 , 30 * kScreenHeight1 );
        }else{
            return CGSizeMake(180 * kScreenWidth1, 260 * kScreenHeight1);
        }
    }
}

//每个item横向之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0.0f ;
    } else  {
        return 5.0f * kScreenWidth1;
    }
}
//每个item纵向之间的间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0.0f ;
    } else  {
        return 5.0f * kScreenHeight1;
    }
}
//设置边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0) ;
    } else if (section == 1) {
        return UIEdgeInsetsMake(5, 5, 5, 5) ;
    } else {
        return UIEdgeInsetsMake(5, 5, 5, 5) ;
    }
}

////头尾
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return CGSizeMake(375 , 0 );;
//    } else  {
//        return CGSizeMake(375 , 10);
//    }
//}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LYTVendorsListCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VendorsListCell2 forIndexPath:indexPath];
        cell.btn1.clickBtn.tag = 0;
        [cell.btn1.clickBtn addTarget:self action:@selector(VendorsCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn2.clickBtn.tag = 1;
        [cell.btn2.clickBtn addTarget:self action:@selector(VendorsCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn3.clickBtn.tag = 2;
        [cell.btn3.clickBtn addTarget:self action:@selector(VendorsCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn4.clickBtn.tag = 3;
        [cell.btn4.clickBtn addTarget:self action:@selector(VendorsCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn5.clickBtn.tag = 4;
        [cell.btn5.clickBtn addTarget:self action:@selector(VendorsCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        if (indexPath.row == 0) {
            LYTVendorsListCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VendorsListCell1 forIndexPath:indexPath];
            cell.titleLabel.text = _titleArr[indexPath.section - 1];
            return cell;
        }else{
            LYTLifeTableModel *model;
            if (self.zuiXinArr.count > 3) {
                if (indexPath.section == 1) {
                    model = self.zuiXinArr[indexPath.row - 1];
                }else if (indexPath.section == 2){
                    model = self.jingPinArr[indexPath.row - 1];
                }else{
                    model = self.reXiaoArr[indexPath.row - 1];
                }
            }
            LYTVendorsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VendorsListCell forIndexPath:indexPath];
//            cell.frame = CGRectMake(0, 0, 180, 260);
            [cell.img sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"img_error"]];
            cell.titleLabel.text = model.name;
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.price];
            cell.contentLabel.text = @"";
            cell.jiFenLabel.text = [NSString stringWithFormat:@"赠送%ld积分",model.point/100];
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
    }
    
}
-(void)VendorsCellBtnClick:(UIButton *)sender{
    NSLog(@"VendorsCellBtnClick---%ld",sender.tag);
    if (sender.tag == 0) {
        self.tabBarController.selectedIndex = 1;
    }else if (sender.tag == 1){
        [self LoginRequest];
    }else if (sender.tag == 2){
        LYTOrder *vc = [[LYTOrder alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 3){
        self.tabBarController.selectedIndex = 3;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        LYTLifeTableModel *model;
        if (self.zuiXinArr.count > 3) {
            if (indexPath.section == 1) {
                model = self.zuiXinArr[indexPath.row - 1];
            }else if (indexPath.section == 2){
                model = self.jingPinArr[indexPath.row - 1];
            }else{
                model = self.reXiaoArr[indexPath.row - 1];
            }
        }
        LYTGoodsDetailVC *vc = [[LYTGoodsDetailVC alloc]init];
        
        vc.goodsId = [NSString stringWithFormat:@"%ld",model.goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark -------NetWorkRequest----------

//最新上架
-(void)requestNewReleasesGoods{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSC@"/api/shop/goods/tag-list.do?tagid=100010&start=0&length=10"] completeWithBlock:^(NSDictionary *responseObject) {
//        NSLog(@"请求最新上架商品列表-------%@",responseObject);
        [self.zuiXinArr removeAllObjects];
        for (NSDictionary *dic in responseObject[@"data"]) {
//            NSLog(@"asdasd--asd-as-d----%@",dic);
            LYTLifeTableModel *model = [[LYTLifeTableModel alloc]initWithDictionary:dic];
            [self.zuiXinArr addObject:model];
        }
        [self.collectionView reloadData];
    } WithError:^(NSString *errorStr) {
        NSLog(@"最新上架商品列表失败-------%@",errorStr);
    }];
}

//请求精品推荐
-(void)requestProductsRecommendGoods{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSC@"/api/shop/goods/tag-list.do?tagid=100011&start=0&length=10"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求精品推荐商品列表-------%@",responseObject);
        for (NSDictionary *dic in responseObject[@"data"]) {
//            NSLog(@"asdasd--asd-as-d----%@",dic);
            LYTLifeTableModel *model = [[LYTLifeTableModel alloc]initWithDictionary:dic];
            [self.jingPinArr addObject:model];
        }
        [self.collectionView reloadData];
    } WithError:^(NSString *errorStr) {
        NSLog(@"精品推荐商品列表失败-------%@",errorStr);
    }];
}

//请求热销商品
-(void)requestHotSellGoods{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSC@"/api/shop/goods/tag-list.do?tagid=100012&start=%d&length=10",offset] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求热销商品列表-------%@",responseObject);
        NSArray *arr = responseObject[@"data"];
        if (arr.count <= 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            for (NSDictionary *dic in responseObject[@"data"]) {
                LYTLifeTableModel *model = [[LYTLifeTableModel alloc]initWithDictionary:dic];
                [self.reXiaoArr addObject:model];
            }
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
        }
        
    } WithError:^(NSString *errorStr) {
        NSLog(@"热销商品列表失败-------%@",errorStr);
    }];
}
//登录请求
- (void) LoginRequest {
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"Basic YXBwOjEyMzQ1Ng==" forHTTPHeaderField:@"Authorization"];
    //, [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"]
    NSLog(@"refresh_token:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"]);
    [manager POST:[NSString stringWithFormat:GGL@"/oauth/token?grant_type=refresh_token&refresh_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录请求%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",responseObject[@"access_token"]];
        NSLog(@"tokentoken%@",tokenStr);
        
        if (responseObject[@"access_token"] != nil) {
            [[NSUserDefaults standardUserDefaults]setObject:tokenStr  forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"refresh_token"] forKey:@"refresh_token"];
            MainVC * mainVC = [[MainVC alloc] init];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"error---%@",error);
        self.tabBarController.selectedIndex = 3;
        
    }];
    
    
}

@end
