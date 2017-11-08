//
//  LYTGoodsDetailVC.m
//  addProject
//
//  Created by 云盛科技 on 2017/7/31.
//  Copyright © 2017年 神廷. All rights reserved.
//

#define FooterHight                 50                              //tableView尾部高度
#define ScrollContentOffSet         10                              //Scroll偏移量的比率
#define SpecScrollHight             667 * kScreenHeight1 /2.0f - 100         //规格上ScrollView高度



#import "LYTGoodsDetailVC.h"
#import "LYTGoodsDetailCell.h"
#import "LYTSudokuView.h"                           //规格
#import "LYTBackView.h"

#import "LYTShopCartModel.h"
#import "WSSShippingAddressModel.h"
#import "LYTConfirmOrderTVC.h"
#import "ShopCartVC.h"

static NSString *DefaultCell        = @"DefaultCell";
static NSString *GoodsDetailCell    = @"LYTGoodsDetailCell";

@interface LYTGoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource,LYTBackViewDelegate,LYTSudokuDelegate,UIWebViewDelegate>
{
    UIButton * jianBtn;
    UILabel * countLabel;
    NSInteger goodsCount;
    
    UIImageView *headerImg;         //pop上的图片
    UILabel * popNameLabel;         //pop上的商品名
    UILabel * popMoneyLabel;        //pop上的金额
    UILabel * popStockLabel;        //pop上的库存
}
@property(nonatomic,retain)UIView               *statusBarView;     //隐藏导航条和状态栏
@property(nonatomic,retain)UIView               *navigationView;    //隐藏导航条
@property(nonatomic,retain)UILabel              *navigationLabel;   //隐藏导航条标题
@property(nonatomic,retain)UIButton             *backBtn;           //返回按钮
@property(nonatomic,retain)UIView               *popView;           //弹出视图
@property(nonatomic,retain)UITableView          *LYTGoodsDetailTable;

@property(nonatomic,retain)NSMutableDictionary  *selectSpecTypeDic; //选择规格属性-外部显示


@property (nonatomic,strong) NSDictionary   *allDataDic;              //存储所有商品信息
@property (nonatomic,strong) NSMutableArray *goodsSpecArr;              //存储商品规格
@property (nonatomic,strong) NSMutableArray *goodsSpecDetailArr;   //存储商品规格详情
@property (nonatomic,strong) NSMutableArray *scrollImg;                 //存储轮播图片数组
@property (nonatomic,copy) NSString *webMarkStr;                 //存储轮播图片数组
@property (nonatomic,copy) NSString *spec_id;                   //规格id

@property (nonatomic,assign) int haveSpec;                   //规格id

@end

static BOOL _isUp = YES;

@implementation LYTGoodsDetailVC
-(NSMutableArray *)goodsSpecArr{
    if (!_goodsSpecArr) {
        _goodsSpecArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _goodsSpecArr;
}
-(NSMutableArray *)goodsSpecDetailArr{
    if (!_goodsSpecDetailArr) {
        _goodsSpecDetailArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _goodsSpecDetailArr;
}
-(NSMutableArray *)scrollImg{
    if (!_scrollImg) {
        _scrollImg = [NSMutableArray arrayWithCapacity:0];
    }
    return _scrollImg;
}
-(NSMutableArray *)defaultSelectArr{
    if (!_defaultSelectArr) {
        _defaultSelectArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _defaultSelectArr;
}
-(NSMutableDictionary *)selectSpecTypeDic{
    if (!_selectSpecTypeDic) {
        _selectSpecTypeDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _selectSpecTypeDic;
}
-(UITableView *)LYTGoodsDetailTable{
    if (!_LYTGoodsDetailTable) {
        _LYTGoodsDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, 375*kScreenWidth1, 667*kScreenHeight1) style:UITableViewStylePlain];

        _LYTGoodsDetailTable.delegate = self;
        _LYTGoodsDetailTable.dataSource = self;
        [_LYTGoodsDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultCell];
        [_LYTGoodsDetailTable registerClass:[LYTGoodsDetailCell class] forCellReuseIdentifier:GoodsDetailCell];
    }
    return _LYTGoodsDetailTable;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 667, 375,  SpecScrollHight + 200)];
        _popView.backgroundColor = [UIColor colorWithRed:1.000 green:0.988 blue:0.960 alpha:1.000];
        UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
        [window addSubview:_popView];
        
        headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, -10, 60, 60)];
        headerImg.layer.cornerRadius = 5;
        headerImg.layer.masksToBounds = YES;
        if (self.scrollImg.count > 0) {
            NSString *urlStr = [self.scrollImg[0][@"original"] stringByReplacingOccurrencesOfString:@"localhost"withString:@"192.168.0.220"];
            NSLog(@"self.scrollImg------%@",urlStr);
            [headerImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"img_error"]];
        }
