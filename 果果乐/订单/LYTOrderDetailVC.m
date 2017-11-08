//
//  LYTOrderDetailVC.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/18.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏

#import "LYTOrderDetailVC.h"
#import "LYTAdressCell.h"
#import "LYTConfirmGoodsCell.h"
#import "LYTOrderModel.h"
#import "LYTSubmitOrdersVC.h"
#import "LogisticsInformationViewController.h"
#import "ShopCartVC.h"
#import "LYTGoodsDetailVC.h"
@interface LYTOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *titleArr;
@property(nonatomic,retain)NSArray *contentArr;
@property(nonatomic,retain)UITableView *LYTTableView;
@property(nonatomic,copy)  NSString *kuaiDiStr;
@end

@implementation LYTOrderDetailVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:33/255.0 green:35/255.0 blue:33/255.0 alpha:1];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"_goodsDic-----%@       goodsArr---%@",_goodsDic,_goodsArr);
    if ([_goodsDic[@"pay_status"] intValue] == 0){
        _titleArr = @[@"商品总额",@"赠送积分",@"运费",@"实付金额",@""];
        NSString *timeStr = [self timeWithTimeIntervalString:_goodsDic[@"create_time"]];
        _contentArr = @[_goodsDic[@"goods_amount"],_goodsDic[@"gainedpoint"],_goodsDic[@"shipping_amount"],_goodsDic[@"needPayMoney"],timeStr];
    }else{
        _titleArr = @[@"商品总额",@"赠送积分",@"运费",@"实付金额",@"快递号",@""];
        
        NSString *timeStr = [self timeWithTimeIntervalString:_goodsDic[@"create_time"]];
        _contentArr = @[_goodsDic[@"goods_amount"],_goodsDic[@"gainedpoint"],_goodsDic[@"shipping_amount"],_goodsDic[@"needPayMoney"],_goodsDic[@"ship_no"],timeStr];
    }
    //请求快递信息
    [self requestExpressWithShippingId:[_goodsDic[@"logi_id"] intValue]];
    
    
    _useraddress = [NSString stringWithFormat:@"%@%@%@%@",_goodsDic[@"memberAddress"][@"province"],_goodsDic[@"memberAddress"][@"city"],_goodsDic[@"memberAddress"][@"region"],_goodsDic[@"memberAddress"][@"addr"]];
    _username = [NSString stringWithFormat:@"%@",_goodsDic[@"memberAddress"][@"name"]];
    _mobile = [NSString stringWithFormat:@"%@",_goodsDic[@"memberAddress"][@"mobile"]];
    self.view.backgroundColor = [UIColor grayColor];
    [self configTable];
    [self configView];
    
    [self configNav];
}
-(void)configNav{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)backBtn{
    if (_typeCode == 1) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[LYTGoodsDetailVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else if (_typeCode == 2){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ShopCartVC class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)configTable{
    _LYTTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    if ([_goodsDic[@"pay_status"] intValue] == 0){
        _LYTTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-40);
    }
    _LYTTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _LYTTableView.delegate = self;
    _LYTTableView.dataSource = self;
    [self.view addSubview:_LYTTableView];
    [_LYTTableView registerClass:[LYTConfirmGoodsCell class] forCellReuseIdentifier:@"LYTConfirmGoodsCell"];
    [_LYTTableView registerClass:[LYTAdressCell class] forCellReuseIdentifier:@"LYTAdressCell"];
    [_LYTTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _LYTTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self setExtraCellLineHidden:_LYTTableView];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)configView{
    if ([_goodsDic[@"pay_status"] intValue] == 0) {
        NSArray *arr = @[@"取消",@"支付"];
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake( (kScreenWidth/2)*i, kScreenHeight-40, kScreenWidth/2, 40);
            if (i == 0) {
                btn.backgroundColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
            }else{
                btn.backgroundColor = [UIColor anniuColor];
            }
            btn.tag =i;
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(zhiFuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
    }else if ([_goodsDic[@"receive_btn"] intValue] == 1){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( 0, kScreenHeight-40, kScreenWidth, 40);
        btn.backgroundColor = [UIColor anniuColor];
        
        [btn setTitle:@"确认收货" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(queRenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
}
-(void)zhiFuBtnClick:(UIButton *)sender{
    //支付取消
    if (sender.tag == 1) {
        //支付
        LYTSubmitOrdersVC *vc = [[LYTSubmitOrdersVC alloc]init];
        vc.order_id = _goodsDic[@"order_id"];
        vc.balance = _goodsDic[@"user_money"];
        vc.orderPay = _goodsDic[@"total_amount"];
        vc.heji = _goodsDic[@"order_amount"];
        vc.order_sn = _goodsDic[@"sn"];
        vc.typecode = 2;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        //取消
        NSLog(@"取消订单");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)queRenBtnClick:(UIButton *)sender{
    //确认收货
    
}


#pragma mark - Table view data source
#pragma mark ----------- tablewView的代理 -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 100*kScreenHeight1;
    }else if (indexPath.section == 1){
        return 100;
    }else{
        return 20;
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
    if (section == 2) {
        if ([_goodsDic[@"pay_status"] intValue] == 0){
            return _titleArr.count;
        }else{
            return _titleArr.count;
        }
    }else if(section == 1){
        return _goodsArr.count;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
        LYTOrderModel *model = _goodsArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.countLabel.text = [NSString stringWithFormat:@"x%d",model.num];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.name];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image]] placeholderImage:[UIImage imageNamed:@"img_error"]];
        cell.specLabel.text = [NSString stringWithFormat:@"%@",model.spec_key_name];
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _titleArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        if (indexPath.row <= 3) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",[_contentArr[indexPath.row] doubleValue]];
        }else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_contentArr[indexPath.row]];
        }
        
        cell.textLabel.textColor = [UIColor xiaobiaotiColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        if ([_titleArr[indexPath.row] isEqualToString:@""]) {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
            
        }else if ([_titleArr[indexPath.row] isEqualToString:@"实付金额"]){
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor anniuColor];
        }
        
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 3) {
            NSLog(@"跳转物流界面");
            LogisticsInformationViewController *logisticsVC = [[LogisticsInformationViewController alloc]init];
            logisticsVC.invoice_no2 = _goodsDic[@"ship_no"];
            logisticsVC.shipping_code2 = _kuaiDiStr;
            NSLog(@"$$$$$%@^^^^^%@",_goodsDic[@"ship_no"],_kuaiDiStr);
            [self.navigationController pushViewController:logisticsVC animated:YES];
        }
    }
}

//时间戳转化时间
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}




#pragma mark----------请求快递信息
-(void)requestExpressWithShippingId:(int)ShippingId {
    
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSC@"/api/mobile/order/list-logi.do"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求快递信息-------%@",responseObject);
        for (NSDictionary *dic in responseObject[@"data"]) {
            if (ShippingId == [dic[@"id"] intValue]) {
                _kuaiDiStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
            }
        }
        
    } WithError:^(NSString *errorStr) {
        NSLog(@"请求快递信息-------%@",errorStr);
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
