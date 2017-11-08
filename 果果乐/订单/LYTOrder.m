//
//  LYTOrder.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTOrder.h"
#import "LYTOrderCell.h"
#import "LYTOrderModel.h"
#import "LYTOrderDetailVC.h"
#import "LYTGoodsDetailVC.h"
#import "ShopCartVC.h"
@interface LYTOrder ()<UITableViewDelegate,UITableViewDataSource>
{
    int offset;
    NSUInteger refreshCouunt;
}

@property (nonatomic,retain) UILabel *lineLabel;
@property (nonatomic,retain) NSMutableArray *orderArr;
@property (nonatomic,retain) NSMutableArray *sectionOrderArr;
@property(nonnull,retain)UITableView *tableView;
@property(nonatomic, copy) NSString * uid;
@property(nonatomic, copy) NSString * sk;
@property(nonatomic, copy) NSString * orderID;
@end

@implementation LYTOrder


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    _statusBarView.backgroundColor=[UIColor whiteColor];
    _statusBarView.alpha = 1;
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionOrderArr = [NSMutableArray arrayWithCapacity:0];


    self.title = _titleStr;
    
    [self configView];
    [self configTable];
    if (_fromShop == 1 || _fromShop == 2) {
        [self configNav];
    }
    
    
    
}
-(void)configNav{

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)leftBarBtnClick{
    if (_fromShop == 1) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[LYTGoodsDetailVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else if (_fromShop == 2){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ShopCartVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)configView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 38)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/5*_index, 36, kScreenWidth/5, 2)];
    _lineLabel.backgroundColor = [UIColor redColor];
    [headerView addSubview:_lineLabel];
    
    NSArray *arr = @[@"全部",@"待付款",@"待发货",@"待收货",@"已收货"];
    for (int i = 0; i < 5; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/5*i, 5, kScreenWidth/5, 28);
        [headerView addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15*kScreenHeight1];
        [btn setTitleColor:[UIColor xiaobiaotiColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
    }
}
-(void)fiveBtnClick:(UIButton *)sender{
    _index = sender.tag;
    offset = 1;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    NSLog(@"strstrstrstrstr----%@",tokenArr);
    if (sender.tag == 0) {
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10",tokenArr[1],offset]];
    }else if (sender.tag == 1){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=1",tokenArr[1],offset]];
    }else if (sender.tag == 2){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=2",tokenArr[1],offset]];
    }else if (sender.tag == 3){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=3",tokenArr[1],offset]];
    }else if (sender.tag == 4){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=4",tokenArr[1],offset]];
    }
    [UIView animateWithDuration:0.8 animations:^{
        _lineLabel.frame = CGRectMake(kScreenWidth/5*sender.tag, 36, kScreenWidth/5, 2);
    }];
    self.title = sender.titleLabel.text;
}
-(void)configTable{
    _orderArr = [[NSMutableArray alloc]initWithCapacity:0];
    offset  = 1;
    refreshCouunt = 0;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 102, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight =100*kScreenHeight1;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handleRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    [self.tableView registerClass:[LYTOrderCell class] forCellReuseIdentifier:@"LYTOrderCell"];

}
-(void)handleLoadMore{
    offset ++;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    if (_index == 0) {
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10",tokenArr[1],offset]];
    }else if (_index == 1){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=1",tokenArr[1],offset]];
    }else if (_index == 2){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=2",tokenArr[1],offset]];
    }else if (_index == 3){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=3",tokenArr[1],offset]];
    }else if (_index == 4){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=4",tokenArr[1],offset]];
    }
}
-(void)handleRefresh{
    offset = 1;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    if (_index == 0) {
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10",tokenArr[1],offset]];
    }else if (_index == 1){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=1",tokenArr[1],offset]];
    }else if (_index == 2){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=2",tokenArr[1],offset]];
    }else if (_index == 3){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=3",tokenArr[1],offset]];
    }else if (_index == 4){
        [self configRequestWithUrl:[NSString stringWithFormat:GGLSC@"/api/mobile/member/order-list.do?token=%@&page=%d&pageSize=10&status=4",tokenArr[1],offset]];
    }

}
#pragma mark
#pragma mark -------- tableView的代理 -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80+100*[_sectionOrderArr[indexPath.section][@"itemList"] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _sectionOrderArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LYTOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTOrderCell"];
    LYTOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[LYTOrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LYTOrderCell"];
    }
    NSDictionary *dic = _sectionOrderArr[indexPath.section];
    [cell PutDataWithDic:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in _sectionOrderArr[indexPath.section][@"itemList"]) {
        LYTOrderModel *model = [[LYTOrderModel alloc]initWithDictionary:dic];
        [arr addObject:model];
    }
    
    LYTOrderDetailVC *vc = [[LYTOrderDetailVC alloc]init];
    vc.typeCode = _fromShop;
    vc.goodsArr = arr;
    vc.mobile = _sectionOrderArr[indexPath.section][@"mobile"];
    vc.username =  _sectionOrderArr[indexPath.section][@"consignee"];
    vc.useraddress = _sectionOrderArr[indexPath.section][@"full_address"];
    vc.goodsDic = _sectionOrderArr[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ------获取订单列表
-(void)configRequestWithUrl:(NSString *)url{
    NSLog(@"获取订单列表---url---%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取订单列表--%@",responseObject);
        if (offset == 1) {
            [_sectionOrderArr removeAllObjects];
        }

        if ([responseObject[@"data"][@"ordersList"] count] <= 0) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            for (NSDictionary *dic in responseObject[@"data"][@"ordersList"])
            {
                [_sectionOrderArr addObject:dic];
            }
            if (_sectionOrderArr.count == 0){
                Alert_Show(@"您还没有订单信息");
            }
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取订单列表232失败-");
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