//        headerImg.backgroundColor = [UIColor redColor];
        [_popView addSubview:headerImg];
        
        popNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 200, 15)];
        if (_haveSpec == 0) {
            popNameLabel.text = [NSString stringWithFormat:@"%@",self.allDataDic[@"productList"][0][@"name"]];;
        }
        
        popNameLabel.font = [UIFont systemFontOfSize:14];
        [_popView addSubview:popNameLabel];
        
        popMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 200, 15)];
        if (_haveSpec == 0) {
            popMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[self.allDataDic[@"productList"][0][@"price"] doubleValue]];
        }
        
        popMoneyLabel.font = [UIFont systemFontOfSize:14];
        [_popView addSubview:popMoneyLabel];
        
        
        popStockLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 200, 15)];
        if (_haveSpec == 0) {
            popStockLabel.text = [NSString stringWithFormat:@"库存:%d",[self.allDataDic[@"productList"][0][@"enable_store"] intValue]];;
        }
        popStockLabel.font = [UIFont systemFontOfSize:14];
        [_popView addSubview:popStockLabel];
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , 60, kScreenWidth,  SpecScrollHight + 100)];
        [_popView addSubview:scroll];
        
        
        
        for (NSDictionary *dic in self.goodsSpecDetailArr) {
            NSArray* array1 = [dic[@"specsvIdJson"] componentsSeparatedByString:@"]"];
            NSArray* array2 = [array1[0] componentsSeparatedByString:@"["];
            NSArray *useArr = [array2[1] componentsSeparatedByString:@","];
            
            
            NSMutableArray *bridgeArr = [NSMutableArray arrayWithArray:useArr];
            for (int i = 0; i < self.defaultSelectArr.count; i ++ ) {
                for (int j = 0; j < bridgeArr.count; j ++) {
                    if ([self.defaultSelectArr[i] integerValue] == [bridgeArr[j] integerValue]) {
//                        NSLog(@"useArruseArruseArr*---%@",bridgeArr);
                        if([dic[@"specs"]  rangeOfString:@"、"].location !=NSNotFound)
                        {
                            NSArray *arr = [dic[@"specs"] componentsSeparatedByString:@"、"];
                            for (int i = 0; i < arr.count; i ++) {
                                NSString *key = [NSString stringWithFormat:@"%d",i];
                                [self.selectSpecTypeDic setObject:arr[i] forKey:key];
                            }
                        }
                        else
                        {
                            NSString *key = [NSString stringWithFormat:@"%d",1];
                            [self.selectSpecTypeDic setObject:dic[@"specs"] forKey:key];
                        }
                        [bridgeArr removeObjectAtIndex:j];
                        break;
                    }
                }
                if (bridgeArr.count <= 0) {
//                    NSLog(@"bridgeArrbridgeArr222--%@",useArr);
                    break;
                }
            }
            if (bridgeArr.count <= 0) {
                NSLog(@"bridgeArrbrid111geArr11--%@-----%@",useArr,dic);
                popNameLabel.text = [NSString stringWithFormat:@"规格:%@",dic[@"specs"]];
                popStockLabel.text = [NSString stringWithFormat:@"库存:%@",dic[@"store"]];
                popMoneyLabel.text = [NSString stringWithFormat:@"金额:%@",dic[@"price"]];
                self.spec_id = dic[@"product_id"];
                
                
                
                break;
            }
            
        }
        

        __block float frameY = 0;

        for (int i = 0; i < self.goodsSpecArr.count; i ++ ) {
            NSDictionary *specDic = self.goodsSpecArr[i];
//            NSLog(@"规格-----%@",specDic);
            NSMutableArray *specTitleArr = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *specTagArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in specDic[@"valueList"]) {
                [specTitleArr addObject:dic[@"spec_value"]];
                [specTagArr addObject:dic[@"spec_value_id"]];
            }
            
            LYTSudokuView *sudokuView = [[LYTSudokuView alloc]initWithFrame:CGRectMake(0, frameY, kScreenWidth, SpecScrollHight)];
            //        sudokuView.selectType = LYTSudokuBtnSelectMultiple;
            [sudokuView configViewWithDataArr:specTitleArr DataIdArr:specTagArr title:specDic[@"spec_name"] selectIndex:[self.defaultSelectArr[i] integerValue]];
            sudokuView.selectIndex = i;
            sudokuView.delegate = self;
            NSLog(@"sudokuView.viewHight----%ld",sudokuView.viewHight);
            sudokuView.frame = CGRectMake(0, frameY, kScreenWidth, sudokuView.viewHight);
            frameY = frameY + sudokuView.viewHight;

            [scroll addSubview:sudokuView];
        }
        scroll.contentSize = CGSizeMake(kScreenWidth, frameY + 10 + 40);
        
        UILabel *countTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, frameY + 10, 80, 20)];
        countTitleLabel.text = @"购买数量";
        countTitleLabel.font = [UIFont systemFontOfSize:14];
        [scroll addSubview:countTitleLabel];
        
        // 加减+中间label
        jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jianBtn.frame = WDH_CGRectMake(270, frameY + 5, 30, 30);
        jianBtn.layer.cornerRadius = 15;
        jianBtn.layer.masksToBounds = YES;
        jianBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [jianBtn setTitle:@"-" forState:UIControlStateNormal];
        [scroll addSubview:jianBtn];
        jianBtn.tag = 1094;
        [jianBtn addTarget:self action:@selector(jiaJianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        

        countLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(300, frameY + 5, 35, 30)];
        countLabel.text = [NSString stringWithFormat:@"%ld",goodsCount];
        countLabel.font = [UIFont systemFontOfSize:18];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [scroll addSubview:countLabel];
        
        //判断减号颜色
        if ([countLabel.text intValue] > 1) {
            jianBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:89/255.0 blue:119/255.0 alpha:1];
        }else{
            jianBtn.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        }
        
        UIButton *jiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jiaBtn.frame = WDH_CGRectMake(335, frameY + 5, 30, 30);
        jiaBtn.layer.cornerRadius = 15;
        jiaBtn.layer.masksToBounds = YES;
        jiaBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        jiaBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:89/255.0 blue:119/255.0 alpha:1];
        [jiaBtn setTitle:@"+" forState:UIControlStateNormal];
        [scroll addSubview:jiaBtn];
        jiaBtn.tag = 2;
        [jiaBtn addTarget:self action:@selector(jiaJianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SpecScrollHight + 160, kScreenWidth, 40);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:253/255.0  green:70/255.0  blue:103/255.0 alpha:1];
    btn.tag = 1;
    [btn addTarget:self action:@selector(popViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:btn];
    
    
    return _popView;
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.LYTGoodsDetailTable.contentInset = UIEdgeInsetsZero;
    self.LYTGoodsDetailTable.scrollIndicatorInsets = UIEdgeInsetsZero;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //导航条的透明值
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle=UIBarStyleDefault;
    
    self.navigationController.navigationBar.translucent = NO;
//    _statusBarView.alpha = self.LYTGoodsDetailTable.contentOffset.y/ScrollContentOffSet;
    
    NSLog(@"self.LYTGoodsDetailTable.contentOffset.y-----%f",self.LYTGoodsDetailTable.contentOffset.y);
    UIView *atusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    atusBarView.backgroundColor=[UIColor clearColor];
    atusBarView.alpha = 1;
    if (_isUp) {
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        _statusBarView.backgroundColor = [UIColor clearColor] ;
    }else{
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        _statusBarView.backgroundColor = [UIColor whiteColor];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setValue:@(1)forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle=UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    _statusBarView.alpha = 1;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    //状态栏

//    _statusBarView.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 1;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.defaultSelectArr = [NSMutableArray arrayWithArray:@[@"41",@"9"]];
    
    
    //状态栏
    _statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
    _statusBarView.backgroundColor=[UIColor whiteColor];

    
    goodsCount = 1;
    
    //添加头部视图
    [self configHeaderView];
    //添加尾部视图
    [self configFooterView];
    
    
    //请求商品详情
    [self requestGoodsDetail];
    [self.view addSubview:self.LYTGoodsDetailTable];
    //添加尾部购买按钮
    [self configFooter];
    
    LYTBackView *backView = [LYTBackView shareSingle];
    backView.delegate = self;
    //自定义Nav
    [self customNavigation];
}
-(void)customNavigation{
    
    self.navigationItem.hidesBackButton = YES;
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = WDH_CGRectMake(20, -27, 30, 30);
    [_backBtn setTitle:@"<" forState:UIControlStateNormal];
    _backBtn.backgroundColor = [UIColor grayColor];
    [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.layer.cornerRadius = 15;
    _backBtn.layer.masksToBounds = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_backBtn];
    self.navigationItem.leftBarButtonItem = item;
//    [self.view addSubview:_backBtn];
}
//头部视图
-(void)configHeaderView{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 475)];
    scroll.contentSize = CGSizeMake(kScreenWidth * [self.scrollImg count], kScreenWidth);
    scroll.pagingEnabled = YES;
    scroll.backgroundColor = [UIColor whiteColor];

    for (int i=0; i<[self.scrollImg count]; i++) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:WDH_CGRectMake(375 * i, 0, 375, 475)];
        NSString *urlStr = [self.scrollImg[i][@"original"] stringByReplacingOccurrencesOfString:@"localhost"withString:@"192.168.0.220"];
        NSLog(@"self.scrollImg------%@",urlStr);
        [img sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"img_error"]];
        [scroll addSubview:img];
    }
    self.LYTGoodsDetailTable.tableHeaderView = scroll;
}
//尾部视图
-(void)configFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, FooterHight)];
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:footerView.frame];
    label.text = @"上拉查看商品详情";
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    self.LYTGoodsDetailTable.tableFooterView = footerView;
}
//加载更多时切换Scroll
-(void)configHiddenScroll{
    UIScrollView *hiddenScroll = [[UIScrollView alloc]initWithFrame:WDH_CGRectMake(0, 667, 375, 667 - 50)];
    hiddenScroll.backgroundColor = [UIColor whiteColor];
    hiddenScroll.tag = 8888;
    hiddenScroll.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0, 0 , 375, 64)];
    label.text = @"下拉返回商品";
    label.textAlignment = NSTextAlignmentCenter;
    [hiddenScroll addSubview:label];
    hiddenScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.view addSubview:hiddenScroll];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 375, 667 - 50 )];
    webView.delegate = self;
    [webView loadHTMLString:self.webMarkStr baseURL:nil];
    [hiddenScroll addSubview:webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    if (theWebView.scrollView.contentSize.height <= 100) {
        UIScrollView *scroll = [self.view viewWithTag:8888];
        scroll.contentSize = CGSizeMake(375 , 667);
    }
    theWebView.scrollView.minimumZoomScale = rw;
    theWebView.scrollView.maximumZoomScale = rw;
    theWebView.scrollView.zoomScale = rw;
}
//底部确定按钮
-(void)configFooter{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 667 * kScreenHeight1 - FooterHight *kScreenHeight1 - 64 , 375 * kScreenWidth1, FooterHight *kScreenHeight1)];
    footerView.backgroundColor = [UIColor greenColor];

    
