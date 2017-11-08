//
//  ZjwSearchVC.m
//  LSK
//
//  Created by 张敬文 on 2017/1/18.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏

#import "ZjwSearchVC.h"
#import "LYTVendorsListCell.h"
#import "LYTGoodsDetailVC.h"
@interface ZjwSearchVC ()<UISearchBarDelegate, UISearchControllerDelegate, UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    int cursor;
}
//搜索
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *shopsArray;
@property(nonatomic,retain)NSDictionary *myInfo;
@end

@implementation ZjwSearchVC

static NSString * const VendorsListCell = @"LYTVendorsListCell";
static NSString * const reuseIdentifier = @"Cell";

//懒加载数组
-(NSMutableArray *)shopsArray {
    if (!_shopsArray) {
        self.shopsArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _shopsArray;
}

-(id)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if (self=[super initWithCollectionViewLayout:layout]) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    _statusBarView.backgroundColor=[UIColor whiteColor];
    _statusBarView.alpha = 1;
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    UICollectionViewFlowLayout * Layout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:Layout];
    self.collectionView.delegate =self;
    self.collectionView.backgroundColor = [UIColor backGray];
    self.collectionView.dataSource = self;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.collectionView registerClass:[LYTVendorsListCell class] forCellWithReuseIdentifier:VendorsListCell];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSLog(@"ads--search----%@",_cai_id);
    if ([[_cai_id class] isEqual:[NSNull class]]) {
        
    }else if (_cai_id==nil){
        
    }else{
        [self configRequest1];
    }
    
    [self SearchView];
    [self setNavigationBarConfiguer];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    
}
-(void)handleLoadMore{
    cursor += 10;
    //请求热销商品
    if ([[_cai_id class] isEqual:[NSNull class]]) {
        [self configRequest];
    }else if (_cai_id==nil){
        [self configRequest];
    }else{
        [self configRequest1];
    }
    
}



- (void)setNavigationBarConfiguer {
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItemAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void) rightBarButtonItemAction {
    [self.searchBar resignFirstResponder];
}




//搜索
- (void) SearchView {
    self.searchBar = [[UISearchBar alloc]initWithFrame:WDH_CGRectMake(0,0,200,30)];
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor blackColor];
    self.searchBar.barStyle = 0;
    self.searchBar.backgroundColor = [UIColor grayColor];
    UIView * aView = [[UIView alloc] initWithFrame:WDH_CGRectMake(0, 0, 200, 30)];
    aView.layer.cornerRadius = 5;
    aView.layer.masksToBounds = YES;
    [aView addSubview:self.searchBar];
    self.navigationItem.titleView = aView;
    [self searchBarShouldBeginEditing:_searchBar];
    [_searchBar becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [self.searchBar resignFirstResponder];
}

//将要开始编辑时的回调，返回为NO，则不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    return YES;
}

//将要结束编辑时的回调
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
{
    cursor = 0;
    [self configRequest];
    [self.searchBar resignFirstResponder];
    return YES;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.shopsArray.count;
    
}

//每个item的规格
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(180 *kScreenWidth1 , 260 *kScreenHeight1);
    
    
}

//每个item横向之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f ;
    
}
//每个item纵向之间的间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f;
    
}
//设置边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5) ;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYTVendorsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VendorsListCell forIndexPath:indexPath];
    NSDictionary *dic = self.shopsArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:dic[@"big"]] placeholderImage:[UIImage imageNamed:@"img_error"]];
    cell.titleLabel.text = dic[@"name"];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"price"] doubleValue]];
    cell.contentLabel.text = @"";
    cell.jiFenLabel.text = [NSString stringWithFormat:@"赠送%d积分",[dic[@"point"] intValue]/100];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.shopsArray[indexPath.row];
    NSLog(@"dicdicdic---%@",dic);
    LYTGoodsDetailVC *vc = [[LYTGoodsDetailVC alloc]init];
    
    vc.goodsId = [NSString stringWithFormat:@"%ld",[dic[@"goods_id"] integerValue]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shareBtnClick:(UIButton *)sender{
    //分享
    _myInfo =[[NSUserDefaults standardUserDefaults]objectForKey:@"MyInfo"];
//    SYMainShop *model = self.shopsArray[sender.tag];
//    if (_myInfo[@"userVo"][@"spreadCode"] != nil) {
//        [LYTShareVC shareImage:[NSString stringWithFormat:@"%@%@",LSKurl1,model.picName] Title:model.title content:@"爆款推荐" AndUrl:[NSString stringWithFormat:shareUrl,model.goods_id,_myInfo[@"userVo"][@"spreadCode"]]];
//    }else{
////        Alert_go_push(SYLoginPage, @"您还没有登陆,请前往登录")
//    }
}
#pragma mark ------netWork
-(void)configRequest{
    
    NSString *str = [_searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/goods/search.do?keyword=%@&start=%d&length=10",str,cursor];
    [WDHRequest requestAllListWith:urlStr completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"商品搜索列表%@", responseObject);
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]){
            if ([responseObject[@"data"]count] <= 0) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                if (cursor == 0) {
                    [self.shopsArray removeAllObjects];
                }
                [self.shopsArray addObjectsFromArray:responseObject[@"data"]];
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        [self.collectionView reloadData];
        
    } WithError:^(NSString *errorStr) {
        NSLog(@"邀请明细列表请求失败%@", errorStr);
        
    }];
}

-(void)configRequest1{
    

    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/goods/search.do?cat=%@&start=%d&length=10",_cai_id,cursor];
    [WDHRequest requestAllListWith:urlStr completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"商品搜索列表%@", responseObject);
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]){
            if ([responseObject[@"data"]count] <= 0) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                if (cursor == 0) {
                    [self.shopsArray removeAllObjects];
                }
                [self.shopsArray addObjectsFromArray:responseObject[@"data"]];
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        [self.collectionView reloadData];
        
    } WithError:^(NSString *errorStr) {
        NSLog(@"邀请明细列表请求失败%@", errorStr);
        
    }];
}
@end
