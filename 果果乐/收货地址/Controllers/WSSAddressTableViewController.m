//
//  WSSAddressTableViewController.m
//  cccc
//
//  Created by 王松松 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "WSSAddressTableViewController.h"

@interface WSSAddressTableViewController ()
@property (nonatomic, strong)NSMutableArray * areaArr;          //所有地址表信息
@property (nonatomic, strong)NSMutableArray * areaStrArr;       //选中地址表名称
@property (nonatomic, strong)NSMutableArray * areaIdArr;        //选中地址表Id

@property (nonatomic, strong)UILabel * provinceLabel;
@property (nonatomic, strong)UILabel * cityLabel;
@property (nonatomic, strong)UILabel * detailLabel;
@property (nonatomic, strong)UILabel * provinceLabel1;
@property (nonatomic, strong)UILabel * cityLabel1;
@property (nonatomic, strong)UILabel * detailLabel1;



@end

@implementation WSSAddressTableViewController
-(NSMutableArray *)areaArr{
    if (!_areaArr) {
        _areaArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _areaArr;
}
-(NSMutableArray *)areaStrArr{
    if (!_areaStrArr) {
        _areaStrArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _areaStrArr;
}
-(NSMutableArray *)areaIdArr{
    if (!_areaIdArr) {
        _areaIdArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _areaIdArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadData];
    
    self.provinceLabel = [[UILabel alloc] init];
    self.provinceLabel1 = [[UILabel alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel1 = [[UILabel alloc] init];
    self.cityLabel = [[UILabel alloc] init];
    self.cityLabel1 = [[UILabel alloc] init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"11"];
    
    
    [self getAdressAreaId:@"0"];
}


#pragma mark ----------- tableView的代理 -------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.areaArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.areaArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
    cell.textLabel.text = dic[@"local_name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.areaArr[indexPath.row];
    [self.areaStrArr addObject:dic[@"local_name"]];
    [self.areaIdArr addObject:dic[@"region_id"]];
    [self getAdressAreaId:dic[@"region_id"]];
}
#pragma mark -------- 请求 >>> 获取地址区域表 -----------
-(void)getAdressAreaId:(NSString *)IdStr
{
    [self.areaArr removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:GGLSC@"/api/base/region/get-children.do?regionid=%@",IdStr] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取地址区域表--%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]){
            for (NSDictionary *dic  in responseObject) {
                [self.areaArr addObject:dic];
            }
        }
        NSArray *arr = responseObject;
        if (arr.count <= 0) {
            self.content(self.areaStrArr, self.areaIdArr);
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取地址区域表232失败-");
        
    }];
}

@end
