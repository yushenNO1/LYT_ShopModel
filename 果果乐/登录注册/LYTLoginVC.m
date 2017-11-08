//
//  LYTLoginVC.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/14.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTLoginVC.h"
#import "LYTRegisterVC.h"
@interface LYTLoginVC ()
{
    NSTimer *timer;
}
@property(nonatomic,retain)UIButton *GetBtn;
@property (nonatomic, strong) UIView * PickVC;  //弹窗
@property(nonatomic,assign) NSInteger time;
@property (nonatomic, strong) UIButton * Btn;
@end

@implementation LYTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}
- (void) configView {
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake(0, 0, 375, 667)];
    backImageView.image = [UIImage imageNamed:@"图层-0-拷贝"];
    [self.view addSubview:backImageView];
    
    
    
    
    UILabel * TopLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake(50, 250, 275, 40)];
    TopLabel.backgroundColor = [UIColor whiteColor];
    TopLabel.layer.cornerRadius = 5;
    TopLabel.layer.masksToBounds = YES;
    TopLabel.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1].CGColor;
    TopLabel.layer.borderWidth = 1.0f;
    [self.view addSubview:TopLabel];
    
    UIImageView * leftImage = [[UIImageView alloc] initWithFrame:WDH_CGRectMake(63, 262.5, 12, 15)];
    leftImage.image = [UIImage imageNamed:@"输入手机号"];
    [self.view addSubview:leftImage];
    
    UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake(79, 250, 40, 40)];
    Label.text = @"+86";
    Label.textColor = [UIColor colorWithRed:65 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1];
    [self.view addSubview:Label];
    
    UITextField * peopleTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake(119, 251, 200, 38)];
    peopleTf.placeholder = @"请输入手机号";
    peopleTf.tag = 1001;
    peopleTf.keyboardType = UIKeyboardTypeNumberPad;
    peopleTf.delegate = self;
    peopleTf.font = [UIFont systemFontOfSize:15*kScreenHeight1];
    [self.view addSubview:peopleTf];
    
    UILabel * BottomLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake(50, 310, 275, 40)];
    BottomLabel.backgroundColor = [UIColor whiteColor];
    BottomLabel.layer.cornerRadius = 5;
    BottomLabel.layer.masksToBounds = YES;
    BottomLabel.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1].CGColor;
    BottomLabel.layer.borderWidth = 1.0f;
    [self.view addSubview:BottomLabel];
    
    UIImageView * leftImage1
    = [[UIImageView alloc] initWithFrame:WDH_CGRectMake(63, 322.5, 12, 15)];
    leftImage1.image = [UIImage imageNamed:@"输入密码"];
    [self.view addSubview:leftImage1];
    
    UITextField * peopleTf1 = [[UITextField alloc] initWithFrame:WDH_CGRectMake(119, 311, 200, 38)];
    peopleTf1.placeholder = @"请输入密码";
    peopleTf1.tag = 1002;
    peopleTf1.secureTextEntry = YES;
    //    peopleTf1.keyboardType = UIKeyboardTypeNumberPad;
    peopleTf1.delegate = self;
    peopleTf1.font = [UIFont systemFontOfSize:15*kScreenHeight1];
    [self.view addSubview:peopleTf1];
    
    _GetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _GetBtn.frame = WDH_CGRectMake(232, 317.5, 80, 25);
    _GetBtn.layer.cornerRadius = 5;
    _GetBtn.layer.masksToBounds = YES;
    _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_GetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight1];
    [_GetBtn addTarget:self action:@selector(handleView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GetBtn];
    
    UIButton * RegisBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    RegisBtn.frame = WDH_CGRectMake(253, 351, 70, 40);
    RegisBtn.backgroundColor = [UIColor clearColor];
    [RegisBtn setTitleColor:[UIColor colorWithRed:65 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1] forState:UIControlStateNormal];
    [RegisBtn setTitle:@"注册 >" forState:UIControlStateNormal];
    [RegisBtn addTarget:self action:@selector(handleRegis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisBtn];
    
    UIButton * LoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    LoginBtn.tag = 1;
    LoginBtn.frame = WDH_CGRectMake(50, 398, 273, 40);
    LoginBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1.0];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];
    LoginBtn.layer.cornerRadius = 5;
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
}
- (void) handleView
{
    
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake(0, 0, 375, 667)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    
    //修改登录
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake(67, 245, 233, 195)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 20001;
    [self.view addSubview:view];
    
    NSArray * ary = @[@"手机号", @"新密码", @"确认新密码", @"验证码"];
    NSArray * ary1 = @[@"请输入", @"请输入", @"请输入", @"请输入"];
    for (int i = 0; i < 4; i++) {
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake(10, 50 + 30 * i, 213, 1)];
        lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
        [view addSubview:lineLabel];
        
        UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake(10, 20 + 30 * i, 80, 29)];
        Label.text = ary[i];
        //        Label.textColor = [UIColor redColor];
        //        Label.backgroundColor = [UIColor grayColor];
        Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        Label.font = [UIFont systemFontOfSize:15*kScreenHeight1];
        [view addSubview:Label];
        
        UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake(100, 23 + 30 * i, 120, 26)];
        textTf.placeholder = ary1[i];
        textTf.tag = 70000 + i;
        textTf.delegate = self;
        [textTf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [view addSubview:textTf];
    }
    
    self.GetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _GetBtn.frame = WDH_CGRectMake(180, 115, 40, 20);
    _GetBtn.layer.cornerRadius = 5;
    _GetBtn.layer.masksToBounds = YES;
    _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_GetBtn setTitle:@"获取" forState:UIControlStateNormal];
    _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight1];
    [_GetBtn addTarget:self action:@selector(handleGet1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_GetBtn];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake(10, 143, 213, 12)];
    textLabel.text = @"密码是6-16位的数字, 字母组合";
    textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1];
    textLabel.font = [UIFont systemFontOfSize:10*kScreenHeight1];
    [view addSubview:textLabel];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake((233 - 50) / 2, 160, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    buyBtn.tag = 30001;
    [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleChange) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake(210.5, 7.5, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"修改密码关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff10) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    
}


- (void) handleOff10
{
    _time = 60;
    [timer invalidate];
    [_GetBtn removeFromSuperview];
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:20001] removeFromSuperview];
}