//    UIButton *shopsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    shopsBtn.frame = WDH_CGRectMake(0, 0, 80, FooterHight) ;
//    shopsBtn.backgroundColor = [UIColor whiteColor];
//    [shopsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [shopsBtn setTitle:@"商铺" forState:UIControlStateNormal];
//    [shopsBtn addTarget:self action:@selector(addCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    shopsBtn.tag = 0;
//    [footerView addSubview:shopsBtn];
    
    UIButton *addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCartBtn.frame = WDH_CGRectMake(0, 0, 160, FooterHight) ;
    addCartBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:149/255.0 blue:169/255.0 alpha:1];
    [addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addCartBtn addTarget:self action:@selector(addCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addCartBtn.tag = 1;
    [footerView addSubview:addCartBtn];
    
    UIButton *buyCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCartBtn.frame = WDH_CGRectMake(160, 0, 225, FooterHight) ;
    buyCartBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:81/255.0 blue:113/255.0 alpha:1];
    [buyCartBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyCartBtn.tag = 2;
    [buyCartBtn addTarget:self action:@selector(addCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:buyCartBtn];
    
    
    [self.view addSubview:footerView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll--%f",scrollView.contentOffset.y);
    if (_isUp) {
        if (scrollView == self.LYTGoodsDetailTable) {
            _statusBarView.alpha = scrollView.contentOffset.y/(ScrollContentOffSet);
            [self.navigationController.navigationBar setValue:@(scrollView.contentOffset.y/(ScrollContentOffSet))forKeyPath:@"backgroundView.alpha"];
            self.navigationController.navigationBar.barStyle=UIBarStyleDefault;
            self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:scrollView.contentOffset.y/(ScrollContentOffSet)];
            
            
            CGFloat colorF_up = scrollView.contentOffset.y * 10 + 153 - ScrollContentOffSet ;
            CGFloat colorF_down = 255 - scrollView.contentOffset.y * 10 ;
            _backBtn.backgroundColor = [UIColor colorWithRed:colorF_up/255.0 green:colorF_up/255.0 blue:colorF_up/255.0 alpha:1];
            [_backBtn setTitleColor:[UIColor colorWithRed:colorF_down/255.0 green:colorF_down/255.0 blue:colorF_down/255.0 alpha:1] forState:UIControlStateNormal];
            //        NSLog(@"----tableView的内容高度------%@",NSStringFromCGSize(_LYTGoodsDetailTable.contentSize) );
        } else if (scrollView.tag == 8888){
            NSLog(@"asdasda11111111");
        }
    }else{
        _statusBarView.alpha = 1;
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    }
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"----scrollViewWillBeginDecelerating------%f",scrollView.contentOffset.y   );
    if (scrollView.contentOffset.y + _LYTGoodsDetailTable.frame.size.height - scrollView.contentSize.height   > 50.f){
        //滑到底部加载更多
        NSLog(@"滑到底部加载图片");
        UIScrollView *scroll = [self.view viewWithTag:8888];
        if (scrollView == _LYTGoodsDetailTable) {
            [UIView animateWithDuration:1 animations:^{
                _isUp = NO;
                scrollView.frame = WDH_CGRectMake(0, -667, 375, 667);
                scroll.frame = WDH_CGRectMake(0, -64, 375, 667 - 50 ) ;
                
            }];
        }
    }
    
    if (scrollView.contentOffset.y <= -64) {
        //滑到顶部更新
        NSLog(@"滑到顶部更新");
        if (scrollView.tag == 8888){
            [UIView animateWithDuration:1 animations:^{
                _isUp = YES;
                _LYTGoodsDetailTable.frame = WDH_CGRectMake(0, -64, 375, 667);
                scrollView.frame = WDH_CGRectMake(0, 667, 375, 667 - 50 ) ;
                
            }];
        }
    }
}
#pragma mark -------tableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 110;
    }else{
        return 44;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LYTGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailCell];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",_allDataDic[@"name"]];
        cell.contentLabel.text = @"";
        cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[_allDataDic[@"price"] doubleValue]];
        cell.soldLabel.text = [NSString stringWithFormat:@"赠送%d积分",[_allDataDic[@"point"] intValue]/100];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCell];
        cell.textLabel.text = @"请选择商品属性";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)addCartBtnClick:(UIButton *)sender{
//    NSLog(@"addCartBtnClick");
    if (sender.tag == 0) {
        NSLog(@"商铺");
    }else if (sender.tag == 1) {
        NSLog(@"加入购物车----%@",self.spec_id);
        if ([PublicToors judgeInfoIsNotNull:self.spec_id]) {
            if (self.haveSpec == 0) {
                [self requestGoodsAddCart1:1];
            }else{
                [self requestGoodsAddCart:1];
            }
        }else{
            Alert_Show(@"未选择规格")
        }
        
        
    }else{
        NSLog(@"立即购买----%@",self.spec_id);
        if ([PublicToors judgeInfoIsNotNull:self.spec_id]) {
            if (self.haveSpec == 0) {
                [self requestGoodsAddCart1:2];
            }else{
                [self requestGoodsAddCart:2];
            }
        }else{
            Alert_Show(@"未选择规格")
        }
    }
}
-(void)backBtnClick:(UIButton *)sender{
    NSLog(@"backBtnClick");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        //点击选择商品属性
        [self open];
    }else{
        
    }
}

