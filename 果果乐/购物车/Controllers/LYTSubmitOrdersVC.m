//
//  LYTSubmitOrdersVC.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏

#import "LYTSubmitOrdersVC.h"
#import "LYTPayTypeTableCell.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "APAuthV2Info.h"

#import <WXApi.h>
#import "DCPaymentView.h"
#import "LYTOrder.h"
//#import "SYVerificationMobileController.h"

#import "LYTGoodsDetailVC.h"
#import "ShopCartVC.h"
#import "LYTOrderDetailVC.h"


@interface LYTSubmitOrdersVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *payTypeImgArr;
@property(nonatomic,retain)NSArray *payTypeStrArr;
@property(nonatomic,retain)NSArray *payTypeImgArr1;
@property(nonatomic,retain)NSArray *payTypeStrArr1;
@property(nonatomic,retain)UITableView *payTypeTable;
@property(nonatomic,assign)NSInteger type;
@property (nonatomic,copy) NSString *tn;
@property (nonatomic,copy) NSString *tnMode;
@property (nonatomic,copy) NSString *pay_trade_no;
@property (nonatomic,copy) NSString *pay_code;

@end

@implementation LYTSubmitOrdersVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

}
-(void)backBtn{
    if (_typecode == 1) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[LYTGoodsDetailVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else if (_typecode == 0){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ShopCartVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
            
        }
    }else if (_typecode == 2){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            
            if ([temp isKindOfClass:[LYTOrderDetailVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"asd----typecode-----%d",_typecode);
    
    _type = 0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor backGray];
    //@"pay_mark_money", @"pay_mark_money"
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 38*kScreenHeight1, 90*kScreenWidth1, 1*kScreenHeight1)];
    label1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label1];
    _payTypeImgArr = @[@"zhifu_ico",@"pay_mark_weixin",@"pay_mark_yinlian"];
    _payTypeStrArr = @[@"支付宝支付",@"微信支付",@"银联支付"];
    
    _payTypeImgArr1 = @[@"pay_mark_money"];
    _payTypeStrArr1 = @[@"余额"];
    [self configTable];
    [self configOrderView];
    
    UIButton *nowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nowBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    
    nowBtn.frame = WDH_CGRectMake(0, 667 - 40, 375, 40);
    if (_typecode == 1) {
        nowBtn.frame = WDH_CGRectMake(0, 667 - 40, 375, 40);
    }else if (_typecode == 0){
        nowBtn.frame = WDH_CGRectMake(0, 667 - 40 - 64, 375, 40);
    }else if (_typecode == 2){
        nowBtn.frame = WDH_CGRectMake(0, 667 - 40 , 375, 40);
    }
    
    [nowBtn addTarget:self action:@selector(nowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    nowBtn.backgroundColor = [UIColor anniuColor];
    [self.view addSubview:nowBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotification) name:@"AlipaySDKSuccsess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotification1) name:@"AlipaySDKdissMiss" object:nil];
    
    

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    
    self.navigationItem.leftBarButtonItem = item;
}
-(void)NSNotification{
    [self zhifuWithCode:_pay_code];
}
-(void)NSNotification1{
    LYTOrder *vc = [[LYTOrder alloc]init];
    vc.index = 1;

    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)configOrderView{
    UIView *orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375 * kScreenWidth1, 160*kScreenHeight1)];
    
    if (_typecode == 1) {
        orderView.frame = CGRectMake(0, 64, 375 * kScreenWidth1, 160*kScreenHeight1);
    }else if (_typecode == 0){
        orderView.frame = CGRectMake(0, 0, 375 * kScreenWidth1, 160*kScreenHeight1);
    }else if (_typecode == 2){
        orderView.frame = CGRectMake(0, 64, 375 * kScreenWidth1, 160*kScreenHeight1);
    }
    
    
    orderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:orderView];
    
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 5, 80, 20)];
    titleLabel1.text = @"订单编号:";
    titleLabel1.textColor = [UIColor xiaobiaotiColor];
    [orderView addSubview:titleLabel1];
    
    UILabel *orderLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375-200, 5, 190, 20)];
    orderLabel.text = _order_sn;
    orderLabel.textColor = [UIColor xiaobiaotiColor];
    orderLabel.textAlignment = NSTextAlignmentRight;
    [orderView addSubview:orderLabel];
    
    UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 45, 80, 20)];
    titleLabel2.text = @"订单合计:";
    titleLabel2.textColor = [UIColor xiaobiaotiColor];
    [orderView addSubview:titleLabel2];
    
    UILabel *orderMoneyLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375-200, 45, 190, 20)];
    orderMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[_heji doubleValue]];
    orderMoneyLabel.textColor = [UIColor xiaobiaotiColor];
    orderMoneyLabel.textAlignment = NSTextAlignmentRight;
    [orderView addSubview:orderMoneyLabel];
    
    
