//
//  ZjwCategorySearchVC.m
//  LSK
//
//  Created by 张敬文 on 2017/1/12.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏
#define TableWidth              70                              //tableView的宽


#import "ZjwCategorySearchVC.h"
#import "LYTCategoryChildVC.h"

#import "ZjwSearchVC.h"


@interface LYTSortTableCell : UITableViewCell
@property(nonatomic,retain)UILabel *label;
@end
@implementation LYTSortTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0, 0, TableWidth, 44)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12 * kScreenHeight1];
    }
    return _label;
}
@end

@interface ZjwCategorySearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,retain)UITableView *LYTSortTable;
@property(nonatomic,retain)UIViewController *currentVC;         //当前显示的子视图

@property(nonatomic,retain)NSMutableArray *allData;               //所有数据

//搜索
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UIView *skView;
@end
@implementation ZjwCategorySearchVC
-(NSMutableArray *)allData{
    if (!_allData) {
        _allData = [NSMutableArray arrayWithCapacity:0];
    }
    return _allData;
}
//创建列表控制
-(UITableView *)LYTSortTable{
    if (!_LYTSortTable) {
        _LYTSortTable = [[UITableView alloc]initWithFrame:WDH_CGRectMake(0, 0 , TableWidth, 667) style:UITableViewStylePlain];
        _LYTSortTable.delegate = self;
        _LYTSortTable.dataSource = self;
        [_LYTSortTable registerClass:[LYTSortTableCell class] forCellReuseIdentifier:@"cell"];
        _LYTSortTable.tableFooterView = [UIView new];
    }
    return _LYTSortTable;
}
- (void)viewWillAppear:(BOOL)animated
{
    UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    _statusBarView.backgroundColor=[UIColor whiteColor];
    _statusBarView.alpha = 1;
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = NO;
    if (self.allData.count <= 0) {
        [self requestAllData];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self SearchView];
    [self.view addSubview:self.LYTSortTable];
    
    self.navigationController.navigationBar.translucent = NO;
    [self requestAllData];
    [self setNavigationBarConfiguer];
}
-(void)configChildVC{
    //添加子视图
    for (int i = 0; i < self.allData.count; i ++) {
        LYTCategoryChildVC *vc = [[LYTCategoryChildVC alloc]init];
        [vc.view setFrame:WDH_CGRectMake(TableWidth, 0, 375 - TableWidth, 559)];
        [self addChildViewController:vc];
        NSDictionary *dic = self.allData[i];
        [vc categoryWithData:dic[@"tmenu"]];
        vc.index = i;
        if (i == 0) {
            _currentVC = vc;
            [self.view addSubview:vc.view];
        }
    }
}
- (void)setNavigationBarConfiguer {

    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItemAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void) rightBarButtonItemAction {
//    ZjwSearchVC * zjwVC = [[ZjwSearchVC alloc] init];
//    [self.navigationController pushViewController:zjwVC animated:YES];
}


//搜索
- (void) SearchView {
    self.searchBar = [[UISearchBar alloc]initWithFrame:WDH_CGRectMake(0,0,200,30)];
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor blackColor];
    self.searchBar.barStyle = 0;
    UIView * aView = [[UIView alloc] initWithFrame:WDH_CGRectMake(0, 0,200, 30)];
    aView.layer.cornerRadius = 5;
    aView.layer.masksToBounds = YES;
    [aView addSubview:self.searchBar];
    self.navigationItem.titleView = aView;
}

//将要开始编辑时的回调，返回为NO，则不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    ZjwSearchVC * zjwVC = [[ZjwSearchVC alloc] init];
    [self.navigationController pushViewController:zjwVC animated:YES];
    return NO;
}


#pragma mark ------tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allData.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYTSortTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic = self.allData[indexPath.row];
    cell.label.text = [NSString stringWithFormat:@"%@",dic[@"text"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LYTCategoryChildVC *vc = self.childViewControllers[indexPath.row];
    [self replaceController:self.currentVC newController:vc];
    
}
#pragma mark - 切换viewController
//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    //    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            //            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}

#pragma mark ------netWork
//请求分类数据
- (void) requestAllData
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager GET:GGLSC@"/api/shop/category/get-all-by-parentid-json.do" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.allData removeAllObjects];
        
        responseObject = [PublicToors changeNullInData:responseObject];
        NSLog(@"请求分类数据-----%@",responseObject);
        [self.allData addObjectsFromArray:responseObject[@"data"]];
        [self.LYTSortTable reloadData];
        [self configChildVC];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求分类数据失败%@",error);
    }];

}


@end