#pragma mark      ------------弹出视图------------
-(void)open{
    
        [UIView animateWithDuration:0.2 animations:^{
            self.view.layer.transform = [self firstStepTransform];
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.view.layer.transform = [self secondStepTransform];
                [LYTBackView showWithView:[UIView new]];
                self.popView.frame = CGRectMake(0, SpecScrollHight, kScreenWidth, SpecScrollHight + 200);
                //            self.popView.transform = CGAffineTransformTranslate(self.popView.transform, 0, -kScreenHeight / 2.0f);
                
            }];
        }];
    
    
}
-(void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.popView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, SpecScrollHight  + 200 );
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [self.popView removeFromSuperview];
            self.popView = nil;
        }];
    }];
}
// 动画1
- (CATransform3D)firstStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DScale(transform, 0.98, 0.98, 1.0);
    transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, -30.0);
    return transform;
}


// 动画2
- (CATransform3D)secondStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstStepTransform].m34;
    transform = CATransform3DTranslate(transform, 0, kScreenHeight * -0.08, 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
}

-(void)touchBackView{
    NSLog(@"zoubuzou ");
    [self close];
}
//规格上规格按钮点击
-(void)clickBtnIndex:(NSInteger)index WithBtnInfo:(NSString *)info changeView:(LYTSudokuView *)sudokuView{
    NSLog(@"clickBtnIndex----%ld   WithBtnInfo----%@   changeView----%ld",index,info,sudokuView.selectId);
    [self.defaultSelectArr replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",sudokuView.selectId]];
    NSLog(@"self.defaultSelectArr-----%@",self.defaultSelectArr);
    NSString *key = [NSString stringWithFormat:@"%ld",index];
    [self.selectSpecTypeDic setObject:info forKey:key];
    
    for (NSDictionary *dic in self.goodsSpecDetailArr) {
        NSArray* array1 = [dic[@"specsvIdJson"] componentsSeparatedByString:@"]"];
        NSArray* array2 = [array1[0] componentsSeparatedByString:@"["];
        NSArray *useArr = [array2[1] componentsSeparatedByString:@","];
        
        
        NSMutableArray *bridgeArr = [NSMutableArray arrayWithArray:useArr];
        for (int i = 0; i < self.defaultSelectArr.count; i ++ ) {
            for (int j = 0; j < bridgeArr.count; j ++) {
                if ([self.defaultSelectArr[i] integerValue] == [bridgeArr[j] integerValue]) {
                    NSLog(@"useArruseArruseArr*---%@",bridgeArr);
                    if([dic[@"specs"]  rangeOfString:@"、"].location !=NSNotFound)
                    {
                        NSArray *arr = [dic[@"specs"] componentsSeparatedByString:@"、"];
                        for (int i = 0; i < arr.count; i ++) {
                            NSString *key = [NSString stringWithFormat:@"%d",i];
                            [self.selectSpecTypeDic setObject:arr[i] forKey:key];
                        }
                    }
                    else
                    {
                        NSString *key = [NSString stringWithFormat:@"%d",1];
                        [self.selectSpecTypeDic setObject:dic[@"specs"] forKey:key];
                    }
                    [bridgeArr removeObjectAtIndex:j];
                    break;
                }
            }
            if (bridgeArr.count <= 0) {
                NSLog(@"bridgeArrbridgeArr222--%@",useArr);
                break;
            }
        }
        if (bridgeArr.count <= 0) {
            NSLog(@"bridgeArrbrid111geArr11--%@-----%@",useArr,dic);
            popNameLabel.text = [NSString stringWithFormat:@"规格:%@",dic[@"specs"]];
            popStockLabel.text = [NSString stringWithFormat:@"库存:%@",dic[@"store"]];
            popMoneyLabel.text = [NSString stringWithFormat:@"金额:%@",dic[@"price"]];
            self.spec_id = dic[@"product_id"];
            break;
        }
    }
    
    
}
//规格上加减按钮点击
-(void)jiaJianBtnClick:(UIButton *)sender{
    NSLog(@"jiaJianBtnClick----%ld",sender.tag);
    
    int count = [countLabel.text intValue];
    if (sender.tag == 1094) {
        count --;
        //处理减号事件
        if (count >= 2) {
            jianBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:89/255.0 blue:119/255.0 alpha:1];
        }else{
            jianBtn.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            count = 1;
        }
    }else{
        jianBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:89/255.0 blue:119/255.0 alpha:1];
        count ++;
        //处理加号事件
    }
    countLabel.text = [NSString stringWithFormat:@"%d",count];
    goodsCount = count;
    NSLog(@"countLabel.textcountLabel.text----%@",countLabel.text);
}
//规格上确定按钮点击
-(void)popViewBtnClick:(UIButton *)sender{
    NSLog(@"popViewBtnClick");
    [LYTBackView dissMiss];
    [self close];
    NSLog(@"self.selectSpecTypeDic-----%@",self.selectSpecTypeDic);
    NSIndexPath *index1 =  [NSIndexPath indexPathForItem:sender.tag inSection:0];
    UITableViewCell *cell =  [_LYTGoodsDetailTable cellForRowAtIndexPath:index1];
    cell.textLabel.textColor = [UIColor redColor];
    
    NSString *specStr = @"";
    for (int i = 0; i < self.selectSpecTypeDic.count; i ++ ) {
        NSString *key = [NSString stringWithFormat:@"%d",i];
        if (i <= 0) {
            specStr = [NSString stringWithFormat:@"规格:%@",self.selectSpecTypeDic[key]];
//            return;
        }else{
            specStr = [NSString stringWithFormat:@"%@-%@",specStr,self.selectSpecTypeDic[key]];
//            return;
        }
    }
    
    cell.textLabel.text = specStr;
}

