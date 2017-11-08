//
//  ShopCartVC.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "ShopCartVC.h"
#import "LYTShopCartCell.h"
#import "LYTShopCartModel.h"
#import "LYTShopCartheaderCell.h"


#import "LYTConfirmOrderTVC.h"
#import "WSSShippingAddressViewController.h"
#import "WSSShippingAddressModel.h"

@interface ShopCartVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *addressId;
}
@property(nonatomic,retain) UITableView *LYTTableView;
@property(nonatomic,retain) NSMutableArray *ShopCartArr;

@property(nonatomic,retain) UILabel *amountLabel;
@property(nonatomic,retain) UILabel *countLabel;
@property(nonatomic,assign) float amount;
@property(nonatomic,assign) int count;


//记录传值
@property(nonatomic,retain) NSMutableDictionary *goodsNumDic;
@property(nonatomic,retain) NSMutableDictionary *goodsSelectDic;

@property(nonatomic,retain) UIView *footView;

@property(nonatomic,assign) int fail_count;

@end

@implementation ShopCartVC


-(NSMutableArray *)ShopCartArr{
    if (!_ShopCartArr) {
        _ShopCartArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _ShopCartArr;
}

-(NSMutableDictionary *)goodsNumDic{
    if (!_goodsNumDic) {
        _goodsNumDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _goodsNumDic;
}
-(NSMutableDictionary *)goodsSelectDic{
    if (!_goodsSelectDic) {
        _goodsSelectDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _goodsSelectDic;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setValue:@(1)forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle=UIBarStyleDefault;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    NSLog(@"_type_type_type---%d",_type);
    if (_type != 1) {
        self.tabBarController.tabBar.hidden = NO;
    }
    //状态栏
    UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    _statusBarView.backgroundColor=[UIColor whiteColor];
    _statusBarView.alpha = 1;
    self.navigationController.navigationBar.alpha = 1;
    [self configRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"返回";
    self.view.backgroundColor = [UIColor backGray];
    self.navigationItem.backBarButtonItem = backButtonItem;
    [self configTable];
    [self configView];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)configView{
    _footView = [[UIView alloc]initWithFrame:WDH_CGRectMake(0, 667-150, 375, 40)];
    if (_type == 1) {
        _footView.frame = WDH_CGRectMake(0, 667-40, 375, 40);
    }
    _footView.backgroundColor = [UIColor backGray];
    [self.view addSubview:_footView];
    
    _countLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 10, 60, 20)];
    _countLabel.text = @"共0件";
    _countLabel.font = [UIFont systemFontOfSize:14];
    _countLabel.textColor = [UIColor xiaobiaotiColor];
    [_footView addSubview:_countLabel];
    
    UILabel *aaa = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375 - 280, 10, 60, 20)];
    aaa.text = @"总金额:";
    aaa.font = [UIFont systemFontOfSize:14];
    aaa.textColor = [UIColor xiaobiaotiColor];
    [_footView addSubview:aaa];
    
    _amountLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375 - 220, 10, 180, 20)];
    _amountLabel.text = @"¥0.00";
    _amountLabel.font = [UIFont systemFontOfSize:18];
    _amountLabel.textColor = [UIColor anniuColor];
    [_footView addSubview:_amountLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = WDH_CGRectMake(265, 0, 110, 40);
    btn.backgroundColor = [UIColor anniuColor];
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jiesuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:btn];
}
-(void)configTable{
    _LYTTableView = [[UITableView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 667-44) style:UITableViewStylePlain];
    if (_type == 1) {
        _LYTTableView.frame = WDH_CGRectMake(0, 0, 375, 667);
    }else{
        _LYTTableView.frame = WDH_CGRectMake(0, 0, 375, 667-90);
    }
    _LYTTableView.delegate = self;
    _LYTTableView.dataSource = self;
    [_LYTTableView registerClass:[LYTShopCartCell class] forCellReuseIdentifier:@"LYTShopCartCell"];
    [_LYTTableView registerClass:[LYTShopCartheaderCell class] forCellReuseIdentifier:@"LYTShopCartheaderCell"];
    [self.view addSubview:_LYTTableView];
    [self setExtraCellLineHidden:_LYTTableView];
}
//删除多余的线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 100;
        }
    }else{
        return 100;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.ShopCartArr.count--%ld",self.ShopCartArr.count);
    
    return self.ShopCartArr.count ;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        LYTShopCartheaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTShopCartheaderCell"];
        LYTShopCartModel *model = self.ShopCartArr[indexPath.row];
        
        [cell.isChooseAllBtn addTarget:self action:@selector(isChooseAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (model.isChoose == 0) {
            [cell.isChooseAllBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_no"] forState:UIControlStateNormal];
        }else{
            [cell.isChooseAllBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_ok"] forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _amount = 0;
        _count = 0;
        _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
        _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
        for (LYTShopCartModel *model in _ShopCartArr) {
            if (model.isChoose == 1) {
                _amount = model.goods_num * [model.goods_price doubleValue] + _amount;
                _count = model.goods_num + _count;
                _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
                _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
            }
        }
        
        return cell;
    }else{
        LYTShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTShopCartCell"];
        
        LYTShopCartModel *model = _ShopCartArr[indexPath.row];
        cell.countLabel.text = [NSString stringWithFormat:@"%d",model.goods_num];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.goods_name];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.original_img]] placeholderImage:[UIImage imageNamed:@"img_error"]];
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
        cell.specLabel.text = [NSString stringWithFormat:@"%@",model.spec_key_name];
        if (model.goods_num == 1) {
            cell.subBtn.backgroundColor = [UIColor grayColor];
        }else{
            cell.subBtn.backgroundColor = [UIColor anniuColor];
        }
        cell.subBtn.enabled = YES;
        cell.addBtn.enabled = YES;
        cell.addBtn.backgroundColor = [UIColor anniuColor];
        [cell.addBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
        cell.addBtn.tag = indexPath.row;
        [cell.subBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
        cell.subBtn.tag = indexPath.row +10000;
        [cell.isChooseBtn addTarget:self action:@selector(isChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.isChooseBtn setTitle:@"" forState:UIControlStateNormal ];
        cell.isChooseBtn.enabled = YES;
        cell.isChooseBtn.layer.masksToBounds = NO;
        cell.isChooseBtn.layer.borderWidth = 0;
        cell.isChooseBtn.frame = WDH_CGRectMake(0, 0, 30, 100);
        if (model.isChoose == 0) {
            cell.isChooseImg.image = [UIImage imageNamed:@"pay_mark_no"];
        }else{
            cell.isChooseImg.image = [UIImage imageNamed:@"pay_mark_ok"];
        }
        cell.isChooseBtn.tag = indexPath.row;
        
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//商品数量改变
-(void)changeCount:(UIButton *)sender{
    LYTShopCartCell *cell = (LYTShopCartCell *)[sender superview];
    if (sender.tag >= 10000 ) {
        LYTShopCartModel *model = _ShopCartArr[sender.tag - 10000];
        if (model.goods_num > 1) {
            cell.countLabel.text = [NSString stringWithFormat:@"%d",model.goods_num --];
            [_goodsNumDic removeObjectForKey:model.idCode];
            [_goodsNumDic setObject:[NSString stringWithFormat:@"%d",model.goods_num] forKey:model.idCode];
        }else{
            cell.countLabel.text = @"1";
        }
        [self changeShopCartCountRequestWithId:model.idCode shopCount:model.goods_num -- productid:model.product_id];
    }else{
        LYTShopCartModel *model = _ShopCartArr[sender.tag ];
        cell.countLabel.text = [NSString stringWithFormat:@"%d",model.goods_num ++];
        [_goodsNumDic removeObjectForKey:model.idCode];
        [_goodsNumDic setObject:[NSString stringWithFormat:@"%d",model.goods_num] forKey:model.idCode];
        [self changeShopCartCountRequestWithId:model.idCode shopCount:model.goods_num ++ productid:model.product_id];
    }
    _amount = 0;
    _count = 0;
    _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
    _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
    for (LYTShopCartModel *model in _ShopCartArr) {
        if (model.isChoose == 1) {
            _amount = model.goods_num * [model.goods_price doubleValue] + _amount;
            _count = model.goods_num + _count;
            _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
            _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
        }
        
    }
    
    [_LYTTableView reloadData];
}
//商品选择
-(void)isChooseBtnClick:(UIButton *)sender{
    
    //单个商品点击事件
    LYTShopCartModel *model = _ShopCartArr[sender.tag];
    if (model.isChoose == 0) {
        model.isChoose = 1;
    }else{
        model.isChoose = 0;
    }
    [_goodsSelectDic removeObjectForKey:model.idCode];
    [_goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model.isChoose] forKey:model.idCode];
    
    //判断商品是否全部勾选
    int reference = 0 ;
    if (_ShopCartArr.count >= 2) {
        LYTShopCartModel *model = _ShopCartArr[1];
        reference = model.isChoose;
    }
    LYTShopCartModel *model01 = _ShopCartArr[0];
    for (int i = 1; i < _ShopCartArr.count; i ++) {
        LYTShopCartModel *model = _ShopCartArr[i];
        if (model.isChoose == reference) {
            model01.isChoose = reference;
        }else{
            model01.isChoose = 0;
        }
    }
    [_goodsSelectDic removeObjectForKey:@"全选"];
    [_goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model01.isChoose] forKey:@"全选"];
    [self didSelectRequestShopCartid:model.product_id changeStatus:model.isChoose] ;
    
    
    
    
    
}
-(void)isChooseAllBtnClick:(UIButton *)sender{
    _amount = 0;
    _count = 0;
    _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
    _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
    
    //全选
    LYTShopCartModel *model1 = _ShopCartArr[0];
    [_goodsSelectDic removeObjectForKey:@"全选"];
    [_goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model1.isChoose] forKey:@"全选"];
    if (model1.isChoose == 0) {
        for (int i = 1; i < _ShopCartArr.count; i ++ ){
            
            LYTShopCartModel *model = _ShopCartArr[i];
            model.isChoose = 1;
            [_goodsSelectDic removeObjectForKey:model.idCode];
            [_goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model.isChoose] forKey:model.idCode];
            _amount = model.goods_num * [model.goods_price doubleValue] + _amount;
            _count = model.goods_num + _count;
            _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
            _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
        }
        [self didSelectAllRequestChangeStatus:1];
    }else{
        for (int i = 1; i < _ShopCartArr.count; i ++){
            
            LYTShopCartModel *model = _ShopCartArr[i];
            model.isChoose = 0;
            [_goodsSelectDic removeObjectForKey:model.idCode];
            [_goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model.isChoose] forKey:model.idCode];
            
        }
        [self didSelectAllRequestChangeStatus:0];
    }
    
}
-(void)deleteBtnClick:(UIButton *)sender{
    
    LYTShopCartModel *model = _ShopCartArr[sender.tag];
    [_goodsNumDic removeObjectForKey:model.idCode];
    [_goodsSelectDic removeObjectForKey:model.idCode];
    [_ShopCartArr removeObjectAtIndex:sender.tag];
    
    [self delegateRequestShopCartid:model.idCode];
}
//结算
-(void)jiesuanBtnClick:(UIButton *)sender{
    
    [self getAdressList];
}
-(void)dissBtnClick:(UIButton *)sender{
    NSLog(@"取消过期按钮");
    
}
#pragma mark -------- 请求 >>> 获取地址列表 -----------
-(void)getAdressList
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/member-address/list.do?token=%@",tokenArr[1]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取地址列表--%@",responseObject);
        NSArray *arr = responseObject[@"data"][@"addressList"];
        if (arr.count <= 0) {
            Alert_Show(@"没有收货地址,前往添加")
        }else{
            WSSShippingAddressModel *model = [[WSSShippingAddressModel alloc]initWithDictionary:responseObject[@"data"][@"defaultAddress"] ];
            [self getSelectShopsRequestWithRegionId:model.region_id];
        }
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
        LYTConfirmOrderTVC *vc = [[LYTConfirmOrderTVC alloc]init];
        vc.sendJiFen = [NSString stringWithFormat:@"%d",[responseObject[@"data"][@"orderPrice"][@"point"]intValue]/100];
        vc.yunfei = responseObject[@"data"][@"orderPrice"][@"shippingPrice"];
        vc.goodsAllPrice = responseObject[@"data"][@"orderPrice"][@"goodsPrice"];
        vc.goodsArr = arr;
        vc.type = _type;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----购物车查询选中列表-");
        
    }];
}

