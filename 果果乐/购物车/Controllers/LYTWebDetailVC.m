//
//  LYTWebDetailVC.m
//  LSK
//
//  Created by 云盛科技 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import "LYTWebDetailVC.h"
#import "ShopCartVC.h"
#import "LYTShareVC.h"
//#import "WSSNameAuthenticationViewController.h"
@interface LYTWebDetailVC ()
@property(nonatomic,retain)NSArray *arr;

@end

@implementation LYTWebDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)configNav{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_ico_write"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)shareBtnClick{
    //分享
    NSDictionary * myInfo =[[NSUserDefaults standardUserDefaults]objectForKey:@"MyInfo"];
    if (myInfo[@"userVo"][@"spreadCode"] != nil) {
        [LYTShareVC shareImage:[NSString stringWithFormat:@"%@%@",LSKurl1,_picName] Title:@"唯多惠精品" content:[NSString stringWithFormat:@"%@ \n精品生活--爱到要剁手",_contentStr] AndUrl:[NSString stringWithFormat:shareUrl,_goods_id,myInfo[@"userVo"][@"spreadCode"]]];
    }else{
        Alert_go_push(SYLoginPage, @"您还没有登陆,请前往登录")
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"";
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 38*kScreenHeight1, 90*kScreenWidth1, 1*kScreenHeight1)];
    label1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label1];
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    _webView1 = [[UIWebView alloc] init];
    [self.view addSubview:self.webView1];
    self.webView1.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    self.webView1.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:goodsDetail,_goods_id]]];
    [self.webView1 loadRequest:request];
    
    [self configNav];
    //创建桥 用来进行从JS代码那里获取 信息
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView1 handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"--%@", data);
        //        _ary = data;
        NSString *a = data;
        NSString *b = [a substringToIndex:3];
        if (![b isEqualToString:@"App"]){
            NSLog(@"数据%@", data);
            if([data rangeOfString:@","].location !=NSNotFound){
            
                _arr = [data componentsSeparatedByString:@","];
                if ([_arr[2] intValue] == 2)
                {
                    //加入购物车,停留在本页面
                    [self requestAddShopCardWithType:2];
                    
                }else
                {
                    //立即购买  进入购物车
                    [self requestAddShopCardWithType:1];
                }

            }else{
                ShopCartVC *vc = [[ShopCartVC alloc]init];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
                
            //格式 ---商品id, 数量, 规格---
        } else {
            
        }
    }];
    //发送信息
    [self.bridge send:@"给Web传递的信息"];
}

//加入购物车
-(void)requestAddShopCardWithType:(int)type{
    
    NSMutableDictionary *goods_specDic = [[NSMutableDictionary alloc]initWithCapacity:0];
   
        if ([_arr[3] rangeOfString:@"_"].location !=NSNotFound) {
            //包含
            NSArray *speckey = [_arr[3] componentsSeparatedByString:@"_"];
            NSArray *specValue = [_arr[4] componentsSeparatedByString:@"_"];
            for (int i = 0 ;i < speckey.count ; i ++) {
                NSLog(@"%@--加入购物车--%@",specValue[i],speckey[i]);
                [goods_specDic setObject:specValue[i] forKey:speckey[i]];
            }
        }else{
            //不包含
            NSLog(@"%@--加入购物车--%@",_arr[4],_arr[3]);
            [goods_specDic setObject:_arr[4] forKey:_arr[3]];
        }
    
    
    NSDictionary * myInfo =[[NSUserDefaults standardUserDefaults]objectForKey:@"MyInfo"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:addShopCart] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *dic;
    NSLog(@"_myInfo-----%@",myInfo);
    if (myInfo != nil) {
        NSString *IsJinKouStr = [_arr lastObject];
        NSArray *IsJKArr = [IsJinKouStr componentsSeparatedByString:@"|"];
        NSLog(@"s最后一个 数字---------%@-----%@",IsJinKouStr,IsJKArr);
        if ([IsJKArr[0] isEqualToString:@"1"]) {
            if ([myInfo[@"realnameVo"][@"identityCardNo"]length]>13) {
                
            }else{
                Alert_go_push(WSSNameAuthenticationViewController, @"提示进口物品，保税清关，需要进行实名认证信息！请实名认证后再购买")
                
                return;
            }
        }
    }else{
        if ([IsLogin LoginRequest] == 0) {
            SYLoginPage *vc = [[SYLoginPage alloc]init];
            vc.type = 1;
            [self presentViewController:vc animated:YES completion:nil];
        }else{
            [IsLogin MyInfo];
        }
    }
    if (![_arr[3] isEqualToString:@""]) {
        dic = @{@"uid":myInfo[@"userVo"][@"id"],@"goods_id":_goods_id,@"goods_num":_arr[1],@"goods_spec":goods_specDic};
    }else{
        dic = @{@"uid":myInfo[@"userVo"][@"id"],@"goods_id":_goods_id,@"goods_num":_arr[1]};
    }
   
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    [request setHTTPMethod:@"POST"];//POST请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"没有登录会返回什么错误------%@",connectionError);
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response--2121---%@",dic);
            if ([dic[@"error_code"] isEqualToString:@"000"]) {
                if (type == 1) {
                    ShopCartVC *vc = [[ShopCartVC alloc]init];
                    vc.type = 1;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    Alert_Show(@"加入购物车成功")
                }
            }else{
                NSString *errorStr = [ErrorCode initWithErrorCode:[NSString stringWithFormat:@"%@", dic[@"error_code"]] message:dic[@"error_msg"]];
                Alert_Show(errorStr)
            }
        }
        
        
        
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