#pragma mark-------netWork

-(void)requestGoodsDetail{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    NSLog(@"urlaa-------%@",self.goodsId);
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/goods/detail.do?id=%@",_goodsId];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求商品详情%@",responseObject);
        
        [SVProgressHUD dismiss];
        if ([[responseObject[@"data"][@"haveSpec"] class] isEqual:[NSNull class]]) {
            self.haveSpec = 0;
            self.spec_id = @"1";
        }else if (responseObject[@"data"][@"haveSpec"]==nil){
            self.haveSpec = 0;
            self.spec_id = @"1";
        }else{
            self.haveSpec = [responseObject[@"data"][@"haveSpec"]intValue];
            if (self.haveSpec == 0) {
                self.spec_id = @"1";
            }
            [self.goodsSpecArr addObjectsFromArray:responseObject[@"data"][@"specList"]];
            self.goodsSpecDetailArr = responseObject[@"data"][@"productList"];
        }
        
        _allDataDic = responseObject[@"data"];
        [self.scrollImg addObjectsFromArray:responseObject[@"data"][@"galleryList"]];
        
        if ([[responseObject[@"data"][@"intro"] class] isEqual:[NSNull class]]) {
            
        }else if (responseObject[@"data"][@"intro"]==nil){
            
        }else{
            self.webMarkStr = responseObject[@"data"][@"intro"];
            //添加隐藏的Scroll
            [self configHiddenScroll];
        }
        
        
        [self configHeaderView];
        
        [self.LYTGoodsDetailTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求商品详情失败%@",error);
        [SVProgressHUD dismiss];
    }];
    
}

