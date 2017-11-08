//
//  WSSShippingAddressViewController.m
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "WSSModifyAddressViewController.h"
#import "WSSShippingAddressModel.h"
#import "WSSShippingAddressTableViewCell.h"
#import "WSSShippingAddressViewController.h"

@interface WSSShippingAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *receiptTable;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,copy)NSString *userId;
@end

@implementation WSSShippingAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAdressList];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:33/255.0 green:35/255.0 blue:33/255.0 alpha:1];
}
-(NSMutableArray *)arr{
    if (!_arr ) {
        _arr = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"MyInfo"];
//    _userId = [NSString stringWithFormat:@"%@", dic[@"userId"]];
    
    [self configView];
    
    self.title = @"收货地址";
}
-(void)configView
{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height+64)];
//    [self.view addSubview:view];
//    view.backgroundColor = [UIColor backGray];
    _receiptTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 44 * kScreenHeight1)) style:UITableViewStylePlain];
    _receiptTable.delegate = self;
    _receiptTable.dataSource = self;
    _receiptTable.rowHeight =110 * kScreenHeight1;
    _receiptTable.separatorStyle = NO;
    _receiptTable.backgroundColor = [UIColor backGray];
    [_receiptTable registerClass:[WSSShippingAddressTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_receiptTable];
    
   
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_type == 1) {
        btn.frame = CGRectMake(0,self.view.bounds.size.height-109* kScreenHeight1, kScreenWidth, 44 * kScreenHeight1);
    }else{
        btn.frame = CGRectMake(0, self.view.bounds.size.height-44* kScreenHeight1, kScreenWidth, 44 * kScreenHeight1);
    }

    [btn setTitle:@"添加新的收货地址" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor anniuColor]];
    [btn addTarget:self action:@selector(addAdressRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark
#pragma mark -------- tableView的代理 -----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"self.arr.counself.arr.coun---%ld",self.arr.count);
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WSSShippingAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    WSSShippingAddressModel *model = self.arr[indexPath.section];
    cell.phone.text = [NSString stringWithFormat:@"%@",model.mobile];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.adressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.region,model.addr];
    cell.defaulLabel.text =@"设为默认地址";
    if ([model.def_addr intValue] == 0) {
        [cell.defaulBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_no"] forState:UIControlStateNormal];
    }else{
        [cell.defaulBtn setBackgroundImage:[UIImage imageNamed:@"pay_mark_ok"] forState:UIControlStateNormal];
    }
    cell.defaulBtn.tag =indexPath.section;
    [cell.defaulBtn addTarget:self action:@selector(defaulBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(delegateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.section;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_orderStr isEqualToString:@"adress"])
    {
        WSSShippingAddressModel *model = self.arr[indexPath.section];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addrssID" object:self userInfo:@{@"addrssId":model}];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        WSSModifyAddressViewController *vc = [[WSSModifyAddressViewController alloc]init];
        WSSShippingAddressModel *model = self.arr[indexPath.section];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)defaulBtnClick:(UIButton *)sender
{
    NSLog(@"选择默认地址....");
    WSSShippingAddressModel *model = self.arr[sender.tag];
    [self updataDefultAdressWithAdressID:model.addr_id];
}
-(void)delegateBtnClick:(UIButton *)sender{
    NSLog(@"删除地址信息");
    WSSShippingAddressModel *model = self.arr[sender.tag];
    [self delegetAdressWithAdressID:model.addr_id];
}
-(void)addAdressRequest
{
    NSLog(@"sda添加收货地址");
    WSSModifyAddressViewController *vc = [[WSSModifyAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark
#pragma mark -------- 请求 >>> 获取地址列表 -----------
-(void)getAdressList
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/member-address/list.do?token=%@",tokenArr[1]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取地址列表--%@",responseObject);
        if ([responseObject[@"data"][@"addressList"] isKindOfClass:[NSArray class]]){
            [self.arr removeAllObjects];
            for (NSDictionary *dic  in responseObject[@"data"][@"addressList"]) {
                WSSShippingAddressModel *model = [[WSSShippingAddressModel alloc]initWithDictionary:dic];
                [self.arr addObject:model];
            }
        }
        [_receiptTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取地址列表232失败-");
        
    }];
}
#pragma mark
#pragma mark -------- 请求 >>> 删除地址 -----------
-(void)delegetAdressWithAdressID:(NSString *)adressID
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/member-address/delete.do?token=%@&addr_id=%@",tokenArr[1],adressID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"删除地址收货地址--%@",responseObject);
        [self getAdressList];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"删除地址收货地址232失败-");
        
    }];
}
#pragma mark
#pragma mark -------- 请求 >>> 更新默认收货地址 -----------
-(void)updataDefultAdressWithAdressID:(NSString *)adressID
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/mobile/member-address/isdefaddr.do?token=%@&addr_id=%@",tokenArr[1],adressID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"更新默认收货地址--%@",responseObject);
        [self getAdressList];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更新默认收货地址232失败-");
        
    }];
}

@end
