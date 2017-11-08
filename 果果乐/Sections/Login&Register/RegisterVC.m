//
//  RegisterVC.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "RegisterVC.h"
#import "LoginVC.h"
#import "MainVC.h"
#import <AVFoundation/AVFoundation.h>
@interface RegisterVC ()<UITextFieldDelegate, AVAudioPlayerDelegate>
{
    NSTimer *timer;
}
@property (nonatomic, strong) AVAudioPlayer * player;
@property(nonatomic,assign) NSInteger time;
@property (nonatomic, strong) UIButton * GetBtn;
@property (nonatomic, strong) UIButton * Btn;
@end

@implementation RegisterVC
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self paly];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    NSLog(@"%f--%f", self.view.bounds.size.width, self.view.bounds.size.height);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
   
}

- (void) paly {
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"登录页面" ofType:@"mp3"]] error:nil];
    _player.volume = 0.8;
    _player.delegate = self;
    _player.numberOfLoops = MAXFLOAT;
    NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
    if ([musicStr isEqualToString:@"1"]) {
        [_player play];
    } else {
        
    }
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    [_player play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_player stop];//停止
}

- (void) handleOff
{
    NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
    if ([musicStr isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"music"];
        [_Btn setBackgroundImage:[UIImage imageNamed:@"off@3x"] forState:UIControlStateNormal];
        [_player stop];//停止
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"music"];
        [_Btn setBackgroundImage:[UIImage imageNamed:@"on@3x"] forState:UIControlStateNormal];
        [_player play];//播放
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    CGRect frame = textField.frame;
    CGFloat heights = self.view.frame.size.height;
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0, 0,width,height);
    self.view.frame = rect;
    return YES;
}

- (void) configView {
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    backImageView.image = [UIImage imageNamed:@"图层-0-拷贝"];
    [self.view addSubview:backImageView];
    
    self.Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _Btn.frame = WDH_CGRectMake1(607, 20, 40, 40);
    NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
    if ([musicStr isEqualToString:@"1"]) {
        [_Btn setBackgroundImage:[UIImage imageNamed:@"on@3x"] forState:UIControlStateNormal];
        [_player play];//播放
    } else {
        [_Btn setBackgroundImage:[UIImage imageNamed:@"off@3x"] forState:UIControlStateNormal];
        [_player stop];//播放
    }
    [_Btn addTarget:self action:@selector(handleOff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Btn];
    
    UILabel * TopLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(208, 60, 273, 40)];
    TopLabel.backgroundColor = [UIColor whiteColor];
    TopLabel.layer.cornerRadius = 5;
    TopLabel.layer.masksToBounds = YES;
    TopLabel.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1].CGColor;
    TopLabel.layer.borderWidth = 1.0f;
    [self.view addSubview:TopLabel];
    
    UIImageView * leftImage = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(221, 72.5, 12, 15)];
    leftImage.image = [UIImage imageNamed:@"输入手机号"];
    [self.view addSubview:leftImage];

    UITextField * peopleTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(245, 61, 200, 38)];
    peopleTf.placeholder = @"请输入手机号";
    peopleTf.tag = 1001;
    peopleTf.keyboardType = UIKeyboardTypeNumberPad;
    peopleTf.delegate = self;
    peopleTf.font = [UIFont systemFontOfSize:15*kScreenHeight2];
    [self.view addSubview:peopleTf];
    
    //验证码
    UILabel * MidLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(208, 115, 273, 40)];
    MidLabel.backgroundColor = [UIColor whiteColor];
    MidLabel.layer.cornerRadius = 5;
    MidLabel.layer.masksToBounds = YES;
    MidLabel.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1].CGColor;
    MidLabel.layer.borderWidth = 1.0f;
    [self.view addSubview:MidLabel];
    
    UIImageView * leftImage2 = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(221, 127.5, 12, 15)];
    leftImage2.image = [UIImage imageNamed:@"验证码"];
    [self.view addSubview:leftImage2];
    
    UITextField * peopleTf3 = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(245, 116, 200, 38)];
    peopleTf3.placeholder = @"请输入验证码";
    peopleTf3.tag = 1003;
    peopleTf3.keyboardType = UIKeyboardTypeNumberPad;
    peopleTf3.delegate = self;
    peopleTf3.font = [UIFont systemFontOfSize:15*kScreenHeight2];
    [self.view addSubview:peopleTf3];
    
    self.GetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _GetBtn.frame = WDH_CGRectMake1(390, 122.5, 80, 25);
    _GetBtn.layer.cornerRadius = 5;
    _GetBtn.layer.masksToBounds = YES;
    _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_GetBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [_GetBtn addTarget:self action:@selector(handleGet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GetBtn];
    
    
    UILabel * BottomLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(208, 170, 273, 40)];
    BottomLabel.backgroundColor = [UIColor whiteColor];
    BottomLabel.layer.cornerRadius = 5;
    BottomLabel.layer.masksToBounds = YES;
    BottomLabel.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1].CGColor;
    BottomLabel.layer.borderWidth = 1.0f;
    [self.view addSubview:BottomLabel];
    
    UIImageView * leftImage1 = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(221, 182.5, 12, 15)];
    leftImage1.image = [UIImage imageNamed:@"分享人手机号"];
    [self.view addSubview:leftImage1];
    
    UITextField * peopleTf1 = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(245, 171, 200, 38)];
    peopleTf1.placeholder = @"请输入分享人手机号";
    peopleTf1.tag = 1002;
    peopleTf1.keyboardType = UIKeyboardTypeNumberPad;
    peopleTf1.delegate = self;
    peopleTf1.font = [UIFont systemFontOfSize:15*kScreenHeight2];
    [self.view addSubview:peopleTf1];
    
    UIButton * RegisBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    RegisBtn.frame = WDH_CGRectMake1(381, 216, 100, 40);
    RegisBtn.backgroundColor = [UIColor clearColor];
    [RegisBtn setTitleColor:[UIColor colorWithRed:65 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1] forState:UIControlStateNormal];
    [RegisBtn setTitle:@"已有账号/登录" forState:UIControlStateNormal];
    [RegisBtn addTarget:self action:@selector(handleRegis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisBtn];
    
    UIButton * LoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    LoginBtn.frame = WDH_CGRectMake1(208, 263, 273, 40);
    LoginBtn.tag = 1;
    LoginBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1.0];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];
    LoginBtn.layer.cornerRadius = 5;
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
}