- (void) handleChange
{
    UITextField * Tf = [self.view viewWithTag:70000];
    UITextField * Tf1 = [self.view viewWithTag:70001];
    UITextField * Tf2 = [self.view viewWithTag:70002];
    UITextField * Tf3 = [self.view viewWithTag:70003];
    if (Tf.text.length != 0) {
        if ([Tf2.text isEqualToString:Tf1.text]) {
            if (Tf1.text.length >= 6) {
                if (Tf1.text.length <= 16) {
                    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    manager.responseSerializer = [AFJSONResponseSerializer serializer];
                    [manager POST:[NSString stringWithFormat:GGLWJMM, Tf.text, Tf2.text, Tf3.text] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"注册信息:%@", responseObject);
                        if ([responseObject[@"code"] intValue] == 0) {
                            [self handleOff10];
                            Alert_Show(@"修改成功");
                        } else if ([responseObject[@"code"] intValue] == 300301) {
                            Alert_Show(@"服务器繁忙, 请稍后再试");
                        } else if ([responseObject[@"code"] intValue] == 300302) {
                            Alert_Show(@"参数错误");
                        } else if ([responseObject[@"code"] intValue] == 702) {
                            Alert_Show(@"手机格式不正确");
                        } else if ([responseObject[@"code"] intValue] == 703) {
                            Alert_Show(@"密码格式不正确");
                        } else if ([responseObject[@"code"] intValue] == 854) {
                            Alert_Show(@"用户不存在哦");
                        } else if ([responseObject[@"code"] intValue] == 1000) {
                            NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                            Alert_Show(str);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"失败:%@", error);
                    }];
                } else {
                    Alert_Show(@"新密码不符合要求")
                }
            } else {
                Alert_Show(@"新密码不符合要求")
            }
        } else {
            Alert_Show(@"两次输入新密码不一致")
        }
    } else {
        Alert_Show(@"手机号不能为空")
    }
}

