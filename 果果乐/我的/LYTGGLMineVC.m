//
//  LYTGGLMineVC.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/12.
//  Copyright © 2017年 Zjw. All rights reserved.
//

static NSString *DefaultCell = @"DefaultCell";
static NSString *GGLMineCell = @"LYTGGLMineCell";
static NSString *GGLMineCell1 = @"LYTGGLMineCell1";
static NSString *GGLMineCell2 = @"LYTGGLMineCell2";

#import "LYTGGLMineVC.h"
#import "LYTGGLMineCell.h"
#import "LYTGGLMineCell1.h"
#import "LYTGGLMineCell2.h"
#import "LYTLoginVC.h"
#import "LYTOrder.h"
#import "WSSShippingAddressViewController.h"
@interface LYTGGLMineVC ()

@end

@implementation LYTGGLMineVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self requestUserInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self confignav];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultCell];
    [self.tableView registerClass:[LYTGGLMineCell class] forCellReuseIdentifier:GGLMineCell];
    [self.tableView registerClass:[LYTGGLMineCell1 class] forCellReuseIdentifier:GGLMineCell1];
    [self.tableView registerClass:[LYTGGLMineCell2 class] forCellReuseIdentifier:GGLMineCell2];
    
    self.tableView.tableFooterView = [UIView new];
}
//-(void)confignav{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItem)];
//    self.navigationItem.rightBarButtonItem = item;
//}
-(void)rightBarButtonItem{
    LYTLoginVC *vc = [[LYTLoginVC alloc]init];
    [self.navigationController pushViewController: vc animated:YES];
}
-(void)configHeaderView:(NSDictionary *)info{
    UIView *headerView = [[UIView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:headerView.frame];
    img.image = [UIImage imageNamed:@"bg_not_login"];
    [headerView addSubview:img];
    
    UIImageView *headerImg = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(20, 20, 60, 60)];
    headerImg.image = [UIImage imageNamed:@"头像"];
//    headerImg.backgroundColor = [UIColor redColor];
    [headerView addSubview:headerImg];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(100, 30, 200, 30)];
    nameLabel.text = info[@"data"][@"nikName"];
    [headerView addSubview:nameLabel];
    self.tableView.tableHeaderView = headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }else{
            return 93;
        }
    }else{
        return 44;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 2;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LYTGGLMineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:GGLMineCell1 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"订单详情";
            cell.img.image = [UIImage imageNamed:@"my_order_icon"];
            cell.contentLabel.text = @"";
            return cell;
        }else{
            LYTGGLMineCell *cell = [tableView dequeueReusableCellWithIdentifier:GGLMineCell];
            cell.btn1.tag = 1;
            
            [cell.btn1 addTarget:self action:@selector(MainCellbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn2.tag = 2;
            [cell.btn2 addTarget:self action:@selector(MainCellbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn3.tag = 3;
            [cell.btn3 addTarget:self action:@selector(MainCellbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn4.tag = 4;
            [cell.btn4 addTarget:self action:@selector(MainCellbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            LYTGGLMineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:GGLMineCell1 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"地址管理";
            cell.contentLabel.text = @"管理收货地址";
            cell.img.image = [UIImage imageNamed:@"my_info_icon"];
            return cell;
        }else{
            LYTGGLMineCell2 *cell = [tableView dequeueReusableCellWithIdentifier:GGLMineCell2 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"注销";

            return cell;
        }
        
    }
}
-(void)MainCellbtnClick:(UIButton *)sender{
    NSLog(@"MainCellbtnClick按钮点击第几个---%ld",sender.tag);
    LYTOrder *vc = [[LYTOrder alloc]init];
    vc.index = sender.tag;
    vc.fromShop = 3;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WSSShippingAddressViewController *vc = [[WSSShippingAddressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            //注销
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date1"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date2"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refresh_token"];
            [self requestUserInfo];
        }
    }else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LYTOrder *vc = [[LYTOrder alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//请求用户信息
- (void)requestUserInfo
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLUserInfo] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求用户信息:%@", responseObject);
        [self configHeaderView:responseObject];
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}
#pragma mark ----------- 刷新token -------------
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
    NSString *refresh_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"];
    [manager POST:[NSString stringWithFormat:GGL@"/oauth/token?grant_type=refresh_token&refresh_token=%@",refresh_token] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录请求%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",responseObject[@"access_token"]];
        NSLog(@"tokentoken%@",tokenStr);
        
        if (responseObject[@"access_token"] != nil) {
            [[NSUserDefaults standardUserDefaults]setObject:tokenStr  forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"refresh_token"] forKey:@"refresh_token"];
            Alert_Show(@"您离开的太久啦, 请重试")
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        LYTLoginVC * loginVC = [[LYTLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }];
}


@end