//    UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 80, 20)];
//    titleLabel3.text = @"余额支付:";
//    [orderView addSubview:titleLabel3];
//    titleLabel3.textColor = [UIColor xiaobiaotiColor];
//    
//    
//
//    UILabel *orderBalanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-200, 70, 190, 20)];
//    if ([fundInfo[@"fundAccount"]doubleValue]<=[_orderPay doubleValue]) {
//        orderBalanceLabel.text = [NSString stringWithFormat:@"%.2f",[fundInfo[@"fundAccount"]doubleValue]];
//    }else{
//        orderBalanceLabel.text = _orderPay;
//    }
//    orderBalanceLabel.textColor = [UIColor xiaobiaotiColor];
//    orderBalanceLabel.textAlignment = NSTextAlignmentRight;
//    [orderView addSubview:orderBalanceLabel];
    
    
    UILabel *titleLabel4 = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 120, 80, 20)];
    titleLabel4.text = @"应付金额:";
    titleLabel4.textColor = [UIColor xiaobiaotiColor];
    [orderView addSubview:titleLabel4];
    
    UILabel *orderPayLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(375-200, 120, 190, 20)];
    orderPayLabel.textColor = [UIColor xiaobiaotiColor];
    
    orderPayLabel.text = [NSString stringWithFormat:@"%.2f",[_heji doubleValue]];
    
    
    orderPayLabel.textAlignment = NSTextAlignmentRight;
    [orderView addSubview:orderPayLabel];

}


-(void)configTable{
    _payTypeTable = [[UITableView alloc]initWithFrame:WDH_CGRectMake(0, 234, 375, 667-176) style:UITableViewStylePlain];
    if (_typecode == 2) {
        _payTypeTable.frame = WDH_CGRectMake(0, 170 + 64, 375, 667-176);
    }else if (_typecode == 0){
        _payTypeTable.frame = WDH_CGRectMake(0, 170, 375, 667-176);
    }
    
    _payTypeTable.delegate = self;
    _payTypeTable.dataSource = self;
    [self.view addSubview:_payTypeTable];
    
    [_payTypeTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_payTypeTable registerClass:[LYTPayTypeTableCell class] forCellReuseIdentifier:@"LYTPayTypeTableCell"];
    [self setExtraCellLineHidden:_payTypeTable];
}
//删除多余的线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.textLabel.text = @"请选择支付方式";
            return cell;
        }else{
            LYTPayTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYTPayTypeTableCell"];
            cell.imgView.image = [UIImage imageNamed:_payTypeImgArr[indexPath.row - 1]];
            cell.titleLabel.text = _payTypeStrArr[indexPath.row - 1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                if (_type != 0) {
                    if (_type + 1 == cell.chooseBtn.tag) {
                        cell.chooseBtn.tag = 500;
                    }
                } else {
                    if (indexPath.row == 1) {
                        cell.chooseBtn.tag = 500;
                    }
                }
            if (cell.chooseBtn.tag == 500) {
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_ok"] forState:UIControlStateNormal];
            }else{
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_no"] forState:UIControlStateNormal];
            }
            cell.chooseBtn.tag = indexPath.row;
            return cell;
        }
    
}

-(void)chooseBtnClick:(UIButton *)sender{
    [sender setBackgroundImage:[UIImage imageNamed:@"pay_mark_ok"] forState:UIControlStateNormal];

    if (sender.tag == 1) {
        NSLog(@"选择支付方式----ZFB");
        _type = 0;
    }else if (sender.tag == 2){
        NSLog(@"选择支付方式----WX");
        _type = 1;
    }else if (sender.tag == 3){
        NSLog(@"选择支付方式----YL");
        _type = 2;
    }
//    if ([fundInfo[@"fundAccount"]doubleValue] <= 0) {
//        _pay_code = [NSString stringWithFormat:@"%ld",_type+1];
//    }else{
//        _pay_code = [NSString stringWithFormat:@"%ld",_type+4];
//    }
    sender.tag = 500;
    
    [_payTypeTable reloadData];
}