- (void) handleGet1 {
    _GetBtn.enabled = NO;
    UITextField * peopleTf = [self.view viewWithTag:70000];
    if (peopleTf.text.length == 0) {
        Alert_Show(@"请先输入手机号");
    } else {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:GGLYZM, peopleTf.text, @"2"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"注册信息:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                [self timerStart];
            } else if ([responseObject[@"code"] intValue] == 300301) {
                _GetBtn.enabled = YES;
                Alert_Show(@"服务器繁忙, 请稍后再试");
            } else if ([responseObject[@"code"] intValue] == 300302) {
                _GetBtn.enabled = YES;
                Alert_Show(@"参数错误");
            } else if ([responseObject[@"code"] intValue] == 702) {
                _GetBtn.enabled = YES;
                Alert_Show(@"手机格式不正确");
            } else if ([responseObject[@"code"] intValue] == 701) {
                _GetBtn.enabled = YES;
                Alert_Show(@"手机号已注册");
            } else if ([responseObject[@"code"] intValue] == 650) {
                _GetBtn.enabled = YES;
                Alert_Show(@"您的操作过于频繁，请稍后再试");
            } else if ([responseObject[@"code"] intValue] == 854) {
                _GetBtn.enabled = YES;
                Alert_Show(@"手机号未注册");
            } else if ([responseObject[@"code"] intValue] == 1000) {
                _GetBtn.enabled = YES;
                NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                Alert_Show(str);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            _GetBtn.enabled = YES;
            NSLog(@"失败:%@", error);
        }];
        
    }
}

-(void)timerStart{
    _time = 60;
    [_GetBtn setTitle:[NSString stringWithFormat:@"(%lds)",_time] forState:UIControlStateNormal];
    _GetBtn.enabled = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBegin) userInfo:nil repeats:YES];
}

-(void)timerBegin
{
    _time --;
    [_GetBtn setTitle:[NSString stringWithFormat:@"(%lds)",_time] forState:UIControlStateNormal];
    if (_time <= 0){
        [timer invalidate];
        timer = nil;
        _GetBtn.enabled = YES;
        [_GetBtn setTitle:[NSString stringWithFormat:@"获取"] forState:UIControlStateNormal];
    }
}


//注册
- (void) handleRegis {
    LYTRegisterVC * regisVC = [[LYTRegisterVC alloc] init];
    [self.navigationController pushViewController:regisVC animated:YES];
}

//登录
- (void) handleLogin {
    UIButton * Btn = [self.view viewWithTag:1];
    Btn.userInteractionEnabled = NO;
    [self LoginRequest];
}

//登录请求
- (void) LoginRequest {
    UIButton * Btn = [self.view viewWithTag:1];
    UITextField * peopleTf = [self.view viewWithTag:1001];
    UITextField * peopleTf1 = [self.view viewWithTag:1002];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"Basic YXBwOjEyMzQ1Ng==" forHTTPHeaderField:@"Authorization"];
    
    [manager POST:[NSString stringWithFormat:GGLDL, peopleTf.text, peopleTf1.text] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录请求%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",responseObject[@"access_token"]];
        NSLog(@"tokentoken%@",tokenStr);
        
        if (responseObject[@"access_token"] != nil) {
            Btn.userInteractionEnabled = YES;
            [[NSUserDefaults standardUserDefaults]setObject:tokenStr  forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"refresh_token"] forKey:@"refresh_token"];
//            MainVC * mainVC = [[MainVC alloc] init];
//            mainVC.UserId = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        if ([error code] == -1009) {
            
        } else if ([error code] == -1001) {
            
        } else{
            if([[error localizedDescription] rangeOfString:@"("].location !=NSNotFound){
                NSArray *arr = [[error localizedDescription] componentsSeparatedByString:@"("];
                NSArray *arr1 = [arr[1] componentsSeparatedByString:@")"];
                if ([arr1[0] integerValue] == 401 || [arr1[0] integerValue] == 403 || [arr1[0] integerValue] == 400) {
                    Alert_Show(@"账号或密码错误");
                } else if ([arr1[0] integerValue] == 502){
                    Alert_Show(@"服务器维护中");
                } else {
                    Alert_Show(@"网络链接错误");
                }
            }
        }
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