#pragma mark -------- 请求 >>> 获取购物车列表 -----------
-(void)configRequest{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    NSLog(@"token---a----%@----%@",str,tokenArr);
    [self.ShopCartArr removeAllObjects];
    [self.goodsNumDic removeAllObjects];
    [self.goodsSelectDic removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/get-cart-data.do?token=%@",tokenArr[1]] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@" --%@-----%@",responseObject,[NSString stringWithFormat:GGLSC@"/api/mobile/cart/get-cart-data.do?token=%@",tokenArr[1]]);
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@"null"withString:@"\"LYTChange\""];
        NSData *jsonData1 = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        responseObject = [NSJSONSerialization JSONObjectWithData:jsonData1 options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"dicdicdic----%@",responseObject);
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] ) {
            if ([responseObject[@"data"][@"items"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
                    
                    LYTShopCartModel *model = [[LYTShopCartModel alloc]initWithDictionary:dic];
                    model.isChoose = model.selected;
                    [self.ShopCartArr addObject:model];
                    
                    [self.goodsNumDic setObject:[NSString stringWithFormat:@"%d",model.goods_num] forKey:model.idCode];
                    [self.goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model.selected] forKey:model.idCode];
                }
            }
            NSArray *allValue_select = [self.goodsSelectDic allValues];
            BOOL is_allSelect = YES;
            for (int i = 0; i < allValue_select.count; i++) {
                if ([allValue_select[i] intValue] == 0) {
                    is_allSelect = NO;
                }
            }
            LYTShopCartModel *model = [[LYTShopCartModel alloc]init];
            [self.ShopCartArr insertObject:model atIndex:0];
            if (is_allSelect) {
                model.isChoose = 1;
            }else{
                model.isChoose = 0;
            }
            [self.goodsSelectDic setObject:[NSString stringWithFormat:@"%d",model.isChoose] forKey:@"全选"];
            
            _amount = 0;
            _count = 0;
            _amountLabel.text = [NSString stringWithFormat:@"%.2f",_amount];
            _countLabel.text = [NSString stringWithFormat:@"共%d件",_count];
            
            [_LYTTableView reloadData];
        }else{
            [_LYTTableView reloadData];
            Alert_Show(@"未登录,请前往登录")
        }
        
    }WithError:^(NSString *errorStr) {
        [_LYTTableView reloadData];
    }];
}