- (void) handleGet {
    _GetBtn.enabled = NO;
    UITextField * peopleTf = [self.view viewWithTag:1001];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:GGLYZM, peopleTf.text, @"1"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

-(void)timerStart{
    _time = 60;
    [_GetBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",_time] forState:UIControlStateNormal];
    _GetBtn.enabled = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBegin) userInfo:nil repeats:YES];
}

-(void)timerBegin
{
    _time --;
    [_GetBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",_time] forState:UIControlStateNormal];
    if (_time <= 0){
        [timer invalidate];
        timer = nil;
        _GetBtn.enabled = YES;
        [_GetBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
    }
}

//登录
- (void) handleRegis {
    [self.navigationController popViewControllerAnimated:YES];
}

//注册
- (void) handleLogin {
    UIButton * Btn = [self.view viewWithTag:1];
    Btn.userInteractionEnabled = NO;
    UITextField * peopleTf = [self.view viewWithTag:1001];
    UITextField * peopleTf1 = [self.view viewWithTag:1002];
    UITextField * peopleTf2 = [self.view viewWithTag:1003];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:GGLZC, peopleTf.text, peopleTf1.text, @"", peopleTf2.text] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"注册信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self LoginRequest];
        } else if ([responseObject[@"code"] intValue] == 1000) {
            Btn.userInteractionEnabled = YES;
            NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
            Alert_Show(str);
        } else {
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Btn.userInteractionEnabled = YES;
        NSLog(@"失败:%@", error);
    }];
}

//登录请求
- (void) LoginRequest {
    UIButton * Btn = [self.view viewWithTag:1];
    UITextField * peopleTf = [self.view viewWithTag:1001];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"Basic YXBwOjEyMzQ1Ng==" forHTTPHeaderField:@"Authorization"];
    
    [manager POST:[NSString stringWithFormat:GGLDL, peopleTf.text, peopleTf.text] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录请求%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",responseObject[@"access_token"]];
        NSLog(@"tokentoken%@",tokenStr);
        
        if (responseObject[@"access_token"] != nil) {
            Btn.userInteractionEnabled = YES;
            [[NSUserDefaults standardUserDefaults]setObject:tokenStr  forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"refresh_token"] forKey:@"refresh_token"];
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[MainVC class]]) {
                    //                     vc.UserId = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
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
