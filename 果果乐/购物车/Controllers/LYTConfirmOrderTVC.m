//
//  LYTConfirmOrderTVC.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏

#import "LYTConfirmOrderTVC.h"
#import "LYTAdressCell.h"
#import "LYTConfirmGoodsCell.h"
#import "WSSShippingAddressViewController.h"
#import "WSSShippingAddressModel.h"
#import "LYTShopCartModel.h"
#import "LYTSubmitOrdersVC.h"
@interface LYTConfirmOrderTVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray *titleArr;
@property(nonatomic,retain)NSArray *contentArr;
@property(nonatomic,retain)UITableView *LYTTableView;


@property(nonatomic,retain) UILabel *amountLabel;
@property(nonatomic,retain) UILabel *countLabel;

//地址信息
@property(nonatomic,copy)NSString *useraddress;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *addressID;
@property(nonatomic,copy)NSString *mobile;

@end

@implementation LYTConfirmOrderTVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"商品金额",@"赠送积分",@"运费",@"应付金额"];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self configTable];
    [self configView];
    [self notification];
    
    [self getAdressList];
    
}
-(void)configTable{
    _LYTTableView = [[UITableView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 667 - 40) style:UITableViewStylePlain];
    _LYTTableView.delegate = self;
    _LYTTableView.dataSource = self;
    _LYTTableView.separatorStyle = NO;
    [self.view addSubview:_LYTTableView];
    [_LYTTableView registerClass:[LYTConfirmGoodsCell class] forCellReuseIdentifier:@"LYTConfirmGoodsCell"];
    [_LYTTableView registerClass:[LYTAdressCell class] forCellReuseIdentifier:@"LYTAdressCell"];
    [_LYTTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _LYTTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
-(void)configView{
    NSLog(@"LYTConfirmOrderTVC---_type---%d",_type);
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 627*kScreenHeight1-64, 375*kScreenWidth1, 40*kScreenHeight1)];
    if (_type == 1) {
        footView.frame = WDH_CGRectMake(0, 667-40, 375, 40);
    }
    footView.backgroundColor = [UIColor backGray];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    
    UILabel *aaa = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375 - 280, 10, 60, 20)];
    aaa.text = @"总金额:";
    aaa.font = [UIFont systemFontOfSize:14];
    aaa.textColor = [UIColor xiaobiaotiColor];
    [footView addSubview:aaa];
    
    _amountLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375 - 220, 10, 180, 20)];
    _amountLabel.text = @"¥0.00";
    _amountLabel.font = [UIFont systemFontOfSize:18];
    _amountLabel.textColor = [UIColor anniuColor];
    [footView addSubview:_amountLabel];
    
    _countLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 10, 60, 20)];
    [footView addSubview:_countLabel];
    _countLabel.font = [UIFont systemFontOfSize:14];
    
    
    _amountLabel.text = [NSString stringWithFormat:@"%.2f",[_goodsAllPrice doubleValue] + [_yunfei doubleValue]];
    _contentArr = @[_goodsAllPrice,_sendJiFen,_yunfei,_amountLabel.text];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = WDH_CGRectMake(375 - 110, 0, 110, 40);
    btn.backgroundColor = [UIColor anniuColor];
    btn.tag = 998855;
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jiesuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    
    for (LYTShopCartModel *model in _goodsArr) {
        if ([model.freight_type intValue] == 2) {
//            cell.daoFuLabel.text = @"本商品暂时不支持当前位置发货";
            btn.backgroundColor = [UIColor xiaobiaotiColor];
            btn.enabled = NO;
        }else if ([model.freight_type intValue] == 3){
//            cell.daoFuLabel.text = @"本商品为到付商品";
            btn.backgroundColor = [UIColor anniuColor];
            btn.enabled = YES;
        }else{
//            cell.daoFuLabel.hidden = YES;
            btn.backgroundColor = [UIColor anniuColor];
            btn.enabled = YES;
        }
    }
}
-(void)notification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiCenterHave:) name:@"addrssID" object:nil];
}
-(void)notiCenterHave:(NSNotification *)sender{
    WSSShippingAddressModel *model = sender.userInfo[@"addrssId"];
    _username = model.name;
    _useraddress = _useraddress = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.region,model.addr];
    _addressID = model.addr_id;
    _mobile = model.mobile;
    NSLog(@"-----重新选择的收货地址id----%@",model.addr_id);
    [self getSelectShopsRequestWithRegionId:model.region_id];
 
}