//加入购物车
-(void)requestGoodsAddCart:(int)fromIndex{
    NSLog(@"asdasd-countLabel.text--%@",countLabel.text);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    NSLog(@"urlaa-------%@",self.goodsId);
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/cart/add-product.do?token=%@&productid=%@&num=%ld",tokenArr[1],self.spec_id,goodsCount];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求加入购物车%@",responseObject);
        if ([responseObject[@"result"] intValue] == 1) {
            if (fromIndex == 1) {
                Alert_Show(@"添加成功")
            }else{
                ShopCartVC *vc = [[ShopCartVC alloc]init];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        [SVProgressHUD dismiss];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求加入购物车失败%@",error);
        [SVProgressHUD dismiss];
    }];
    
}
//加入购物车
-(void)requestGoodsAddCart1:(int)fromIndex{
    NSLog(@"asdasd-countLabel.text--%@",countLabel.text);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str componentsSeparatedByString:@" "];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    NSLog(@"urlaa-------%@",self.goodsId);
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/cart/add-goods.do?token=%@&goodsid=%@&num=%ld",tokenArr[1],_goodsId,goodsCount];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求加入购物车11%@",responseObject);
        if ([responseObject[@"result"] intValue] == 1) {
            if (fromIndex == 1) {
                Alert_Show(@"添加成功")
            }else{
                ShopCartVC *vc = [[ShopCartVC alloc]init];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            NSString *str1 = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            Alert_Show(str1)
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求加入购物车失败%@",error);
        [SVProgressHUD dismiss];
    }];
    
}
@end