-(void)nowBtnClick:(UIButton *)sender{
    
    if (_type == 0) {
        [self requestZhiFuBaoOrder];
    } else if (_type == 1) {
        if ([WXApi isWXAppInstalled])
        {
            //监听通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
        }
        [self sendWXPay];
    } else if (_type == 2) {
        self.tnMode = @"00";
       
    }
    
    
    
}



#pragma mark
#pragma mark ------------ 请求 >>> 支付宝支付 ------------
-(void)requestZhiFuBaoOrder
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"token-----%@",str);
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:GGL@"/recharge/shop_pay_info?sn=%@&price=%.2f",_order_sn,[_heji doubleValue]]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"-支付宝---%@", responseObject);
        NSString * orderID = responseObject[@"data"][@"pay_info"];
        _pay_trade_no = responseObject[@"data"][@"pay_trade_no"];
        [self alipayActionWithOrderId:orderID];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"支付宝2失败----%@",error);
        
    }];
    
}

#pragma mark ------------ 支付宝回调 ------------
- (void)alipayActionWithOrderId:(NSString *)orderID{
    NSString *appScheme = @"GGL";
    NSString *signedString = orderID;
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@",signedString];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *str =resultDic[@"resultStatus"];

            NSLog(@"qw-----qw-----%@",resultDic);
            NSData *jsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *err;
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers  error:&err];
            NSLog(@"adasd------%@",dic);
            if ([str intValue]==9000){
                [self zhifuWithCode:_pay_code];
                
            }else{
                Alert_Show(@"支付失败")
            }
        }];
    }
}



#pragma mark
#pragma mark ------------ 请求 >>> 微信支付 ------------
- (void)sendWXPay{
//    NSDictionary *fundInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"fundInfo"];
//    [WDHRequest requestWXOrderWith:[NSString stringWithFormat:WXPay1,_order_id,[_orderPay doubleValue]-[fundInfo[@"fundAccount"]doubleValue]] completeWithBlock:^(NSDictionary *responseObject) {
//        if ([responseObject[@"code"] intValue] == 0) {
//        NSDictionary * dic = responseObject[@"data"][@"pay_info"];
//        _pay_trade_no = responseObject[@"data"][@"pay_trade_no"];
//        //调起支付
//        PayReq *req = [[PayReq alloc]init];
//        req.partnerId = dic[@"partnerid"];//商家id
//        req.prepayId = dic[@"prepayid"];//预支付订单
//        req.package = dic[@"package"]; //扩展字段  暂填写固定值Sign=WXPay
//        req.nonceStr = dic[@"noncestr"];//随机串，防重发
//        req.timeStamp = [dic[@"timestamp"] intValue];//时间戳
//        req.sign = dic[@"sign"];//商家根据微信开放平台文档对数据做的签名
//        [WXApi sendReq:req];
//        }else{
//            Alert_Show(@"服务器忙,请稍后再试")
//        }
//    }];
    
}

#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"])
    {
        [self zhifuWithCode:_pay_code];
        //移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
    else if([notification.object isEqualToString:@"cancel"])
    {
        
        LYTOrder *vc = [[LYTOrder alloc]init];
        vc.index = 1;

        [self.navigationController pushViewController:vc animated:YES];
        //移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
    else
    {
        Alert_Show(@"支付失败")
        //移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
}



- (void)zhifuWithCode:(NSString *)code{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"获取的Token  ===%@", str);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString stringWithFormat:GGL@"/payOrder/shopPay?tradeNo=%@&money=0.01&payTradeNo=%@",_pay_trade_no,_pay_trade_no] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"a-支付s-支付d---%@",[NSString stringWithFormat:GGL@"/recharge/shop_pay_info?tradeNo=%@&money=0.01&payTradeNo=%@",_pay_trade_no,_pay_trade_no]);
        NSLog(@"---支付---%@--------",responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue] == 0) {
            LYTOrder *order = [[LYTOrder alloc]init];
            order.index = 2;
            order.fromShop = _typecode;
            [self.navigationController pushViewController:order animated:YES];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-支付-失败");
            [SVProgressHUD dismiss];
            
    }];
}
@end