#pragma  mark -----------购物车删除商品
- (void) delegateRequestShopCartid:(NSString *)cartId {

    NSLog(@"*----11232123---asd---asd----%@",cartId);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/delete.do?token=%@&cartid=%@",tokenArr[1],cartId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"购物车删除商品----%@",responseObject);
        
        [self configRequest];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----购物车删除商品-");
        
    }];
}

#pragma  mark -----------修改选中状态
- (void) didSelectRequestShopCartid:(NSString *)product_id changeStatus:(int)checked{
    
    NSLog(@"*----11232123---asd---asd----%@",product_id);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/check-product.do?token=%@&checked=%d&product_id=%@",tokenArr[1],checked,product_id] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改选中状态----%@",responseObject);
        
        [self configRequest];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----修改选中状态-");
        
    }];
}
#pragma  mark -----------修改全部选中状态
- (void) didSelectAllRequestChangeStatus:(int)checked {
    
    NSLog(@"*----11232123---asd---asd----%d",checked);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/check-all.do?token=%@&checked=%d",tokenArr[1],checked] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改全部选中状态----%@",responseObject);
        
        [self configRequest];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----修改全部选中状态-");
        
    }];
}
#pragma  mark -----------修改数量
- (void) changeShopCartCountRequestWithId:(NSString *)idCode shopCount:(int)num productid:(NSString *)productid{
    
    NSLog(@"*----11232123---asd---asd----%d",num);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/cart/update-num.do?token=%@&cartid=%@&num=%d&productid=%@",tokenArr[1],idCode,num,productid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改数量----%@",responseObject);
        
        [self configRequest];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"1212----修改数量-");
        
    }];
}
@end
