//
//  LogisticsInformationViewController.m
//  YSApp
//
//  Created by 云盛科技 on 2016/10/26.
//  Copyright © 2016年 云盛科技. All rights reserved.
//

#import "LogisticsInformationViewController.h"
#import "LogisitcsTableViewCell.h"
#import "logisitecsModel.h"

@interface LogisticsInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *placeStr;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, strong) logisitecsModel *logisitecsModel;
@property (nonatomic, strong) NSMutableArray *logisitecsArr;

@end

@implementation LogisticsInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"物流信息";
    _logisitecsArr = [NSMutableArray array];
    [self creatLogisticsTable];
//    [self logisticsRequest];
    [self request];
}

- (void)creatLogisticsTable{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor backGray];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[LogisitcsTableViewCell class] forCellReuseIdentifier:@"LogisitcsCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _logisitecsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogisitcsTableViewCell *logisitcsCell = [tableView dequeueReusableCellWithIdentifier:@"LogisitcsCell" forIndexPath:indexPath];
    logisitecsModel *model = _logisitecsArr[indexPath.row];
    logisitcsCell.placeLabel.text = model.context_url;
    logisitcsCell.timeLabel.text = model.time_url;
    return logisitcsCell;
}


-(void)request{
    
    NSLog(@"aaa-    %@,",[NSString stringWithFormat:@"http://m.kuaidi100.com/query?type=%@&postid=%@", self.shipping_code2,self.invoice_no2]);
    
//    [WDHRequest requestAllListWith:[NSString stringWithFormat:@"http://m.kuaidi100.com/query?type=%@&postid=%@", self.shipping_code2,self.invoice_no2] completeWithBlock:^(NSDictionary *responseObject) {
//        NSLog(@"qq-物流信息-----%@",responseObject);
//        [SVProgressHUD dismiss];
//        if ([responseObject[@"status"]integerValue] == 200) {
//            NSArray *firstArr = responseObject[@"data"];
//            for (NSDictionary *dic in firstArr) {
//                logisitecsModel *model = [[logisitecsModel alloc]initWithDictionary:dic];
//                [_logisitecsArr addObject:model];
//            }
//        }else{
//            UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(50, 20, 300, 40)];
//            label.text = @"物流信息暂未更新!";
//            label.textAlignment = 1;
//            _tableView.backgroundColor = [UIColor backGray];
//            [_tableView addSubview:label];
//            _tableView.scrollEnabled = NO;
//        }
//        [_tableView reloadData];
//    } WithError:^(NSString *errorStr) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无物流信息" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
//    }];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"http://m.kuaidi100.com/query?type=%@&postid=%@", self.shipping_code2,self.invoice_no2] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"qq-物流信息-----%@",responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"status"]integerValue] == 200) {
            NSArray *firstArr = responseObject[@"data"];
            for (NSDictionary *dic in firstArr) {
                logisitecsModel *model = [[logisitecsModel alloc]initWithDictionary:dic];
                [_logisitecsArr addObject:model];
            }
        }else{
            UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(50, 20, 300, 40)];
            label.text = @"物流信息暂未更新!";
            label.textAlignment = 1;
            _tableView.backgroundColor = [UIColor backGray];
            [_tableView addSubview:label];
            _tableView.scrollEnabled = NO;
        }
        [_tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无物流信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