#pragma mark - Table view data source
#pragma mark ----------- tablewView的代理 -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 100*kScreenHeight1;
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2){
        return 44;
    }else{
        return 25;
    }
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    }else{
        return 10;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return _titleArr.count;
    }else if(section == 1){
        return _goodsArr.count;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        LYTAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTAdressCell"];
        cell.adressLabel.text = _useraddress;
        cell.nameLabel.text = _username;
        cell.phone.text = _mobile;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        LYTConfirmGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTConfirmGoodsCell"];
        LYTShopCartModel *model = _goodsArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"商品数量-----%d",model.goods_num);
        cell.countLabel.text = [NSString stringWithFormat:@"x%d",model.goods_num];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.goods_name];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.original_img]] placeholderImage:[UIImage imageNamed:@"img_error"]];
        cell.specLabel.text = [NSString stringWithFormat:@"%@",model.spec_key_name];
        
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
        
        cell.daoFuLabel.hidden = NO;
        if ([model.freight_type intValue] == 2) {
            cell.daoFuLabel.text = @"本商品暂时不支持当前位置发货";
        }else if ([model.freight_type intValue] == 3){
            cell.daoFuLabel.text = @"本商品为到付商品";
        }else{
            cell.daoFuLabel.hidden = YES;
        }
    
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            UITextField *textField = [[UITextField alloc]initWithFrame:WDH_CGRectMake(80, 12, 375 - 90, 20)];
            textField.placeholder = @"易碎品,运费会贵一点哦.";
            [cell addSubview:textField];
        }
        cell.textLabel.text = @"备注:";

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _titleArr[indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",[_contentArr[indexPath.row] doubleValue]];
        return cell;
    }
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            WSSShippingAddressViewController *vc = [[WSSShippingAddressViewController alloc]init];
            vc.type = _type;
            vc.orderStr = @"adress";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
-(void)jiesuanBtnClick:(UIButton *)sender{
    
    
    [self createOrderRequuestWithAddressId:_addressID];
//    LYTSubmitOrdersVC *vc = [[LYTSubmitOrdersVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -------- 请求 >>> 获取地址列表 -----------
-(void)getAdressList
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/member-address/list.do?token=%@",tokenArr[1]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"获取地址列表--%@",responseObject);
        NSArray *arr = responseObject[@"data"][@"addressList"];
        if (arr.count <= 0) {
            Alert_Show(@"没有收货地址,前往添加")
        }else{
            WSSShippingAddressModel *model = [[WSSShippingAddressModel alloc]initWithDictionary:responseObject[@"data"][@"defaultAddress"] ];
            _username = model.name;
            _useraddress = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.region,model.addr];
            _addressID = model.addr_id;
            _mobile = model.mobile;
            

        }
        
        [self.LYTTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取地址列表232失败-");
        
    }];
}

#pragma  mark -----------购物车查询选中列表
- (void) getSelectShopsRequestWithRegionId:(NSString *)regionId {
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/checkout-total.do?token=%@&regionId=%@",tokenArr[1],regionId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"购物车查询选中列表----%@",responseObject);
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
            LYTShopCartModel *model = [[LYTShopCartModel alloc]initWithDictionary:dic];
            [arr addObject:model];
        }
        self.yunfei = responseObject[@"data"][@"orderPrice"][@"shippingPrice"];
        self.goodsAllPrice = responseObject[@"data"][@"orderPrice"][@"goodsPrice"];
        self.goodsArr = arr;
        self.sendJiFen = responseObject[@"data"][@"orderPrice"][@"point"];
        [self.LYTTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----购物车查询选中列表-");
        
    }];
}

-(void)createOrderRequuestWithAddressId:(NSString *)addressId{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/order/create.do?token=%@&addressId=%@",tokenArr[1],addressId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"结算  创建订单--%@",responseObject);
        LYTSubmitOrdersVC *vc = [[LYTSubmitOrdersVC alloc]init];
        vc.order_sn = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order"][@"sn"]];
        vc.heji = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order"][@"order_amount"]];
        vc.balance = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order"][@"user_money"]];
        vc.orderPay = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order"][@"total_amount"]];
        vc.order_id = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order"][@"order_id"]];;
        vc.typecode = _type;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"结算  创建订单232失败-");
        
    }];
}


@end
