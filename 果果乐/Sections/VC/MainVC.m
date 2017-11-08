//
//  MainVC.m
//  果果乐
//
//  Created by 张敬文 on 2017/6/27.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "MainVC.h"
#import "LoginVC.h"
#import "DCPaymentView.h"
#import "GDCell.h"
#import "SZCell.h"
#import "ZDCell.h"
#import "FSCell.h"
#import "SYMessageCell.h"
#import "SYMessage.h"
#import <UShareUI/UShareUI.h>
#import <AlipaySDK/AlipaySDK.h>
#import <AVFoundation/AVFoundation.h>
#import "LYTLifeTableVC.h"

@interface MainVC ()<UIScrollViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate,UIWebViewDelegate, UMSocialHandlePlatformTypeDelegate>
{
    NSTimer *timer;
}
@property(nonatomic,assign) NSInteger time;
@property (nonatomic, strong) AVAudioPlayer * player;
@property (nonatomic, strong) UIImageView * HeadImageView; //头像
@property (nonatomic, strong) UILabel * nickName;  //昵称
@property (nonatomic, strong) UILabel * grade;     //等级
@property (nonatomic, strong) UILabel * peerages;  //爵位
@property (nonatomic, strong) UIImageView * peerageImage;  //爵位图

@property (nonatomic, strong) UILabel * moneyLabel;     //资金
@property (nonatomic, strong) UILabel * pipaLabel;      //琵琶
@property (nonatomic, strong) UILabel * longyanLabel;   //龙眼
@property (nonatomic, strong) UILabel * yeziLabel;      //椰子

@property (nonatomic, strong) UIImageView * leftImage;  //挂单
@property (nonatomic, strong) UIImageView * rightImage; //挂单记录

@property (nonatomic, strong) UIScrollView * mainScroll;//土地根视图
@property (nonatomic, strong) UIView * PickVC;  //弹窗
@property (nonatomic, strong) UIView * PickVC1;  //弹窗

@property (nonatomic, strong) UILabel * NumLabel1;      //号牌
@property (nonatomic, strong) UILabel * NumLabel;      //号牌
@property (nonatomic, copy) NSString * Num;      //记录土地位置
@property (nonatomic, strong) UILabel * ActiveLabel;      //活跃度
//个人信息储存
@property (nonatomic, copy) NSString * seedNum;   //记录种子选中数量
@property (nonatomic, copy) NSString * seedId;   //种子Id
@property (nonatomic, copy) NSString * seed;   //种子
@property (nonatomic, strong) NSDictionary * InfoDic; //个人信息
@property (nonatomic, strong) NSMutableArray * SeedAry; //全部种子
@property (nonatomic, strong) NSMutableArray * SeedAry1; //仓库种子
@property (nonatomic, strong) NSMutableArray * SeedAry2; //偷取仓库种子
@property (nonatomic, strong) NSArray * TDAry;   //土地
@property (nonatomic, strong) NSArray * FenSiAry;   //土地
@property (nonatomic, copy) NSString * bankCode;   //银行卡标识
@property (nonatomic, strong) NSDictionary * bankDic;   //银行卡字典

@property (nonatomic,  strong) NSArray * GDdataAry;
@property (nonatomic,  strong) NSMutableArray * ZDdataAry;
@property (nonatomic,  strong) NSArray * SMdataAry;

@property (nonatomic,  strong) NSMutableArray * messegeDataAry;

@property (nonatomic,  strong) NSDictionary * SeedDic;  //种子购买商城
@property (nonatomic,  strong) UIPageControl *page;   //分页

@property (strong, nonatomic) CALayer *scaleLayer;   //采摘呼吸动画
@property (strong, nonatomic) CALayer *scaleLayer1;   //施肥呼吸动画
@property (strong, nonatomic) CALayer *scaleLayer2;   //施肥呼吸动画
@property (strong, nonatomic) UIImageView *scaleLayer3;   //移动动画
//支付需要
@property (nonatomic, copy) NSString * pay_trade_no;   //订单编号
//调起第三方支付需要
@property (nonatomic, copy) NSString * order;
@property (nonatomic, copy) NSString * amount;
@property (nonatomic, copy) NSString * orderType;
@property (nonatomic, copy) NSString * Type;
@property (nonatomic, copy) NSString * type;

//偷取
@property (nonatomic,  strong) NSMutableArray * StealAry;
@property(nonatomic,assign) CGFloat TouQu;
@property (nonatomic, strong) UIScrollView * scroll;
//验证码
@property (nonatomic, strong) UIButton * GetBtn;
//累积资金
@property (nonatomic, copy) NSString * lmoney;
@property (nonatomic, copy) NSString * i;

@property(nonatomic,assign) NSInteger ZzCode;
@end

@implementation MainVC
-(NSMutableArray *)messegeDataAry{
    if (!_messegeDataAry) {
        _messegeDataAry = [NSMutableArray arrayWithCapacity:0];
    }
    return _messegeDataAry;
}

-(NSMutableArray *)StealAry{
    if (!_StealAry) {
        _StealAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _StealAry;
}

-(NSMutableArray *)ZDdataAry{
    if (!_ZDdataAry) {
        _ZDdataAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _ZDdataAry;
}

-(NSMutableArray *)SeedAry{
    if (!_SeedAry) {
        _SeedAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _SeedAry;
}

-(NSMutableArray *)SeedAry2{
    if (!_SeedAry2) {
        _SeedAry2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _SeedAry2;
}

-(NSMutableArray *)SeedAry1{
    if (!_SeedAry1) {
        _SeedAry1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _SeedAry1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark          ---------- 数据存储 ----------
- (void) paly:(NSString *)musicType {
    if ([musicType isEqualToString:@"1"]) {
        [_player stop];
        _player = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"农场虫叫" ofType:@"mp3"]] error:nil];
        _player.volume = 0.8;
        _player.delegate = self;
        _player.numberOfLoops = MAXFLOAT;
        NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
        if ([musicStr isEqualToString:@"1"]) {
            [_player play];
        } else {
            
        }
    } else if ([musicType isEqualToString:@"2"]) {
        [_player stop];
        _player = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"雨" ofType:@"mp3"]] error:nil];
        _player.volume = 0.8;
        _player.delegate = self;
        _player.numberOfLoops = MAXFLOAT;
        NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
        if ([musicStr isEqualToString:@"1"]) {
            [_player play];
        } else {
            
        }
    } else if ([musicType isEqualToString:@"3"]) {
        [_player stop];
        _player = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"虫鸣" ofType:@"mp3"]] error:nil];
        _player.volume = 0.8;
        _player.delegate = self;
        _player.numberOfLoops = MAXFLOAT;
        NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
        if ([musicStr isEqualToString:@"1"]) {
            [_player play];
        } else {
            
        }
    } else if ([musicType isEqualToString:@"4"]) {
        [_player stop];
        _player = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"知了声音" ofType:@"mp3"]] error:nil];
        _player.volume = 0.8;
        _player.delegate = self;
        _player.numberOfLoops = MAXFLOAT;
        NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
        if ([musicStr isEqualToString:@"1"]) {
            [_player play];
        } else {
            
        }
    }
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    [_player play];
}


- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startFullScreen" object:nil];
    _Num = @"1";
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"endFullScreen" object:nil];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回@3x"]];
    imageView.frame = WDH_CGRectMake(5, 35, 4, 20);
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = WDH_CGRectMake1(9, 10, 60, 30);
    [btn addTarget: self action:@selector(configBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setTitle:@"商城" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18*kScreenHeight2];
    _Num = @"1";
}
-(void)configBack{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[LYTLifeTableVC class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pop"];
    [_player stop];//停止
}

#pragma mark          ---------- 网络请求 ----------
- (void)requestLJZJ
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSY] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求累积资金信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            _lmoney = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
            [self improve];
            NSLog(@"请求累积资金信息:%@", _lmoney);
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//修改登录密码
- (void)requestDLMM
{
    UITextField * Tf = [self.view viewWithTag:70000];
    UITextField * Tf1 = [self.view viewWithTag:70001];
    UITextField * Tf2 = [self.view viewWithTag:70002];
    if ([Tf1.text isEqualToString:Tf.text]) {
        if (Tf.text.length >= 6) {
            if (Tf.text.length <= 16) {
                NSLog(@"%@", [NSString stringWithFormat:GGLDLMM, Tf2.text, Tf.text]);
                [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLDLMM, Tf2.text, Tf.text] completeWithBlock:^(NSDictionary *responseObject) {
                    NSLog(@"修改登录密码请求信息:%@", responseObject);
                    if ([responseObject[@"code"] intValue] == 0) {
                        [self handleOff10];
                        Alert_Show(@"修改成功")
                    } else if ([responseObject[@"code"] intValue] == 1000) {
                        NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                        Alert_Show(str);
                    } else {
                        NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                        Alert_Show(msg);
                    }
                } WithError:^(NSString *errorStr) {
                    //处理token失效
                    if ([errorStr isEqualToString:@"1"]) {
                        [self LoginRequest];
                    }
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
    
}

//修改支付密码
- (void)requestZFMM:(NSString *)code
{
    if ([code isEqualToString:@"0"]) {
        UITextField * Tf = [self.view viewWithTag:70000];
        UITextField * Tf1 = [self.view viewWithTag:70001];
        UITextField * Tf2 = [self.view viewWithTag:70002];
        if ([Tf.text isEqualToString:Tf1.text]) {
            if (Tf.text.length >= 6) {
                if (Tf.text.length <= 16) {
                    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLZFMM, Tf2.text, Tf.text] completeWithBlock:^(NSDictionary *responseObject) {
                        NSLog(@"修改支付密码请求信息:%@", responseObject);
                        if ([responseObject[@"code"] intValue] == 0) {
                            [self handleOff10];
                            [self requestUserInfo];
                            Alert_Show(@"设置成功")
                        } else if ([responseObject[@"code"] intValue] == 1000) {
                            NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                            Alert_Show(str);
                        } else {
                            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                            Alert_Show(msg);
                        }
                    } WithError:^(NSString *errorStr) {
                        //处理token失效
                        if ([errorStr isEqualToString:@"1"]) {
                            [self LoginRequest];
                        }
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
        UITextField * Tf = [self.view viewWithTag:70000];
        UITextField * Tf1 = [self.view viewWithTag:70001];
        UITextField * Tf2 = [self.view viewWithTag:70002];
        if ([Tf.text isEqualToString:Tf1.text]) {
            if (Tf.text.length >= 6) {
                if (Tf.text.length <= 16) {
                    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLZFMM, Tf2.text, Tf.text] completeWithBlock:^(NSDictionary *responseObject) {
                        NSLog(@"修改支付密码请求信息:%@", responseObject);
                        if ([responseObject[@"code"] intValue] == 0) {
                            [self handleOff10];
                            Alert_Show(@"修改成功")
                        } else if ([responseObject[@"code"] intValue] == 1000) {
                            NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                            Alert_Show(str);
                        } else {
                            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                            Alert_Show(msg);
                        }
                    } WithError:^(NSString *errorStr) {
                        //处理token失效
                        if ([errorStr isEqualToString:@"1"]) {
                            [self LoginRequest];
                        }
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

    }
}

//请求用户信息
- (void)requestUserInfo
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLUserInfo] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求用户信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            self.InfoDic = responseObject[@"data"];
            [[self.view viewWithTag:160] removeFromSuperview];
            [_scaleLayer3 removeFromSuperview];
            UIImageView * imageView11 = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(465, 266, 60, 50)];
            imageView11.tag = 160;
            
            if ([_InfoDic[@"doglevel"] intValue] == 0) {
                imageView11.image = [UIImage imageNamed:@""];
            } else if ([_InfoDic[@"doglevel"] intValue] == 1) {
                imageView11.image = [UIImage imageNamed:@"杜宾犬"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 2) {
                imageView11.image = [UIImage imageNamed:@"哈士奇"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 3) {
                imageView11.image = [UIImage imageNamed:@"金毛寻回犬"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 4) {
                imageView11.image = [UIImage imageNamed:@"边境牧羊犬"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 5) {
                imageView11.image = [UIImage imageNamed:@"藏獒"];
            }
            [self.view addSubview:imageView11];
            
            
            self.scaleLayer3 = [[UIImageView alloc] init];
            _scaleLayer3.frame = WDH_CGRectMake1(405, 266, 60, 20);
            _scaleLayer3.layer.cornerRadius = 5;
            if ([_InfoDic[@"doglevel"] intValue] == 0) {
                _scaleLayer3.image = [UIImage imageNamed:@""];
            } else if ([_InfoDic[@"doglevel"] intValue] == 1) {
                _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.1"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 2) {
                _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.2"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 3) {
                _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.3"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 4) {
                _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.4"];
            } else if ([_InfoDic[@"doglevel"] intValue] == 5) {
                _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.5"];
            }
            
            [self.view addSubview:_scaleLayer3];
            
            CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
            positionAnima.fromValue = @(_scaleLayer3.center.y);
            positionAnima.toValue = @(_scaleLayer3.center.y + 15);
            positionAnima.Autoreverses = YES;
            positionAnima.duration = 2.0f;
            positionAnima.repeatCount = MAXFLOAT;
            positionAnima.fillMode = kCAFillModeForwards;
            positionAnima.removedOnCompletion = NO;
            positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            
            [_scaleLayer3.layer addAnimation:positionAnima forKey:@"Animation"];


            
            [self requestSeedsInfo];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//请求种子信息
- (void)requestSeedsInfo
{
    [self.SeedAry removeAllObjects];
    [self.SeedAry1 removeAllObjects];
    [self.SeedAry2 removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSeedsInfo] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求种子信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSArray * ary = responseObject[@"data"];
            for (NSDictionary * dic in ary) {
                if ([dic[@"gainType"] intValue] == 0) {
                    [self.SeedAry addObject:dic];
                } else if ([dic[@"gainType"] intValue] == 1){
                    [self.SeedAry1 addObject:dic];
                }else if ([dic[@"gainType"] intValue] == 2){
                    [self.SeedAry2 addObject:dic];
                }
            }
            NSLog(@"种子一号%@, 种子二号%@", _SeedAry, _SeedAry1);
            [[self.view viewWithTag:987654] removeFromSuperview];
            [self configTopView];
            [self configScrollView];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//查看是否弹窗
- (void)requestpopOver
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:popOver] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求弹窗信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            
            CGRect rect = [[NSString stringWithFormat:@"%@", responseObject[@"data"][@"content"]] boundingRectWithSize:CGSizeMake(460, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            [self meGo:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"content"]] height:rect.size.height];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

- (void)meGo:(NSString *)content
      height:(CGFloat)height {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"pop"];
    UIView * backView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(167 / 2, 40, 500, 300)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.tag = 502;
    [self.view addSubview:backView];
    
//    UIScrollView * backView1 = [[UIScrollView alloc] initWithFrame:WDH_CGRectMake1(0, 40, 400, 160)];
//    backView1.backgroundColor = [UIColor whiteColor];
//    backView1.contentSize = CGSizeMake(0, height + 30);
//    [backView addSubview:backView1];
    
    //添加一条灰线
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(0, 39, 500, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];
    [backView addSubview:lineLabel];
    
    UILabel * title = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(100, 0, 300, 39)];
    title.text = @"系统公告";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    [backView addSubview:title];
    
    UIWebView * web = [[UIWebView alloc] initWithFrame:WDH_CGRectMake1(20, 40, 460, 220)];
    web.dataDetectorTypes = UIDataDetectorTypeAll;
    [web loadHTMLString:content baseURL:nil];
    [backView addSubview:web];
    
//    UILabel * contentLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(20, 20, 360, height)];
//    contentLabel.text = content;
//    contentLabel.userInteractionEnabled = YES;
//    contentLabel.font = [UIFont systemFontOfSize:14*kScreenHeight2];
//    contentLabel.numberOfLines = 0;
//    contentLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
//    [backView1 addSubview:contentLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(435, 10, 50, 20);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(pickerViewAction999) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(0, 260, 500, 1)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];
    [backView addSubview:lineLabel1];
    
    UIButton *closeBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn1.frame = WDH_CGRectMake1(0, 261, 500, 40);
    [closeBtn1 setTitle:@"点击下载空中课堂" forState:UIControlStateNormal];
    [closeBtn1 setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [closeBtn1 addTarget:self action:@selector(pick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn1];
}

- (void) pickerViewAction999 {
    [[self.view viewWithTag:502] removeFromSuperview];
    [_PickVC removeFromSuperview];
}

- (void) pick {
    NSURL *url= [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id427941017?mt=8"];
    [[UIApplication sharedApplication] openURL:url];
}

//请求土地信息
- (void)requestCXTDLB
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLCXTDLB] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求土地信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            self.TDAry = responseObject[@"data"];
            [_mainScroll removeFromSuperview];
            [[self.view viewWithTag:99] removeFromSuperview];
            [[self.view viewWithTag:9] removeFromSuperview];
            [[self.view viewWithTag:987655] removeFromSuperview];
            [[self.view viewWithTag:987656] removeFromSuperview];
            [[self.view viewWithTag:987657] removeFromSuperview];
            [[self.view viewWithTag:987658] removeFromSuperview];
            [[self.view viewWithTag:987659] removeFromSuperview];
            [[self.view viewWithTag:987660] removeFromSuperview];
            [[self.view viewWithTag:9987659] removeFromSuperview];
            [[self.view viewWithTag:9987660] removeFromSuperview];
            [[self.view viewWithTag:147] removeFromSuperview];
            [[self.view viewWithTag:148] removeFromSuperview];
            [[self.view viewWithTag:149] removeFromSuperview];
            [[self.view viewWithTag:150] removeFromSuperview];
            [[self.view viewWithTag:1501] removeFromSuperview];
            [[self.view viewWithTag:151] removeFromSuperview];
            [[self.view viewWithTag:152] removeFromSuperview];
            [[self.view viewWithTag:160] removeFromSuperview];
            [[self.view viewWithTag:161] removeFromSuperview];
            [_ActiveLabel removeFromSuperview];
            [_scaleLayer removeFromSuperlayer];
            [_scaleLayer1 removeFromSuperlayer];
            [_scaleLayer2 removeFromSuperlayer];
            [self configFunctionBtn];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//挂单
- (void)requestGD
{
    UIButton * Btn = [self.view viewWithTag:7299];
    Btn.userInteractionEnabled = NO;
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLGD] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"挂单:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Alert_Show(@"挂单成功")
            Btn.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else {
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//种子商城
- (void)requestZZSC
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLZZSC] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"种子商城:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            //种子商城
            self.SeedDic = responseObject[@"data"];
            [self handleOne];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//购买土地生成订单
- (void)requestGMTD
{
    UILabel * label = [self.view viewWithTag:10010];
    if ([label.text intValue] == 0) {
        Alert_Show(@"购买土地数不能为0")
    } else {
        [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLTDSCDD, label.text] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"购买土地订单:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                [self handleOff2];
                if ([_InfoDic[@"amount"] floatValue] >= [label.text floatValue] * 100) {
                    if ([_InfoDic[@"ampassIs"] intValue] == 0) {
                        Alert_Show(@"您还未设置支付密码");
                    } else {
                        DCPaymentView *payAlert = [[DCPaymentView alloc]init];
                        payAlert.title = @"请输入支付密码";
                        payAlert.detail = [NSString stringWithFormat:@"需支付%@积分", responseObject[@"data"][@"orderAmount"]];;
                        payAlert.pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
                        [payAlert show];
                        payAlert.completeHandle = ^(NSString *inputPwd) {
                            [self requestPay:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]] tradeNo:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderNo"]] password:inputPwd type:@"1" Three:@"0"];
                        };
                        payAlert.dismissView = ^(int dissmiss){
                            NSLog(@"%d-----dissmiss",dissmiss);
                        };
                    }
                    
                } else {
                    _Type = @"1";
                    NSLog(@"*----%@", [NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]]);
                    _order = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]];
                    _amount = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderAmount"]];
                    _orderType = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderType"]];
                    [self YuEBuZuView:[NSString stringWithFormat:@"%.2f", [_amount floatValue] - [_InfoDic[@"amount"] floatValue]]];
                }
            } else {
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    }
}

//购买种子生成订单
- (void)requestGMZZ:(NSString *)type
             Market:(NSString *)market
{
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLZZOrder, type] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"购买种子订单:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self handleOff1];
            
            if ([_InfoDic[@"amount"] floatValue] >= [responseObject[@"data"][@"orderAmount"] floatValue]) {
                if ([_InfoDic[@"ampassIs"] intValue] == 0) {
                    Alert_Show(@"您还未设置支付密码");
                } else {
                    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
                    payAlert.title = @"请输入支付密码";
                    payAlert.detail = [NSString stringWithFormat:@"需支付%@积分", responseObject[@"data"][@"orderAmount"]];;
                    payAlert.pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
                    [payAlert show];
                    payAlert.completeHandle = ^(NSString *inputPwd) {
                        [self requestPay:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]] tradeNo:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderNo"]] password:inputPwd type:@"2" Three:@"0"];
                    };
                    payAlert.dismissView = ^(int dissmiss){
                        NSLog(@"%d-----dissmiss",dissmiss);
                    };
                }
                

            } else {
                _Type = @"2";
                _order = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]];
                _amount = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderAmount"]];
                _orderType = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderType"]];
                [self YuEBuZuView:[NSString stringWithFormat:@"%.2f", [_amount floatValue] - [_InfoDic[@"amount"] floatValue]]];
            }
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//购买化肥生成订单
- (void)handleMaiHF
{
    NSString * landId = [NSString stringWithFormat:@"%@", _TDAry[[_NumLabel.text intValue] - 1][@"id"]];
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLBuyHF, landId] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"购买化肥订单:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self handleOff65];
            if ([_InfoDic[@"amount"] floatValue] >= [responseObject[@"data"][@"orderAmount"] floatValue]) {
                if ([_InfoDic[@"ampassIs"] intValue] == 0) {
                    Alert_Show(@"您还未设置支付密码");
                } else {
                    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
                    payAlert.title = @"请输入支付密码";
                    payAlert.detail = [NSString stringWithFormat:@"需支付%@积分", responseObject[@"data"][@"orderAmount"]];
                    payAlert.pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
                    [payAlert show];
                    payAlert.completeHandle = ^(NSString *inputPwd) {
                        [self requestPay:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]] tradeNo:[NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderNo"]] password:inputPwd type:@"3" Three:@"0"];
                    };
                    payAlert.dismissView = ^(int dissmiss){
                        NSLog(@"%d-----dissmiss",dissmiss);
                    };
                }
            } else {
                _Type = @"3";
                _order = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"id"]];
                _amount = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderAmount"]];
                _orderType = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"orderType"]];
                [self YuEBuZuView:[NSString stringWithFormat:@"%.2f", [_amount floatValue] - [_InfoDic[@"amount"] floatValue]]];
            }
        } else if ([responseObject[@"code"] intValue] == 875) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"表现很好奖励施肥!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self requestCXTDLB];
                [self requestUserInfo];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

- (void) YuEBuZuView:(NSString *)amount {
    
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction222)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 110)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 12002;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"积分不足";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    
    UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 35, 213, 40)];
    Label.text = [NSString stringWithFormat:@"积分不足, 请选择其他支付方式, 支付%@积分", amount];
    Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 /255.0 blue:70 / 255.0 alpha:1];
    Label.textAlignment = 1;
    Label.numberOfLines = 0;
    Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
    [view addSubview:Label];
    
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1(30, 80, 50, 25);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    [buyBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleZFB) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * buyBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn1.frame = WDH_CGRectMake1(153, 80, 50, 25);
    buyBtn1.layer.cornerRadius = 5;
    buyBtn1.layer.masksToBounds = YES;
    buyBtn1.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    [buyBtn1 setTitle:@"微信" forState:UIControlStateNormal];
    [buyBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn1 addTarget:self action:@selector(handleWX) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn1];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff222) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void)pickerViewAction222 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:12002] removeFromSuperview];
}

- (void)handleOff222 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:12002] removeFromSuperview];
}

- (void)handleZFB {
    [self requestZhiFuBaoOrder:_order amount:_amount orderType:_orderType Type:_Type];
    [self pickerViewAction222];
}

- (void)handleWX {
    [self pickerViewAction222];
    Alert_Show(@"敬请期待...")
}

#pragma mark ------------ 请求 >>> 支付宝支付 ------------
-(void)requestZhiFuBaoOrder:(NSString *)orderId
                     amount:(NSString *)amount
                 orderType:(NSString *)orderType
                      Type:(NSString *)Type
{
    [WDHRequest requestZFBOrderWith:[NSString stringWithFormat:@"%@/recharge/pay_info?price=%.2f&orderId=%@&orderType=%@&payType=1",GGL,[amount doubleValue] - [_InfoDic[@"amount"] doubleValue] ,orderId, orderType] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"----%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSString * orderID = responseObject[@"data"][@"pay_info"];
            _pay_trade_no = responseObject[@"data"][@"pay_trade_no"];
            [self alipayActionWithOrderId:orderID trade_no:orderId type:Type];
        }else{
            Alert_Show(@"服务器忙,请稍后再试")
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

#pragma mark ------------ 支付宝回调 ------------
- (void)alipayActionWithOrderId:(NSString *)orderID
                       trade_no:(NSString *)trade_no
                           type:(NSString *)type
{
    _type = type;
    NSString *appScheme = @"GGL";
    NSString *signedString = orderID;
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@",signedString];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *str =resultDic[@"resultStatus"];
            NSLog(@"qw-----qw-----%@",resultDic);
            if ([str intValue] == 9000){
                
            } else {
                Alert_Show(@"支付失败")
            }
        }];
    }
}


//支付接口
- (void) requestPay:(NSString *)orderId
            tradeNo:(NSString *)tradeNo
           password:(NSString *)password
               type:(NSString *)type
              Three:(NSString *)Three
{
    if ([Three isEqualToString:@"0"]) {
        [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLZZZF, orderId, password, tradeNo] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"支付:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                if ([type isEqualToString:@"1"]) {
                    Alert_Show(@"土地购买成功")
                } else if ([type isEqualToString:@"2"]) {
                    Alert_Show(@"种子购买成功")
                } else if ([type isEqualToString:@"3"]) {
                    Alert_Show(@"化肥购买成功")
                }
                [self requestCXTDLB];
                [self requestUserInfo];
            } else if ([responseObject[@"code"] intValue] == 873) {
                if ([type isEqualToString:@"2"]) {
                    Alert_Show(@"稍后果果会将种子直接送达您的仓库，请耐心等待下哦！")
                }
                [self requestCXTDLB];
                [self requestUserInfo];
            } else {
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else {
        NSLog(@"空-----%@", orderId);
        
        [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLZZZF, orderId, @"", _pay_trade_no] completeWithBlock:^(NSDictionary *responseObject) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AlipaySDKSuccsess" object:nil];
            NSLog(@"支付:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                if ([type isEqualToString:@"1"]) {
                    Alert_Show(@"土地购买成功")
                } else if ([type isEqualToString:@"2"]) {
                    Alert_Show(@"种子购买成功")
                } else if ([type isEqualToString:@"3"]) {
                    Alert_Show(@"化肥购买成功")
                }
                [self requestCXTDLB];
                [self requestUserInfo];
            } else {
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];

    }
        
}

//采摘接口
- (void) requestCaiZhai
{
    UIButton * Btn = [self.view viewWithTag:987659];
    UIButton * Btn1 = [self.view viewWithTag:9987659];
    Btn.userInteractionEnabled = NO;
    Btn1.userInteractionEnabled = NO;
    
    int index = [_NumLabel.text intValue] - 1;
    NSDictionary * dic = _TDAry[index];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLCZ, dic[@"id"]] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"采摘结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Alert_Show(@"采摘成功")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 849) {
            Alert_Show(@"主人，你没有领狗被偷的一塌糊涂，快速分享两个农户去领狗吧！")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 850) {
            Alert_Show(@"主人，此狗看守能力有限，分享更多好友升级领养一条好狗吧！")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 851) {
            Alert_Show(@"主人，藏獒果真名不虚传，帮你击退了大部分来犯之贼，再接再厉，别让好狗流浪了！")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 866) {
            Alert_Show(@"嗨，菜鸟，果果帮你看住了大部分种子，快感谢我吧")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 871) {
            NSLog(@"-数据----%@", responseObject);
            _i = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else {
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        Btn1.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

- (void) configImage:(NSString *)code {
    _i = @"0";
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor clearColor];
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction1588)];
    [_PickVC addGestureRecognizer:tap];

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(0, 70, 600, 280)];
    if ([code intValue] == 1) {
        imageView.image = [UIImage imageNamed:@"150"];
    } else if ([code intValue] == 2) {
        imageView.image = [UIImage imageNamed:@"450"];
    } else if ([code intValue] == 3) {
        imageView.image = [UIImage imageNamed:@"900"];
    }
    
    imageView.tag = 49;
    [self.view addSubview:imageView];
}

- (void)pickerViewAction1588 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:49] removeFromSuperview];
}

//施肥
- (void) requestShiFei {
    UIButton * Btn = [self.view viewWithTag:987660];
    UIButton * Btn1 = [self.view viewWithTag:9987660];
    Btn.userInteractionEnabled = NO;
    Btn1.userInteractionEnabled = NO;
    
    int index = [_NumLabel.text intValue] - 1;
    NSDictionary * dic = _TDAry[index];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSF, dic[@"id"]] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"施肥结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Alert_Show(@"施肥成功")
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self requestCXTDLB];
            [self requestUserInfo];
        } else if ([responseObject[@"code"] intValue] == 860) {
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            [self handleMaiHuaFei:[NSString stringWithFormat:@"%@",  responseObject[@"message"]]];
        } else {
            Btn.userInteractionEnabled = YES;
            Btn1.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        Btn1.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//账单接口
- (void) requestzhangdan
{
    [self.ZDdataAry removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLZD, @"0"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"账单结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            //账单
            NSArray * ary = responseObject[@"data"];
            for (NSDictionary * dic in ary) {
                [self.ZDdataAry addObject:dic];
            }
            [self handleThree];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

- (void) requestzhangZuo
{
    UIButton * Btn = [self.view viewWithTag:12457841];
    [self.ZDdataAry removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLZD, @"0"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"账单结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Btn.userInteractionEnabled = YES;
            //账单
            NSArray * ary = responseObject[@"data"];
            for (NSDictionary * dic in ary) {
                [self.ZDdataAry addObject:dic];
            }
            UITableView * table = [self.view viewWithTag:55555];
            [table reloadData];
        } else {
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];

}

- (void) requestzhangYou
{
     UIButton * Btn = [self.view viewWithTag:12457840];
    [self.ZDdataAry removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLZDY, @"0"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"账单结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Btn.userInteractionEnabled = YES;
            //账单
            NSArray * ary = responseObject[@"data"];
            for (NSDictionary * dic in ary) {
                [self.ZDdataAry addObject:dic];
            }
            UITableView * table = [self.view viewWithTag:55555];
            [table reloadData];
        } else {
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//收米接口
- (void) requestshoumi
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSZ, @"0"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"收米结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            //收米
            _SMdataAry = responseObject[@"data"];
            [self handleFive];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}



//挂单记录
- (void)requestGDList
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLGDJL, @"1"] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"挂单列表:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            _GDdataAry = responseObject[@"data"];
            //挂单记录
            [self handleGuaDanList];
            
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//粉丝列表
- (void)requestFenSiList
{
    [WDHRequest requestAllListWith:[NSString stringWithFormat:FenSi] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"粉丝列表:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            
            _FenSiAry = responseObject[@"data"];
            //粉丝列表
            [self handleFenSiList];
            
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//消息列表
- (void)requestMessageList
{
    [self.messegeDataAry removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:messageUrl,0] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"消息列表:%@", responseObject);

        if ([responseObject[@"code"] intValue] == 0) {
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                SYMessage *model = [SYMessage messageWithDic:dic];
                [self.messegeDataAry addObject:model];
            }
            UITableView *table = [self.view viewWithTag:123555];
            [table reloadData];
            
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

#pragma mark          ---------- 配置列表 ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 123555) {
        NSLog(@"有几行---%ld",self.messegeDataAry.count);
        return self.messegeDataAry.count;
    } else {
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 123555) {
        NSLog(@"有几行---%ld",self.messegeDataAry.count);
        return 5;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 77777) {
        return _GDdataAry.count;
    } else if (tableView.tag == 55555) {
        NSLog(@"asd--分润----%ld",_ZDdataAry.count);
        return _ZDdataAry.count;
    } else if (tableView.tag == 44444) {
        return _FenSiAry.count;
    } else if (tableView.tag == 123555) {
        NSLog(@"有几行---%ld",self.messegeDataAry.count);
        return 1;
    } else {
        return _SMdataAry.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 123555) {
//        SYMessage *model = self.messegeDataAry[indexPath.row];
//        CGRect rect = [model.messageContent boundingRectWithSize:CGSizeMake(627, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return 60 * kScreenHeight2;
    } else if (tableView.tag == 44444) {
        return 50 * kScreenHeight2;
    }
    return 30 * kScreenHeight2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 77777) {
        GDCell * zjwCell = [tableView dequeueReusableCellWithIdentifier:@"GD" forIndexPath:indexPath];
        NSDictionary * dic = _GDdataAry[indexPath.row];
        zjwCell.LeftLabel.text = [NSString stringWithFormat:@"未售"];
        zjwCell.priceLabel.text = [NSString stringWithFormat:@"%.2f积分", [dic[@"amount"] floatValue]];
        NSString * str = [NSString stringWithFormat:@"%@", dic[@"createDate"]];
        NSArray *array = [str componentsSeparatedByString:@" "];
        zjwCell.rightLabel.text = [array firstObject];
        zjwCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zjwCell;
    } else if (tableView.tag == 44444) {
        FSCell * zjwCell = [tableView dequeueReusableCellWithIdentifier:@"FS" forIndexPath:indexPath];
        NSDictionary * dic = _FenSiAry[indexPath.row];
        int level = [dic[@"fenhongLevel"] intValue] > [dic[@"fenhongLevelj"] intValue] ? [dic[@"fenhongLevel"] intValue] : [dic[@"fenhongLevelj"] intValue];
        int level1 = [dic[@"landLevel"] intValue];
        
        switch (level1) {
            case 0:
                zjwCell.rightLabel.text = @"贫农";
                break;
            case 1:
                zjwCell.rightLabel.text = @"中农";
                break;
            case 2:
                zjwCell.rightLabel.text = @"富农";
                break;
            case 3:
                zjwCell.rightLabel.text = @"地主";
                break;
            default:
                break;
        }
        
        switch (level) {
            case 0:
                zjwCell.LeftImage.image = [UIImage imageNamed:@"青铜"];
                break;
                
            case 1:
                zjwCell.LeftImage.image = [UIImage imageNamed:@"白金"];
                break;
                
            case 2:
                zjwCell.LeftImage.image = [UIImage imageNamed:@"黄金"];
                break;
                
            case 3:
                zjwCell.LeftImage.image = [UIImage imageNamed:@"钻石"];
                break;
            default:
                break;
        }
        
        zjwCell.LeftLabel.text = [NSString stringWithFormat:@"%@", dic[@"nikName"]];
        zjwCell.priceLabel.text = [NSString stringWithFormat:@"%@", dic[@"mobile"]];
        zjwCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zjwCell;
    } else if (tableView.tag == 55555) {
        ZDCell * zjwCell = [tableView dequeueReusableCellWithIdentifier:@"ZD" forIndexPath:indexPath];
        NSDictionary * dic = _ZDdataAry[indexPath.row];
        if ([dic[@"type"] intValue] == 0) {
            zjwCell.LeftLabel.text = @"购买地";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 1) {
            zjwCell.LeftLabel.text = @"购买种子";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 2) {
            zjwCell.LeftLabel.text = @"购买化肥";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 3) {
            zjwCell.LeftLabel.text = @"卖收获的种子";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 4) {
            zjwCell.LeftLabel.text = @"等级分润";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 5) {
            zjwCell.LeftLabel.text = @"提现";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 6) {
            zjwCell.LeftLabel.text = @"购买化肥";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 7) {
            zjwCell.LeftLabel.text = @"转出";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 8) {
            zjwCell.LeftLabel.text = @"转入";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 9) {
            zjwCell.LeftLabel.text = @"提现驳回";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 10) {
            zjwCell.LeftLabel.text = @"卖偷取的种子";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 11) {
            zjwCell.LeftLabel.text = @"种子账户转账";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"-%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 12) {
            zjwCell.LeftLabel.text = @"收到种子积分";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 13) {
            zjwCell.LeftLabel.text = @"土地活动奖";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else {
            zjwCell.LeftLabel.text = @"特殊";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"%.2f积分", [dic[@"billAmount"] floatValue]];;
        }
        zjwCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zjwCell;

    } else if (tableView.tag == 123555){
        UITableViewCell *messageCell = [tableView cellForRowAtIndexPath:indexPath];
        messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (messageCell == nil) {
            messageCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                          reuseIdentifier: @"mes"];
        }
         SYMessage * model = self.messegeDataAry[indexPath.section];
        if (indexPath.section == 0) {
            messageCell.imageView.image = [UIImage imageNamed:@"messge_notice"];
            messageCell.textLabel.text = @"新公告消息";
            messageCell.textLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
            NSString * creat = @"新";
            NSString * showLabel = [NSString stringWithFormat:@"%@%@", @"新", @"公告消息"];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showLabel];
            
            NSRange range = [showLabel rangeOfString:creat];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor redColor]
             
                                  range:NSMakeRange(range.location, range.length)];
            
            messageCell.textLabel.attributedText = AttributedStr;
            
            NSLog(@"-12323123---%@----%@", model.messageTime, model.messageContent);
            messageCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", model.messageTime];
        } else {
            messageCell.imageView.image = [UIImage imageNamed:@""];
            messageCell.textLabel.text = @"公告消息";
            messageCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", model.messageTime];
        }
        return messageCell;
    } else {
        SZCell * zjwCell = [tableView dequeueReusableCellWithIdentifier:@"SZ" forIndexPath:indexPath];
        NSDictionary * dic = _SMdataAry[indexPath.row];
        if ([dic[@"type"] intValue] == 3) {
            zjwCell.LeftLabel.text = @"卖种子";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 4) {
            zjwCell.LeftLabel.text = @"分润";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else if ([dic[@"type"] intValue] == 13) {
            zjwCell.LeftLabel.text = @"土地活动奖";
            zjwCell.priceLabel.text = [NSString stringWithFormat:@"+%.2f积分", [dic[@"billAmount"] floatValue]];
        } else {
            zjwCell.LeftLabel.text = @"";
            zjwCell.priceLabel.text = @"";
        }
        zjwCell.Btn.tag = [dic[@"id"] intValue];
        [zjwCell.Btn addTarget:self action:@selector(handleChaShou:) forControlEvents:UIControlEventTouchUpInside];
        zjwCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zjwCell;

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 123555) {
        SYMessage * model = self.messegeDataAry[indexPath.section];
        CGRect rect = [model.messageContent boundingRectWithSize:CGSizeMake(627, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        [self messageGo:model.messageContent height:rect.size.height];
    }
}

- (void)messageGo:(NSString *)content
           height:(CGFloat)height {
    
    UIView * backView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.tag = 502;
    [self.view addSubview:backView];
//    
//    UIScrollView * backView1 = [[UIScrollView alloc] initWithFrame:WDH_CGRectMake1(0, 50, 667, 325)];
//    backView1.backgroundColor = [UIColor whiteColor];
//    backView1.contentSize = CGSizeMake(0, height + 30);
//    [backView addSubview:backView1];
    
    //添加一条灰线
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(0, 49, 667, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];
    [backView addSubview:lineLabel];
    
    UILabel * title = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(150, 0, 367, 49)];
    title.text = @"消息详情";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    [backView addSubview:title];
    
    
    UIWebView * web = [[UIWebView alloc] initWithFrame:WDH_CGRectMake1(20, 60, 627, 305)];
    web.dataDetectorTypes = UIDataDetectorTypeAll;
    [web loadHTMLString:content baseURL:nil];
    [backView addSubview:web];
    
//    UILabel * contentLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(20, 20, 627, height)];
//    contentLabel.text = content;
//    contentLabel.font = [UIFont systemFontOfSize:14*kScreenHeight2];
//    contentLabel.numberOfLines = 0;
//    contentLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
//    [backView1 addSubview:contentLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(600, 15, 50, 20);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(pickClose) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
}

- (void) pickClose {
    [[self.view viewWithTag:502] removeFromSuperview];
}


- (void) handleChaShou:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLCSZ, [NSString stringWithFormat:@"%ld", sender.tag]] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"收米结果:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self handleOff5];
            [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLUserInfo] completeWithBlock:^(NSDictionary *responseObject) {
                NSLog(@"请求用户信息:%@", responseObject);
                if ([responseObject[@"code"] intValue] == 0) {
                    sender.userInteractionEnabled = YES;
                    self.InfoDic = responseObject[@"data"];
//                    _moneyLabel.text = [NSString stringWithFormat:@"%.2f", [_InfoDic[@"amount"] floatValue]];
                } else {
                    sender.userInteractionEnabled = YES;
                    NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                    Alert_Show(msg);
                }
            } WithError:^(NSString *errorStr) {
                sender.userInteractionEnabled = YES;
                //处理token失效
                if ([errorStr isEqualToString:@"1"]) {
                    [self LoginRequest];
                }
            }];
            [self requestshoumi];
            //收账成功
        } else {
            sender.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        sender.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

#pragma mark          ---------- 配置视图 ----------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self paly:@"1"];
    [self requestUserInfo];
    [self requestCXTDLB];
    self.view.backgroundColor = [UIColor whiteColor];
    _seed = @"0";
    _seedNum = @"0";
    _TouQu = 0;
    _i = @"0";
    _ZzCode = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotification) name:@"AlipaySDKSuccsess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterActive) name:@"enterActive" object:nil];


}

-(void)enterActive{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startFullScreen" object:nil];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
-(void) NSNotification {
    [self requestPay:_order tradeNo:_pay_trade_no password:@"" type:_type Three:@"1"];
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

//顶部信息栏
- (void) configTopView
{
    UIView * TopView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 50)];
    TopView.backgroundColor = [UIColor whiteColor];
    TopView.tag = 987654;
    [self.view addSubview:TopView];
    [self.view sendSubviewToBack:TopView];
    
    self.HeadImageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(10, 5, 40, 40)];
    _HeadImageView.layer.cornerRadius = 20;
    _HeadImageView.layer.masksToBounds = YES;
//    _HeadImageView.image = [UIImage imageNamed:@"头像"];
    _HeadImageView.backgroundColor = [UIColor whiteColor];
    [TopView addSubview:_HeadImageView];

    self.nickName = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(50, 5, 100, 20)];
    _nickName.text = [NSString stringWithFormat:@"%@", _InfoDic[@"nikName"]];
    _nickName.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    _nickName.textAlignment = 1;
    _nickName.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [TopView addSubview:_nickName];
    
    self.grade = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(60, 25, 80, 20)];
    _grade.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    _grade.textAlignment = 1;
    _grade.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [TopView addSubview:_grade];
    
    self.peerages = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(140, 25, 50, 20)];
    
    _peerages.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    _peerages.textAlignment = 1;
    _peerages.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [TopView addSubview:_peerages];
    
    self.peerageImage = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(155, 5, 20, 20)];
    
    [TopView addSubview:_peerageImage];
    
    int level = [_InfoDic[@"fenhongLevel"] intValue] > [_InfoDic[@"fenhongLevelj"] intValue] ? [_InfoDic[@"fenhongLevel"] intValue] : [_InfoDic[@"fenhongLevelj"] intValue];
    int level1 = [_InfoDic[@"landLevel"] intValue];
   
    switch (level1) {
        case 0:
             _grade.text = @"贫农";
            break;
        case 1:
             _grade.text = @"中农";
            break;
        case 2:
             _grade.text = @"富农";
            break;
        case 3:
             _grade.text = @"地主";
            break;
        default:
            break;
    }

    
    switch (level) {
        case 0:
            _peerages.text = @"无身份";
            _peerageImage.image = [UIImage imageNamed:@"1"];
            break;
            
        case 1:
            _peerages.text = @"户农";
            _peerageImage.image = [UIImage imageNamed:@"2"];
            break;
            
        case 2:
            _peerages.text = @"仓农";
            _peerageImage.image = [UIImage imageNamed:@"3"];
            break;
            
        case 3:
            _peerages.text = @"司农";
            _peerageImage.image = [UIImage imageNamed:@"4"];
            break;
        default:
            break;
    }
    
    
    NSArray * ary = @[@"user_money", @"桂圆", @"枇杷", @"椰子"];
    for (int i = 0; i < 4; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(200 + i * 90, 15, 20, 20)];
        imageView.image = [UIImage imageNamed:ary[i]];
        [TopView addSubview:imageView];
        
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = CGRectMake(200 + i * 90, 0, 90, 50);
        Btn.tag = 4000 + i;
        Btn.backgroundColor = [UIColor clearColor];
        [Btn addTarget:self action:@selector(handleZJ:) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:Btn];
    }
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(225, 0, 60, 50)];
    _moneyLabel.text = @"查看积分";
    _moneyLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    _moneyLabel.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    [TopView addSubview:_moneyLabel];
    
    
    
    self.longyanLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(315, 0, 60, 50)];
    
    _longyanLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    _longyanLabel.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    
    
    self.pipaLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(405, 0, 60, 50)];
    
    _pipaLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    _pipaLabel.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    
    
    self.yeziLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(495, 0, 60, 50)];
   
    _yeziLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    _yeziLabel.textColor = [UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1];
    
    
    for (NSDictionary * dic in _SeedAry) {
        if ([dic[@"semenTypeId"] intValue] == 1) {
            _longyanLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"number"] floatValue]];
        } else if ([dic[@"semenTypeId"] intValue] == 2) {
            _pipaLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"number"] floatValue]];
        } else {
             _yeziLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"number"] floatValue]];
        }
    }
    [TopView addSubview:_longyanLabel];
    [TopView addSubview:_pipaLabel];
    [TopView addSubview:_yeziLabel];
//    for (NSDictionary * dic in _SeedAry) {
//        if ([dic[@"semenTypeId"] intValue] == 1) {
//            _pipaLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"semenAmuont"] floatValue]];
//        } else if ([dic[@"semenTypeId"] intValue] == 2) {
//            _longyanLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"semenAmuont"] floatValue]];
//        } else if ([dic[@"semenTypeId"] intValue] == 3) {
//            _yeziLabel.text = [NSString stringWithFormat:@"%.2f", [dic[@"semenAmuont"] floatValue]];
//        }
//    }
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(550, 15, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"出售"];
    [TopView addSubview:leftImageView];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(610, 15, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"查看"];
    [TopView addSubview:rightImageView];
    
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(575, 15, 35, 20)];

    leftLabel.text = @"出售";
    leftLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    leftLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    [TopView addSubview:leftLabel];
    
    UILabel * rightLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(635, 15, 30, 20)];

    rightLabel.text = @"查看";
    rightLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    rightLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    [TopView addSubview:rightLabel];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(570, 5, 35, 40);
    Btn.tag = 7299;
    [Btn addTarget:self action:@selector(handleGuaDan) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:Btn];
    
    UIButton * Btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn1.frame = WDH_CGRectMake1(610, 5, 50, 40);
    [Btn1 addTarget:self action:@selector(handleList) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:Btn1];
}

- (void) handleZJ :(UIButton *) sender {
    if (sender.tag == 4000) {
        [self requestLJZJ];
    } else {
        [self requestCXTDLB];
        [self requestUserInfo];
    }
}

- (void) improve {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOff152)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 100, 233, 175)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 100019;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"账户明细";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSArray * ary = @[@"转账留存:", @"种子账户:", @"可提现账户:", @"活跃度:"];
    for (int i = 0; i < 4; i++) {
        UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(15, 35 + 35 * i, 90, 30)];
        textLabel1.text = ary[i];
        textLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel1.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        [view addSubview:textLabel1];
        
        
        UILabel * textLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(110, 35 + 35 * i, 120, 30)];
        if (i == 0) {
            textLabel2.text = [NSString stringWithFormat:@"%.2f积分", [_InfoDic[@"transfer"] floatValue]];
        } else if (i == 1) {
            textLabel2.text = [NSString stringWithFormat:@"%.2f积分", [_InfoDic[@"semenAmount"] floatValue]];
        } else if (i == 2) {
            float a = 0;
            if ([_InfoDic[@"amount"] floatValue] - [_InfoDic[@"transfer"] floatValue] - [_InfoDic[@"semenAmount"] floatValue] < 0) {
                a = 0;
            } else {
                a = [_InfoDic[@"amount"] floatValue] - [_InfoDic[@"transfer"] floatValue] - [_InfoDic[@"semenAmount"] floatValue];
            }
            
            textLabel2.text = [NSString stringWithFormat:@"%.2f积分", a];
        } else if (i == 3) {
            if ([_InfoDic[@"vitality"] intValue] == 1) {
                textLabel2.text = @"低";
            } else {
                textLabel2.text = @"高";
            }
        }
        
        textLabel2.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel2.textAlignment = 1;
        textLabel2.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        [view addSubview:textLabel2];
    }
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff152) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void)handleOff152 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:100019] removeFromSuperview];
}


//土地内容
- (void) configScrollView
{
    self.mainScroll = [[UIScrollView alloc] initWithFrame:WDH_CGRectMake1(0, 50, 667, 275)];
    _mainScroll.backgroundColor = [UIColor cyanColor];
    if (_TDAry.count == 0) {
        _mainScroll.contentSize = CGSizeMake((667*kScreenWidth2), 0);
    } else {
        _mainScroll.contentSize = CGSizeMake((667*kScreenWidth2) * _TDAry.count, 0);
    }
    _mainScroll.contentOffset = CGPointMake((667*kScreenWidth2) * ([_Num intValue] - 1), 0);
    _mainScroll.delegate = self;
    _mainScroll.bounces = NO;
    _mainScroll.tag = 9;
    _mainScroll.alwaysBounceVertical = NO;
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.pagingEnabled = YES;
    [self.view addSubview:_mainScroll];
    [self.view sendSubviewToBack:_mainScroll];
    
    
    if (_TDAry.count == 0) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 275)];
        imageView.tag = 10;
        imageView.image = [UIImage imageNamed:@"空地.jpg"];
        [_mainScroll addSubview:imageView];
    } else {
        [_scaleLayer3 removeFromSuperview];
        [[self.view viewWithTag:160] removeFromSuperview];
        UIImageView * imageView11 = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(465, 266, 60, 50)];
        imageView11.tag = 160;
        if ([_InfoDic[@"doglevel"] intValue] == 0) {
            imageView11.image = [UIImage imageNamed:@""];
        } else if ([_InfoDic[@"doglevel"] intValue] == 1) {
            imageView11.image = [UIImage imageNamed:@"杜宾犬"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 2) {
            imageView11.image = [UIImage imageNamed:@"哈士奇"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 3) {
            imageView11.image = [UIImage imageNamed:@"金毛寻回犬"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 4) {
            imageView11.image = [UIImage imageNamed:@"边境牧羊犬"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 5) {
            imageView11.image = [UIImage imageNamed:@"藏獒"];
        }
        [self.view addSubview:imageView11];
        
        self.scaleLayer3 = [[UIImageView alloc] init];
        _scaleLayer3.frame = WDH_CGRectMake1(405, 266, 60, 20);
        _scaleLayer3.layer.cornerRadius = 5;
        if ([_InfoDic[@"doglevel"] intValue] == 0) {
            _scaleLayer3.image = [UIImage imageNamed:@""];
        } else if ([_InfoDic[@"doglevel"] intValue] == 1) {
            _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.1"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 2) {
            _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.2"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 3) {
            _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.3"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 4) {
            _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.4"];
        } else if ([_InfoDic[@"doglevel"] intValue] == 5) {
            _scaleLayer3.image = [UIImage imageNamed:@"宠物Lv.5"];
        }
        
        [self.view addSubview:_scaleLayer3];
        
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnima.fromValue = @(_scaleLayer3.center.y);
        positionAnima.toValue = @(_scaleLayer3.center.y + 15);
        positionAnima.Autoreverses = YES;
        positionAnima.duration = 2.0f;
        positionAnima.repeatCount = MAXFLOAT;
        positionAnima.fillMode = kCAFillModeForwards;
        positionAnima.removedOnCompletion = NO;
        positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        [_scaleLayer3.layer addAnimation:positionAnima forKey:@"Animation"];
        
        
//        scaleAnimation3.toValue = [NSNumber numberWithFloat:30];//结束值
//        scaleAnimation3.autoreverses = YES;//是否动画回到原位
//        scaleAnimation3.fillMode = kCAFillModeForwards;
//        scaleAnimation3.repeatCount = MAXFLOAT;//重复次数
//        scaleAnimation3.duration = 1;//持续时间
//        [_scaleLayer3 addAnimation:scaleAnimation3 forKey:@"yAnimation"];
        
        
        self.scaleLayer1 = [[CALayer alloc] init];
        _scaleLayer1.frame = WDH_CGRectMake1(15, 60, 35, 35);
        _scaleLayer1.cornerRadius = 10;
        _scaleLayer1.contents =(id)[UIImage imageNamed:@"施肥"].CGImage;
        [self.view.layer addSublayer:_scaleLayer1];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.7];//初始值
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];//结束值
        scaleAnimation.autoreverses = YES;//是否动画回到原位
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.repeatCount = MAXFLOAT;//重复次数
        scaleAnimation.duration = 0.5;//持续时间
        [_scaleLayer1 addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        UIButton * CaiBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        CaiBtn1.frame = WDH_CGRectMake1(15, 60, 35, 35);
        CaiBtn1.tag = 987660;
        CaiBtn1.backgroundColor = [UIColor clearColor];
        [CaiBtn1 addTarget:self action:@selector(requestShiFei) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:CaiBtn1];
        
        UIButton * Cai1Btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        Cai1Btn1.frame = WDH_CGRectMake1(15, 60, 35, 35);
        Cai1Btn1.tag = 9987660;
        [Cai1Btn1 setBackgroundImage:[UIImage imageNamed:@"施肥"] forState:UIControlStateNormal];
        [Cai1Btn1 addTarget:self action:@selector(requestShiFei) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Cai1Btn1];

        
        if ([_Num intValue] == 1) {
            if ([_TDAry[0][@"shifei"] intValue] == 1) {
                Cai1Btn1.hidden = YES;
            } else {
                _scaleLayer1.hidden = YES;
                CaiBtn1.hidden = YES;
            }
        } else {
            if ([_TDAry[[_Num intValue] - 1][@"shifei"] intValue] == 1) {
                Cai1Btn1.hidden = YES;
            } else {
                _scaleLayer1.hidden = YES;
                CaiBtn1.hidden = YES;
            }
        }
        
        if ([_Num intValue] == 1) {
            if ([_TDAry[0][@"disaster"] intValue] == 2) {
                [self paly:@"2"];
            } else if ([_TDAry[0][@"disaster"] intValue] == 3) {
                [self paly:@"4"];
            } else if ([_TDAry[0][@"disaster"] intValue] == 4) {
                [self paly:@"3"];
            } else {
                [self paly:@"1"];
            }
        } else {
            if ([_TDAry[[_Num intValue] - 1][@"disaster"] intValue] == 2) {
                [self paly:@"2"];
            } else if ([_TDAry[[_Num intValue] - 1][@"disaster"] intValue] == 3) {
                [self paly:@"4"];
            } else if ([_TDAry[[_Num intValue] - 1][@"disaster"] intValue] == 4) {
                [self paly:@"3"];
            } else {
                [self paly:@"1"];
            }
        }
        
        
        
        
        
        self.scaleLayer = [[CALayer alloc] init];
        _scaleLayer.frame = WDH_CGRectMake1(135, 60, 35, 35);
        _scaleLayer.cornerRadius = 10;
        _scaleLayer.contents =(id)[UIImage imageNamed:@"采摘"].CGImage;
        [self.view.layer addSublayer:_scaleLayer];
        
        CABasicAnimation *scaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation1.fromValue = [NSNumber numberWithFloat:0.7];//初始值
        scaleAnimation1.toValue = [NSNumber numberWithFloat:1.0];//结束值
        scaleAnimation1.autoreverses = YES;//是否动画回到原位
        scaleAnimation1.fillMode = kCAFillModeForwards;
        scaleAnimation1.repeatCount = MAXFLOAT;//重复次数
        scaleAnimation1.duration = 0.5;//持续时间
        [_scaleLayer addAnimation:scaleAnimation1 forKey:@"scaleAnimation"];
        
        UIButton * CaiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        CaiBtn.frame = WDH_CGRectMake1(135, 60, 35, 35);
        CaiBtn.tag = 987659;
        CaiBtn.backgroundColor = [UIColor clearColor];
        [CaiBtn addTarget:self action:@selector(requestCaiZhai) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:CaiBtn];

        UIButton * Cai1Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Cai1Btn.frame = WDH_CGRectMake1(135, 60, 35, 35);
        Cai1Btn.tag = 9987659;
        [Cai1Btn setBackgroundImage:[UIImage imageNamed:@"采摘"] forState:UIControlStateNormal];
        [Cai1Btn addTarget:self action:@selector(requestCaiZhai) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Cai1Btn];
        
        NSDictionary * dic;
        if ([_Num intValue] == 1) {
            dic = _TDAry[0];
        } else {
            dic = _TDAry[[_Num intValue] - 1];
        }
        
        if ([dic[@"sluggish"] intValue] == 10) {
            Cai1Btn.hidden = YES;
        } else {
            _scaleLayer.hidden = YES;
            CaiBtn.hidden = YES;
        }
        
        if ([_SeedAry1[0][@"number"] intValue] == 0 && [_SeedAry1[1][@"number"] intValue] == 0 && [_SeedAry1[2][@"number"] intValue] == 0) {
            //种子仓库
            UIButton * CaiBtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
            CaiBtn3.frame = WDH_CGRectMake1(195, 60, 35, 35);
            CaiBtn3.tag = 161;
            [CaiBtn3 setBackgroundImage:[UIImage imageNamed:@"仓库"] forState:UIControlStateNormal];
            [CaiBtn3 addTarget:self action:@selector(ZhongZiCangKu) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:CaiBtn3];
        } else {
            self.scaleLayer2 = [[CALayer alloc] init];
            _scaleLayer2.frame = WDH_CGRectMake1(195, 60, 35, 35);
            _scaleLayer2.cornerRadius = 10;
            _scaleLayer2.contents =(id)[UIImage imageNamed:@"仓库"].CGImage;
            [self.view.layer addSublayer:_scaleLayer2];
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:0.7];//初始值
            scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];//结束值
            scaleAnimation.autoreverses = YES;//是否动画回到原位
            scaleAnimation.fillMode = kCAFillModeForwards;
            scaleAnimation.repeatCount = MAXFLOAT;//重复次数
            scaleAnimation.duration = 0.5;//持续时间
            [_scaleLayer2 addAnimation:scaleAnimation forKey:@"scaleAnimation"];
            
            //种子仓库
            UIButton * CaiBtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
            CaiBtn3.frame = WDH_CGRectMake1(195, 60, 35, 35);
            CaiBtn3.tag = 161;
            CaiBtn3.backgroundColor = [UIColor clearColor];
            [CaiBtn3 addTarget:self action:@selector(ZhongZiCangKu) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:CaiBtn3];
            
        }
        
        
        //种植种子
        UIButton *plantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        plantBtn.frame = WDH_CGRectMake1(530, 150, 60, 60);
        [plantBtn setBackgroundImage:[UIImage imageNamed:@"plabtBtn"] forState:UIControlStateNormal];
        plantBtn.tag = 152;
        [self.view addSubview:plantBtn];
        [plantBtn addTarget:self action:@selector(handleZZ) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        leftBtn.tag = 987655;
        leftBtn.frame = WDH_CGRectMake1(20, 167.5, 25, 40);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(handleZuo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftBtn];
        
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        rightBtn.tag = 987656;
        rightBtn.frame = WDH_CGRectMake1(622, 167.5, 25, 40);
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(handleYou) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:rightBtn];
        
        
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(280, 212, 70, 68)];
        imageView1.image = [UIImage imageNamed:@"land_number"];
        imageView1.tag = 987657;
        [self.view addSubview:imageView1];
        
        self.NumLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(280, 219, 70, 18)];
        _NumLabel.text = [NSString stringWithFormat:@" %@号地", _Num];
        _NumLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        _NumLabel.tag = 987658;
        _NumLabel.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        _NumLabel.textAlignment = 1;
        [self.view addSubview:_NumLabel];
        
         self.NumLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(280, 237, 70, 13)];
        if ([_Num intValue] == 1) {
            if ([_TDAry[0][@"plantTypeId"] intValue] == 1) {
                //桂圆
                _NumLabel1.text = [NSString stringWithFormat:@" 桂圆"];
            } else if ([_TDAry[0][@"plantTypeId"] intValue] == 2) {
                //枇杷
                _NumLabel1.text = [NSString stringWithFormat:@" 枇杷"];
            } else if ([_TDAry[0][@"plantTypeId"] intValue] == 3) {
                //椰子
                _NumLabel1.text = [NSString stringWithFormat:@" 椰子"];
            } else {
                //空地
                _NumLabel1.text = [NSString stringWithFormat:@" 空地"];
            }
        } else {
            if ([_TDAry[[_Num intValue] - 1][@"plantTypeId"] intValue] == 1) {
                //桂圆
                _NumLabel1.text = [NSString stringWithFormat:@" 桂圆"];
            } else if ([_TDAry[[_Num intValue] - 1][@"plantTypeId"] intValue] == 2) {
                //枇杷
                _NumLabel1.text = [NSString stringWithFormat:@" 枇杷"];
            } else if ([_TDAry[[_Num intValue] - 1][@"plantTypeId"] intValue] == 3) {
                //椰子
                _NumLabel1.text = [NSString stringWithFormat:@" 椰子"];
            } else {
                //空地
                _NumLabel1.text = [NSString stringWithFormat:@" 空地"];
            }
        }
        
        
        
        
        _NumLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        _NumLabel1.tag = 987658;
        _NumLabel1.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        _NumLabel1.textAlignment = 1;
        [self.view addSubview:_NumLabel1];
        
        
        
        
        UIButton * CaiBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        CaiBtn2.frame = WDH_CGRectMake1(75, 60, 35, 35);
        CaiBtn2.tag = 151;
        [CaiBtn2 setBackgroundImage:[UIImage imageNamed:@"偷取"] forState:UIControlStateNormal];
        [CaiBtn2 addTarget:self action:@selector(requestTouQu) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:CaiBtn2];
        
        
        if ([_InfoDic[@"landNum"] integerValue] > 55) {
//            Alert_Show(@"大爷！您收益已经很高了，留给贫农娱乐下吧！赏他口饭吃！")
            CaiBtn2.userInteractionEnabled = NO;
        } else {
            CaiBtn2.userInteractionEnabled = YES;
        }
        
        //领取小狗
        UIButton *gouwo = [UIButton buttonWithType:UIButtonTypeCustom];
        gouwo.frame = WDH_CGRectMake1(525, 215, 125, 100);
        gouwo.tag = 1501;
        [gouwo setBackgroundImage:[UIImage imageNamed:@"点击领狗-"] forState:UIControlStateNormal];
        [gouwo addTarget:self action:@selector(lingQuXiaoGou) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gouwo];
        
        
        for (int i = 0; i < _TDAry.count; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(667 * i, 0, 667, 275)];
            imageView.tag = 10 + i;
            NSDictionary * dic = _TDAry[i];
            NSString * ImageOne = @"";
            NSString * ImageTwo = @"";
            NSString * ImageThree = @"";

            switch ([dic[@"plantTypeId"] intValue]) {
                case 0:
                    ImageOne = @"0";
                    break;
                case 1:
                    //枇杷
                    ImageOne = @"3";
                    break;
                case 2:
                    //桂圆
                    ImageOne = @"1";
                    break;
                case 3:
                    //椰子
                    ImageOne = @"2";
                    break;
                default:
                    break;
            }
            
            switch ([dic[@"disaster"] intValue]) {
                case 1:
                    //正常天
                    ImageTwo = @"2";
                    break;
                case 2:
                    //雨天
                    ImageTwo = @"3";
                    break;
                case 3:
                    //旱灾
                    ImageTwo = @"1";
                    break;
                case 4:
                    //虫灾
                    ImageTwo = @"4";
                    break;
                default:
                    break;
            }
            
            switch ([dic[@"sluggish"] intValue]) {
                case 0:
                    ImageThree = @"1";
                    break;
                case 1:
                    ImageThree = @"1";
                    break;
                case 2:
                    ImageThree = @"2";
                    break;
                case 3:
                    ImageThree = @"2";
                    break;
                case 4:
                    ImageThree = @"3";
                    break;
                case 5:
                    ImageThree = @"4";
                    break;
                case 6:
                    ImageThree = @"4";
                    break;
                case 7:
                    ImageThree = @"4";
                    break;
                case 8:
                    ImageThree = @"4";
                    break;
                case 9:
                    ImageThree = @"4";
                    break;
                case 10:
                    ImageThree = @"5";
                    break;
                case 100:
                    ImageThree = @"4";
                    break;
                default:
                    break;
            }
            
            
            if ([ImageOne isEqualToString:@"0"]) {
                imageView.image = [UIImage imageNamed:@"肥沃土地.jpg"];
            } else {
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@%@.jpg", ImageOne, ImageTwo, ImageThree]];
            }
            [_mainScroll addSubview:imageView];
        }
    }
    
    
    NSArray *imgArr = @[@"", @"客服2",@"宝典",@"消息"];
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(612 - 60 * i, 60, 35, 35);
       
        
        if (i == 0) {
            NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
            if ([musicStr isEqualToString:@"1"]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"on@3x"] forState:UIControlStateNormal];
                [_player play];//播放
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:@"off@3x"] forState:UIControlStateNormal];
                [_player stop];
            }
            [btn addTarget:self action:@selector(handleOff) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(rightTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        btn.tag = 147 + i;
        [self.view addSubview:btn];
    }
    
    if ([_i isEqualToString:@"0"]) {
        
    } else {
        [self configImage:_i];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"pop"]) {
        [self requestpopOver];
    }
    
}

- (void) handleOff
{
    UIButton * Btn = [self.view viewWithTag:147];
    NSString * musicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"music"];
    if ([musicStr isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"music"];
        [Btn setBackgroundImage:[UIImage imageNamed:@"off@3x"] forState:UIControlStateNormal];
        [_player stop];//停止
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"music"];
        [Btn setBackgroundImage:[UIImage imageNamed:@"on@3x"] forState:UIControlStateNormal];
        [_player play];//播放
    }
}
/*
 **注释 : 修改创建
 **日期 : 7.12
 ** LYTCreated
 */
- (void)ZhongZiCangKu {
    //更新种子信息 采摘部分防止冲突
    [self.SeedAry removeAllObjects];
    [self.SeedAry1 removeAllObjects];
    [self.SeedAry2 removeAllObjects];
    [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLSeedsInfo] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"请求种子信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSArray * ary1 = responseObject[@"data"];
            for (NSDictionary * dic in ary1) {
                if ([dic[@"gainType"] intValue] == 0) {
                    [self.SeedAry addObject:dic];
                } else if ([dic[@"gainType"] intValue] == 1){
                    [self.SeedAry1 addObject:dic];
                }else if ([dic[@"gainType"] intValue] == 2){
                    [self.SeedAry2 addObject:dic];
                }
            }
            
            _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
            _PickVC.backgroundColor = [UIColor blackColor];
            _PickVC.alpha = 0.5;
            _PickVC.userInteractionEnabled = YES;
            [self.view  addSubview:_PickVC];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction66)];
            [_PickVC addGestureRecognizer:tap];
            
            UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 140)];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 10;
            view.layer.masksToBounds = YES;
            view.tag = 65432;
            [self.view addSubview:view];
            
            NSArray *titleBtnArr = @[@"收获",@"偷取"];
            for (int i = 0; i < 2; i ++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = WDH_CGRectMake1(233/2 * i + i * 1, 0, 233/2, 30);
                [btn setTitle:titleBtnArr[i] forState:UIControlStateNormal];
                [view addSubview:btn];
                btn.tag = 12457830 + i;
                [btn addTarget:self action:@selector(changKuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    btn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
                }else{
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
                }
            }
            
            NSArray * ary = @[@"收获桂圆:", @"收获枇杷:", @"收获椰子:"];
            
            for (int i = 0; i < 3; i++) {
                UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(30, 35 + 35 * i, 80, 30)];
                textLabel1.text = ary[i];
                textLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
                textLabel1.font = [UIFont systemFontOfSize:15*kScreenHeight2];
                [view addSubview:textLabel1];
                
                
                UILabel * textLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(115, 35 + 35 * i, 108, 30)];
                textLabel2.text = [NSString stringWithFormat:@"%.2f斤", [_SeedAry1[i][@"number"] floatValue]];
                textLabel2.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
                textLabel2.textAlignment = 1;
                textLabel2.font = [UIFont systemFontOfSize:15*kScreenHeight2];
                [view addSubview:textLabel2];
            }
            
            UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
            Btn.frame = WDH_CGRectMake1(221.5 + 208.5, 107.5, 25, 25);
            [Btn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            Btn.tag = 134679;
            Btn.layer.cornerRadius = 25/2;
            Btn.layer.masksToBounds = YES;
            Btn.backgroundColor = [UIColor grayColor];
            [Btn addTarget:self action:@selector(handleOff66) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:Btn];

            
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}


-(void)changKuBtnClick:(UIButton *)sender{
    
    UIButton *btn = [self.view viewWithTag:12457830];
    UIButton *btn1 = [self.view viewWithTag:12457831];
    btn.backgroundColor = [UIColor whiteColor];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIView *view = [self.view viewWithTag:316497];
    [view removeFromSuperview];
    
    //收获
    if (sender.tag == 12457830) {
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn1 setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self shouHuo];
    }else{//偷取
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self touQu];
    }
}

-(void)shouHuo{
    UIView *view = [self.view viewWithTag:65432];
    UIView *contentView = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 110)];
    contentView.tag = 316497;
    contentView.backgroundColor = [UIColor whiteColor];
    [view addSubview:contentView];
    
    NSArray * ary = @[@"收获桂圆:", @"收获枇杷:", @"收获椰子:"];
    
    for (int i = 0; i < 3; i++) {
        UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(30, 5 + 35 * i, 80, 30)];
        textLabel1.text = ary[i];
        textLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel1.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        [contentView addSubview:textLabel1];
        
        
        UILabel * textLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(115, 5 + 35 * i, 108, 30)];
        textLabel2.text = [NSString stringWithFormat:@"%.2f斤", [_SeedAry1[i][@"number"] floatValue]];
        textLabel2.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel2.textAlignment = 1;
        textLabel2.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        [contentView addSubview:textLabel2];
    }
}
-(void)touQu{
    UIView *view = [self.view viewWithTag:65432];
    UIView *contentView = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 110)];
    contentView.tag = 316497;
    contentView.backgroundColor = [UIColor whiteColor];
    [view addSubview:contentView];
    
    NSArray * ary = @[@"偷取桂圆:", @"偷取枇杷:", @"偷取椰子:"];
    
    for (int i = 0; i < 3; i++) {
        UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(30, 5 + 35 * i, 70, 30)];
        textLabel1.text = ary[i];
        textLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel1.font =[UIFont systemFontOfSize:15*kScreenHeight2];
        [contentView addSubview:textLabel1];
        
        
        UILabel * textLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(75, 5 + 35 * i, 108, 30)];
        textLabel2.text = [NSString stringWithFormat:@"%.2f斤", [_SeedAry2[i][@"number"] floatValue]];
        textLabel2.textColor = [UIColor  colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel2.textAlignment = 1;
        textLabel2.font = [UIFont systemFontOfSize:15*kScreenHeight2];
        [contentView addSubview:textLabel2];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = WDH_CGRectMake1(170, 10 + 35 * i, 40, 20);
        [btn setTitle:@"出售" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.tag = [_SeedAry2[i][@"id"] integerValue];
        if ([_SeedAry2[i][@"number"] floatValue] <= 0) {
            btn.enabled = NO;
        }
        btn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn addTarget:self action:@selector(touQuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        
    }
}

-(void)touQuBtnClick:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:@"%@/semen/steal/sale?semenId=%ld",GGL,sender.tag] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"售卖偷取的种子---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            sender.userInteractionEnabled = YES;
            NSString *str = [NSString stringWithFormat:@"售卖成功, 获取%.2f积分",[responseObject[@"data"][@"saleAmount"]doubleValue]];
            [self handleOff66];
            [self requestUserInfo];
            [self requestCXTDLB];
            Alert_Show(str);
        }else {
            sender.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        sender.userInteractionEnabled = YES;
    }];

}
- (void)handleOff66 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:65432] removeFromSuperview];
    UIButton *btn = [self.view viewWithTag:134679];
    [btn removeFromSuperview];
}

- (void)pickerViewAction66 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:65432] removeFromSuperview];
    UIButton *btn = [self.view viewWithTag:134679];
    [btn removeFromSuperview];
}

#pragma mark ----------修改到这里
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScroll) {
        int index = scrollView.contentOffset.x/(667*kScreenWidth2);
        _Num = [NSString stringWithFormat:@"%d", index + 1];
        _NumLabel.text = [NSString stringWithFormat:@" %d号地", index + 1];
        
        if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 1) {
            //桂圆
            _NumLabel1.text = [NSString stringWithFormat:@" 桂圆"];
        } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 2) {
            //枇杷
            _NumLabel1.text = [NSString stringWithFormat:@" 枇杷"];
        } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 3) {
            //椰子
            _NumLabel1.text = [NSString stringWithFormat:@" 椰子"];
        } else {
            //空地
            _NumLabel1.text = [NSString stringWithFormat:@" 空地"];
        }
        
        if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 3) {
            [self paly:@"4"];
        } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 4) {
            [self paly:@"3"];
        } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 2) {
            [self paly:@"2"];
        } else {
            [self paly:@"1"];
        }
        
        
        if ([_TDAry[[_NumLabel.text intValue] - 1][@"shifei"] intValue] == 1) {
            
            UIButton * Btn = [self.view viewWithTag:9987660];
            Btn.hidden = YES;
            UIButton * Btn1 = [self.view viewWithTag:987660];
            Btn1.hidden = NO;
            _scaleLayer1.hidden = NO;
        } else {
            UIButton * Btn = [self.view viewWithTag:987660];
            Btn.hidden = YES;
            _scaleLayer1.hidden = YES;
            UIButton * Btn1 = [self.view viewWithTag:9987660];
            Btn1.hidden = NO;
        }
        
        NSDictionary * dic = _TDAry[[_NumLabel.text intValue] - 1];
        
        if ([dic[@"sluggish"] intValue] == 10) {
            UIButton * Btn = [self.view viewWithTag:9987659];
            Btn.hidden = YES;
            UIButton * Btn1 = [self.view viewWithTag:987659];
            Btn1.hidden = NO;
            _scaleLayer.hidden = NO;
        } else {
            UIButton * Btn = [self.view viewWithTag:987659];
            Btn.hidden = YES;
            _scaleLayer.hidden = YES;
            UIButton * Btn1 = [self.view viewWithTag:9987659];
            Btn1.hidden = NO;
        }
    }
}

//滚动过程中，一直会调用该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scroll) {
        _TouQu = scrollView.contentOffset.x;
    }
}

- (void) handleZuo {
    
    if (_mainScroll.contentOffset.x > 0) {
        float a = _mainScroll.contentOffset.x / (667.0*kScreenWidth2);
        NSString * str = [NSString stringWithFormat:@"%f", a];
        NSArray * ary = [str componentsSeparatedByString:@"."];
        if ([[ary lastObject] intValue] == 0) {
            [_mainScroll setContentOffset:CGPointMake(_mainScroll.contentOffset.x - (667.0*kScreenWidth2), 0) animated:YES];
            _Num = [NSString stringWithFormat:@"%d", [_NumLabel.text intValue] - 1];
            _NumLabel.text = [NSString stringWithFormat:@" %d号地", [_NumLabel.text intValue] - 1];
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 1) {
                //桂圆
                _NumLabel1.text = [NSString stringWithFormat:@" 桂圆"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 2) {
                //枇杷
                _NumLabel1.text = [NSString stringWithFormat:@" 枇杷"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 3) {
                //椰子
                _NumLabel1.text = [NSString stringWithFormat:@" 椰子"];
            } else {
                //空地
                _NumLabel1.text = [NSString stringWithFormat:@" 空地"];
            }
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 3) {
                [self paly:@"4"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 4) {
                [self paly:@"3"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 2) {
                [self paly:@"2"];
            } else {
                [self paly:@"1"];
            }
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"shifei"] intValue] == 1) {
                
                UIButton * Btn = [self.view viewWithTag:9987660];
                Btn.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:987660];
                Btn1.hidden = NO;
                _scaleLayer1.hidden = NO;
            } else {
                UIButton * Btn = [self.view viewWithTag:987660];
                Btn.hidden = YES;
                _scaleLayer1.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:9987660];
                Btn1.hidden = NO;
            }
            NSDictionary * dic = _TDAry[[_NumLabel.text intValue] - 1];
            
            if ([dic[@"sluggish"] intValue] == 10) {
                UIButton * Btn = [self.view viewWithTag:9987659];
                Btn.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:987659];
                Btn1.hidden = NO;
                _scaleLayer.hidden = NO;
            } else {
                UIButton * Btn = [self.view viewWithTag:987659];
                Btn.hidden = YES;
                _scaleLayer.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:9987659];
                Btn1.hidden = NO;
            }
        }
        
    }
}

- (void) handleYou {
    if (_mainScroll.contentOffset.x < _mainScroll.contentSize.width - (667.0*kScreenWidth2)) {
        float a = _mainScroll.contentOffset.x / (667.0*kScreenWidth2);
        NSString * str = [NSString stringWithFormat:@"%f", a];
        NSArray * ary = [str componentsSeparatedByString:@"."];
        if ([[ary lastObject] intValue] == 0) {
            [_mainScroll setContentOffset:CGPointMake(_mainScroll.contentOffset.x + (667.0*kScreenWidth2), 0) animated:YES];
            _Num = [NSString stringWithFormat:@"%d", [_NumLabel.text intValue] + 1];
            _NumLabel.text = [NSString stringWithFormat:@" %d号地", [_NumLabel.text intValue] + 1];
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 1) {
                //桂圆
                _NumLabel1.text = [NSString stringWithFormat:@" 桂圆"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 2) {
                //枇杷
                _NumLabel1.text = [NSString stringWithFormat:@" 枇杷"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"plantTypeId"] intValue] == 3) {
                //椰子
                _NumLabel1.text = [NSString stringWithFormat:@" 椰子"];
            } else {
                //空地
                _NumLabel1.text = [NSString stringWithFormat:@" 空地"];
            }
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 3) {
                [self paly:@"4"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 4) {
                [self paly:@"3"];
            } else if ([_TDAry[[_NumLabel.text intValue] - 1][@"disaster"] intValue] == 2) {
                [self paly:@"2"];
            } else {
                [self paly:@"1"];
            }
            
            if ([_TDAry[[_NumLabel.text intValue] - 1][@"shifei"] intValue] == 1) {
                
                UIButton * Btn = [self.view viewWithTag:9987660];
                Btn.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:987660];
                Btn1.hidden = NO;
                _scaleLayer1.hidden = NO;
            } else {
                UIButton * Btn = [self.view viewWithTag:987660];
                Btn.hidden = YES;
                _scaleLayer1.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:9987660];
                Btn1.hidden = NO;
            }
            
            NSDictionary * dic = _TDAry[[_NumLabel.text intValue] - 1];
            
            if ([dic[@"sluggish"] intValue] == 10) {
                UIButton * Btn = [self.view viewWithTag:9987659];
                Btn.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:987659];
                Btn1.hidden = NO;
                _scaleLayer.hidden = NO;
            } else {
                UIButton * Btn = [self.view viewWithTag:987659];
                Btn.hidden = YES;
                _scaleLayer.hidden = YES;
                UIButton * Btn1 = [self.view viewWithTag:9987659];
                Btn1.hidden = NO;
            }
        }
        
    }
    
}

//右上角按钮点击
-(void)rightTopBtnClick:(UIButton *)sender{
    if (sender.tag == 147+3) {
        //消息
        
        UIView *messageView = [[UIView alloc]initWithFrame:self.view.bounds];
        messageView.tag = 123666;
        messageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:messageView];
        
        //弹窗顶部
        UIView * TopView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 50)];
        [messageView addSubview:TopView];
        
        //顶部添加标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:TopView.frame];
        titleLabel.text = @"消息";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [TopView addSubview:titleLabel];
        
        //添加一条灰线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(0, 49, 667, 1)];
        lineLabel.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];
        [TopView addSubview:lineLabel];
        
        UITableView * tableVC = [[UITableView alloc]initWithFrame:WDH_CGRectMake1(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50) style:UITableViewStylePlain];
        tableVC.backgroundColor = [UIColor backGray];
        tableVC.delegate = self;
        tableVC.dataSource = self;
        tableVC.tag = 123555;
        tableVC.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        tableVC.separatorStyle = NO;
        [messageView addSubview:tableVC];
        
        [tableVC registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mes"];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(600, 15, 50, 20);
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(messageCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        [messageView addSubview:closeBtn];
        
        [self requestMessageList];
        
        
    }else if (sender.tag == 147 + 2){
        //宝典
        [self gameRule];
    }else if (sender.tag == 147 + 1){
        //客服
        //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
        NSString  *qqNumber=@"1928564215";
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            webView.delegate = self;
            [webView loadRequest:request];
            [self.view addSubview:webView];
        }else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

-(void)messageCloseBtn{
    UIView *view = [self.view viewWithTag:123666];
    [view removeFromSuperview];
}
//偷取种子
- (void) requestTouQu {
    [self requestStealSeedList];
}

//领取小狗
-(void)lingQuXiaoGou{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString * date = [[NSUserDefaults standardUserDefaults] objectForKey:@"date2"];
    NSLog(@"当前时间:%@", dateTime);
    NSLog(@"取出时间:%@", date);
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"date2"]) {
        [WDHRequest requestAllListWith:[NSString stringWithFormat:GetDog] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"领取结果:%@", responseObject);
            
            if ([responseObject[@"code"] intValue] == 830) {
                Alert_Show(@"主人，你太棒了，有名犬看守再也不怕贼惦记了，腾出时间去分享人吧！")
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date2"];
                [self requestCXTDLB];
                [self requestUserInfo];
            } else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date2"];
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else if ([dateTime isEqualToString:date]) {
        [WDHRequest requestAllListWith:[NSString stringWithFormat:GetDog] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"领取结果:%@", responseObject);
            
            if ([responseObject[@"code"] intValue] == 830) {
                Alert_Show(@"领取成功")
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date2"];
                [self requestCXTDLB];
                [self requestUserInfo];
            } else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date2"];
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else {
        Alert_Show(@"您今天已经领取过狗狗咯, 明天再来吧!")
    }
}

//种植
- (void) handleZZ {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction15)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 160)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 100015;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"种植";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSArray * ary = @[@"桂圆种子", @"枇杷种子", @"椰子种子"];
    NSArray * Ary = @[_longyanLabel.text, _pipaLabel.text, _yeziLabel.text];
    for (int i = 0; i < 3; i++) {
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(15 + i * (173 / 3 + 15), 40, 173 / 3, 173 / 3 - 5);
        Btn.tag = 100000 + i;
        [Btn setBackgroundImage:[UIImage imageNamed:ary[i]] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(handleHT:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10 + i * (203 / 3 + 5), 100, 203 / 3, 20)];
        label.textAlignment = 1;
        label.tag = 200000 + i;
        label.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        label.text = [NSString stringWithFormat:@"共%@斤", Ary[i]];
        [view addSubview:label];
        
    }
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 60) / 2, 125, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    buyBtn.tag = 88888;
    [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleMZZ) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff15) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleOff15 {
    _seed = @"0";
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:100015] removeFromSuperview];
}

- (void) pickerViewAction15 {
    _seed = @"0";
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:100015] removeFromSuperview];
}

//换图
- (void) handleHT:(UIButton *)sender {
    if (sender.tag == 100000) {
//        UILabel * label = [self.view viewWithTag:200000];
        if ([_longyanLabel.text floatValue] == 0) {
            
        } else {
            if ([_seed isEqualToString:@"0"]) {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[0][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾桂圆"] forState:UIControlStateNormal];
            } else {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[0][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾桂圆"] forState:UIControlStateNormal];
                UIButton * Btn = [self.view viewWithTag:100001];
                UIButton * Btn1 = [self.view viewWithTag:100002];
                [Btn setBackgroundImage:[UIImage imageNamed:@"枇杷种子"] forState:UIControlStateNormal];
                [Btn1 setBackgroundImage:[UIImage imageNamed:@"椰子种子"] forState:UIControlStateNormal];
                
            }
        }
        
    } else if (sender.tag == 100001) {
//        UILabel * label = [self.view viewWithTag:200001];
        if ([_pipaLabel.text floatValue] == 0) {
            
        } else {
            if ([_seed isEqualToString:@"0"]) {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[1][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾枇杷"] forState:UIControlStateNormal];
            } else {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[1][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾枇杷"] forState:UIControlStateNormal];
                UIButton * Btn = [self.view viewWithTag:100000];
                UIButton * Btn1 = [self.view viewWithTag:100002];
                [Btn setBackgroundImage:[UIImage imageNamed:@"桂圆种子"] forState:UIControlStateNormal];
                [Btn1 setBackgroundImage:[UIImage imageNamed:@"椰子种子"] forState:UIControlStateNormal];
                
            }
        }
        
    } else {
//        UILabel * label = [self.view viewWithTag:200002];
        if ([_yeziLabel.text floatValue] == 0) {
            
        } else {
            if ([_seed isEqualToString:@"0"]) {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[2][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾椰子"] forState:UIControlStateNormal];
            } else {
                _seed = @"1";
                _seedId = [NSString stringWithFormat:@"%@", _SeedAry[2][@"semenTypeId"]];
                [sender setBackgroundImage:[UIImage imageNamed:@"勾椰子"] forState:UIControlStateNormal];
                UIButton * Btn = [self.view viewWithTag:100000];
                UIButton * Btn1 = [self.view viewWithTag:100001];
                [Btn setBackgroundImage:[UIImage imageNamed:@"桂圆种子"] forState:UIControlStateNormal];
                [Btn1 setBackgroundImage:[UIImage imageNamed:@"枇杷种子"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void) handleMZZ {
    
    if ([[_seedId class] isEqual:[NSNull class]]) {
        Alert_Show(@"请选择要播种的种子")
    }else if (_seedId==nil){
        Alert_Show(@"请选择要播种的种子")
    }else{
        int index = [_NumLabel.text intValue] - 1;
        NSDictionary * dic = _TDAry[index];
        [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLTDZZ, dic[@"id"], _seedId] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"种植结果:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                [self requestUserInfo];
                [self requestCXTDLB];
                [self handleOff15];
                Alert_Show(@"种植成功")
            } else if ([responseObject[@"code"] intValue] == 819) {
                [self handleOff15];
                [self handleMaiHuaFei:[NSString stringWithFormat:@"%@",  responseObject[@"message"]]];
            } else {
                [self handleOff15];
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    }
    
}

- (void) handleMaiHuaFei:(NSString *)str {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction65)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 654321;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"购买化肥";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(20, 40, 193, 40)];
    textLabel1.text = str;
    textLabel1.numberOfLines = 0;
    textLabel1.textAlignment = 1;
    textLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    textLabel1.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:textLabel1];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 60) / 2, 85, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    buyBtn.tag = 88888;
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleMaiHF) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff65) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleOff65 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:654321] removeFromSuperview];
}

- (void) pickerViewAction65 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:654321] removeFromSuperview];
}

//功能按钮
- (void) configFunctionBtn
{
    UIView * backView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(0, 325, 667, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.tag = 99;
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
    
    NSArray * ary = @[@"种子", @"土地", @"账单", @"结算", @"转账", @"收米", @"分享", @"设置"];
    for (int i = 0; i < 8; i++) {
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(38 + 80 * i, 7.5, 32, 35);
        Btn.tag = 100 + i;
        [Btn setBackgroundImage:[UIImage imageNamed:ary[i]] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:Btn];
    }
}

#pragma mark          ---------- 处理功能时间 ----------
//挂单
- (void) handleGuaDan
{
    [self requestGD];
}

//挂单列表
- (void) handleGuaDanList
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction9)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10009;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"挂单记录";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    UITableView * tableVC = [[UITableView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 90) style:UITableViewStylePlain];
    tableVC.backgroundColor = [UIColor whiteColor];
    tableVC.delegate = self;
    tableVC.dataSource = self;
    tableVC.tag = 77777;
    tableVC.separatorStyle = NO;
    [view addSubview:tableVC];
    [tableVC registerClass:[GDCell class] forCellReuseIdentifier:@"GD"];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff9) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleOff9 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10009] removeFromSuperview];
}

- (void) pickerViewAction9 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10009] removeFromSuperview];
}

//粉丝列表
- (void) handleFenSiList
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction29)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 130)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10109;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"粉丝列表";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    UITableView * tableVC = [[UITableView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 90) style:UITableViewStylePlain];
    tableVC.backgroundColor = [UIColor whiteColor];
    tableVC.delegate = self;
    tableVC.dataSource = self;
    tableVC.tag = 44444;
    tableVC.separatorStyle = NO;
    tableVC.rowHeight = 50;
    [view addSubview:tableVC];
    [tableVC registerClass:[FSCell class] forCellReuseIdentifier:@"FS"];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff29) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleOff29 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10109] removeFromSuperview];
}

- (void) pickerViewAction29 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10109] removeFromSuperview];
}

- (void)handleAction:(UIButton *)sender
{
    if (sender.tag == 100) {
        [self requestZZSC];
    } else if (sender.tag == 101) {
        [self handleTwo];
    } else if (sender.tag == 102) {
        [self requestzhangdan];
    } else if (sender.tag == 103) {
        [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLbankInfo] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"请求银行卡信息:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                _bankDic = responseObject[@"data"];
                [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLbank] completeWithBlock:^(NSDictionary *responseObject) {
                    NSLog(@"请求提现校验:%@", responseObject);
                    if ([responseObject[@"code"] intValue] == 0) {
                        [self handleFour];
                    } else if ([responseObject[@"code"] intValue] == 863) {
                        Alert_Show(@"有未处理的提现记录, 请耐心等待");
                    } else if ([responseObject[@"code"] intValue] == 300301) {
                        Alert_Show(@"服务器忙, 请稍后再试");
                    }
                } WithError:^(NSString *errorStr) {
                    //处理token失效
                    if ([errorStr isEqualToString:@"1"]) {
                        [self LoginRequest];
                    }
                }];
            } else {
                Alert_Show(@"未绑定银行卡");
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else if (sender.tag == 104) {
        [self handleZhuanZhang];
    } else if (sender.tag == 105) {
        [self requestshoumi];
    } else if (sender.tag == 106) {
        [self handleSix];
    } else if (sender.tag == 107) {
        [self handleSeven];
    }
}

- (void) handleZhuanZhang {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    
    //70 高200
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 90, 233, 200)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10404;
    [self.view addSubview:view];
    
    NSArray *titleBtnArr = @[@"普通转账",@"种子转账"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = WDH_CGRectMake1(233/2 * i + i * 1, 0, 233/2, 30);
        [btn setTitle:titleBtnArr[i] forState:UIControlStateNormal];
        [view addSubview:btn];
        btn.tag = 12457850 + i;
        [btn addTarget:self action:@selector(Zhang:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
            
        }else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        }
    }
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(221.5 + 208.5, 77.5, 25, 25);
    [Btn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    Btn.tag = 134675;
    Btn.layer.cornerRadius = 25/2;
    Btn.layer.masksToBounds = YES;
    Btn.backgroundColor = [UIColor grayColor];
    [Btn addTarget:self action:@selector(handleOff44) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 40, 60, 39)];
    leftLabel.text = @"对方账户";
    leftLabel.tag = 4369;
    leftLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel];
    
    UILabel * leftLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 80, 60, 39)];
    leftLabel1.text = @"转账金额";
    leftLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel1.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel1];
    
    UILabel * leftLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 120, 60, 40)];
    leftLabel2.text = @"支付密码";
    leftLabel2.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel2.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel2];
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 79, 213, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [view addSubview:lineLabel];
    
    UILabel * lineLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 119, 213, 1)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [view addSubview:lineLabel1];

    NSArray * ary = @[@"请输入对方账户", @"请输入转账金额", @"请输入支付密码"];
    for (int i = 0; i < 3; i++) {
        UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(70, 45 + 40 * i, 160, 35)];
        textTf.placeholder = ary[i];
        textTf.tag = 1800 + i;
        textTf.delegate = self;
        if (i == 1) {
            
            if ([_InfoDic[@"amount"] floatValue] - [_InfoDic[@"semenAmount"] floatValue] < 0) {
                textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", 0.00];
            } else{
                textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", [_InfoDic[@"amount"] floatValue] - [_InfoDic[@"semenAmount"] floatValue]];
            }
            
        }
        textTf.keyboardType = UIKeyboardTypeDecimalPad;
        [textTf setValue:[UIFont boldSystemFontOfSize:12*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
        [view addSubview:textTf];
    }
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 165, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.tag = 7599;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(ActionZhuanZhang) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    //    UITableView * ZDTable = [[UITableView alloc] init];
}

-(void)Zhang:(UIButton *)sender{
    UIButton *btn = [self.view viewWithTag:12457850];
    UIButton *btn1 = [self.view viewWithTag:12457851];
    btn.backgroundColor = [UIColor whiteColor];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //左边
    if (sender.tag == 12457850) {
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn1 setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        _ZzCode = 0;
        UITextField * textTf = [self.view viewWithTag:1801];
        
        if ([_InfoDic[@"amount"] floatValue] - [_InfoDic[@"semenAmount"] floatValue] < 0) {
            textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", 0.00];
        } else{
            textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", [_InfoDic[@"amount"] floatValue] - [_InfoDic[@"semenAmount"] floatValue]];
        }
    } else {
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        _ZzCode = 1;
        UITextField * textTf = [self.view viewWithTag:1801];
        if ([_InfoDic[@"semenAmount"] floatValue] < 0) {
            textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", 0.00];
        } else{
            textTf.placeholder = [NSString stringWithFormat:@"可转账金额%.2f积分", [_InfoDic[@"semenAmount"] floatValue]];
        }
    }
}

- (void) handleOff44 {
    
    [[self.view viewWithTag:134675] removeFromSuperview];
    [[self.view viewWithTag:10404] removeFromSuperview];
    [_PickVC removeFromSuperview];
}

- (void)ActionZhuanZhang {
    
    UIButton * Btn = [self.view viewWithTag:7599];
    Btn.userInteractionEnabled = NO;
    UITextField * tf = [self.view viewWithTag:1800];
    UITextField * tf1 = [self.view viewWithTag:1801];
    UITextField * tf2 = [self.view viewWithTag:1802];
    
    NSString * url = @"";
    
    if (_ZzCode == 0) {
        url = [NSString stringWithFormat:GGLZZ, [NSString stringWithFormat:@"%.2f", [tf1.text floatValue]], tf2.text, tf.text];
    } else if (_ZzCode == 1) {
        url = [NSString stringWithFormat:GGLZZZ, [NSString stringWithFormat:@"%.2f", [tf1.text floatValue]], tf2.text, tf.text];
    }
    
    
    [WDHRequest requestTypePostWith:url completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"转账:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Btn.userInteractionEnabled = YES;
            [self handleOff44];
            Alert_Show(@"转账成功");
            [self requestCXTDLB];
            [self requestUserInfo];
        } else {
            Btn.userInteractionEnabled = YES;
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        Btn.userInteractionEnabled = YES;
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

- (void)handleOne
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction1)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 130)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10001;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"种子商城";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSArray * ary = @[@"桂圆种子1", @"枇杷种子1", @"椰子种子1"];
    NSArray * Ary = @[@"10.00/斤", @"30.00/斤", @"60.00/斤"];
    
    for (int i = 0; i < 3; i++) {
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(15 + i * (173 / 3 + 15), 40, 173 / 3, 173 / 3);
        Btn.layer.cornerRadius = 173 / 3 / 2;
        Btn.tag = 200 + i;
        Btn.layer.masksToBounds = YES;
        [Btn setBackgroundImage:[UIImage imageNamed:ary[i]] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(handleZhongZi:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10 + i * (203 / 3 + 5), 103, 203 / 3, 20)];
        label.textAlignment = 1;
        label.tag = 2000000 + i;
        label.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        label.text = [NSString stringWithFormat:@"%@", Ary[i]];
        [view addSubview:label];
    }
    
    if ([self.SeedDic[@"reserve"] intValue] == 1) {
        UILabel *qiangLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(218.5, 255, 30, 30)];
        qiangLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
        qiangLabel.textAlignment = NSTextAlignmentCenter;
        qiangLabel.text = @"抢";
        qiangLabel.tag = 10102020;
        qiangLabel.layer.cornerRadius = 15;
        qiangLabel.layer.masksToBounds = YES;
        qiangLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:0/255.0 blue:1/255.0 alpha:1];
        qiangLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:qiangLabel];
        
        UILabel *textLabel1 = [[UILabel alloc]initWithFrame:WDH_CGRectMake1(255, 260, 180, 20)];
        textLabel1.text = @"你有预购订单,请点击获取";
        textLabel1.textColor = [UIColor whiteColor];
        textLabel1.font = [UIFont systemFontOfSize:14*kScreenHeight2];
        [self.view addSubview:textLabel1];
        textLabel1.tag = 10102021;
        
        UIButton * qiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qiangBtn.frame = WDH_CGRectMake1(208.5, 250, 233, 40);
        qiangBtn.tag = 10102022;
        [qiangBtn addTarget:self action:@selector(qiangBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:qiangBtn];
    }
    
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleZhongZi:(UIButton *)sender
{
    if (sender.tag == 200) {
        NSString * type = [NSString stringWithFormat:@"%@", _SeedDic[@"semenTypes"][0][@"id"]];
        NSString * market = [NSString stringWithFormat:@"%@", _SeedDic[@"id"]];
        [self requestGMZZ:type Market:market];
    } else if (sender.tag == 201) {
        NSString * type = [NSString stringWithFormat:@"%@", _SeedDic[@"semenTypes"][1][@"id"]];
        NSString * market = [NSString stringWithFormat:@"%@", _SeedDic[@"id"]];
        [self requestGMZZ:type Market:market];
    } else {
        NSString * type = [NSString stringWithFormat:@"%@", _SeedDic[@"semenTypes"][2][@"id"]];
        NSString * market = [NSString stringWithFormat:@"%@", _SeedDic[@"id"]];
        [self requestGMZZ:type Market:market];
    }
}



- (void) handleOff1 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10001] removeFromSuperview];
    
    UILabel *label1 = [self.view viewWithTag:10102020];
    UILabel *label2 = [self.view viewWithTag:10102021];
    UIButton *btn = [self.view viewWithTag:10102022];
    [label1 removeFromSuperview];
    [label2 removeFromSuperview];
    [btn removeFromSuperview];
    
}

- (void) pickerViewAction1 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10001] removeFromSuperview];
    UILabel *label1 = [self.view viewWithTag:10102020];
    UILabel *label2 = [self.view viewWithTag:10102021];
    UIButton *btn = [self.view viewWithTag:10102022];
    [label1 removeFromSuperview];
    [label2 removeFromSuperview];
    [btn removeFromSuperview];
}

- (void)handleTwo
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction2)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 125)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10002;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"购买土地";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSInteger num = _TDAry.count;
    
    
    NSInteger landNum = 15;
    
    UILabel * numLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(85, 40, 63, 30)];
    if (num < landNum) {
        numLabel.text = @"1";
    } else {
        numLabel.text = @"0";
    }
    
    numLabel.textAlignment = 1;
    numLabel.font = [UIFont systemFontOfSize:20*kScreenHeight2];
    numLabel.tag = 10010;
    numLabel.layer.cornerRadius = 5;
    numLabel.layer.masksToBounds = YES;
    numLabel.layer.borderWidth = 1.0f;
    numLabel.layer.borderColor = [UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:1].CGColor;
    [view addSubview:numLabel];
    
    UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 70, 233, 20)];
    Label.text = [NSString stringWithFormat:@"您当前最多拥有土地数量%ld块", landNum];
    Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 /255.0 blue:70 / 255.0 alpha:1];
    Label.textAlignment = 1;
    Label.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:Label];
    
    UIButton * delBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    delBtn.frame = WDH_CGRectMake1(35, 40, 40, 30);
    delBtn.layer.cornerRadius = 5;
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.borderWidth = 1.0f;
    delBtn.layer.borderColor = [UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:1].CGColor;
    [delBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 /255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [delBtn setTitle:@"-" forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(handleDelete) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:delBtn];
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addBtn.frame = WDH_CGRectMake1(158, 40, 40, 30);
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.borderWidth = 1.0f;
    addBtn.layer.borderColor = [UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:1].CGColor;
    [addBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 /255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(handleAdd) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 95, 50, 25);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleBuy) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleBuy
{
    [self requestGMTD];
}

- (void) handleDelete {
    UILabel * label = [self.view viewWithTag:10010];
    NSInteger num = _TDAry.count;
    NSInteger landNum = 15;
    if (num < landNum) {
        if ([label.text intValue] > 1) {
            label.text = [NSString stringWithFormat:@"%d", [label.text intValue] - 1];
        }
    } else {
        if ([label.text intValue] > 0) {
            label.text = [NSString stringWithFormat:@"%d", [label.text intValue] - 1];
        }
    }
    
}

- (void) handleAdd {
    UILabel * label = [self.view viewWithTag:10010];
    NSInteger num = _TDAry.count;
    NSInteger landNum = 15;

    if ([label.text integerValue] < landNum - num) {
        label.text = [NSString stringWithFormat:@"%d", [label.text intValue] + 1];
    }
}

- (void) handleOff2 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10002] removeFromSuperview];
}

- (void) pickerViewAction2 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10002] removeFromSuperview];
}

- (void) handleThree {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction3)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10003;
    [self.view addSubview:view];
    
    NSArray *titleBtnArr = @[@"账单",@"分润"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = WDH_CGRectMake1(233/2 * i + i * 1, 0, 233/2, 30);
        [btn setTitle:titleBtnArr[i] forState:UIControlStateNormal];
        [view addSubview:btn];
        btn.tag = 12457840 + i;
        [btn addTarget:self action:@selector(ZhangDanClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        }else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        }
    }

    
    UITableView * tableVC = [[UITableView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 90) style:UITableViewStylePlain];
    tableVC.backgroundColor = [UIColor whiteColor];
    tableVC.delegate = self;
    tableVC.dataSource = self;
    tableVC.tag = 55555;
    tableVC.separatorStyle = NO;
    [view addSubview:tableVC];
    [tableVC registerClass:[ZDCell class] forCellReuseIdentifier:@"ZD"];
    
    
    [tableVC reloadData];
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(221.5 + 208.5, 107.5, 25, 25);
    [Btn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    Btn.tag = 134671;
    Btn.layer.cornerRadius = 25/2;
    Btn.layer.masksToBounds = YES;
    Btn.backgroundColor = [UIColor grayColor];
    [Btn addTarget:self action:@selector(handleOff3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
}

- (void) handleOff3 {
    [[self.view viewWithTag:134671] removeFromSuperview];
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10003] removeFromSuperview];
}

- (void) pickerViewAction3 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:134671] removeFromSuperview];
    [[self.view viewWithTag:10003] removeFromSuperview];
}

-(void)ZhangDanClick:(UIButton *)sender{
    UIButton *btn = [self.view viewWithTag:12457840];
    UIButton *btn1 = [self.view viewWithTag:12457841];
    btn.userInteractionEnabled = NO;
    btn1.userInteractionEnabled = NO;
    btn.backgroundColor = [UIColor whiteColor];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //左边
    if (sender.tag == 12457840) {
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn1 setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self requestzhangZuo];
    //右边
    } else {
        sender.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        [btn setTitleColor:[UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self requestzhangYou];
    }
}


- (void) handleFour {
    _PickVC1 = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC1.backgroundColor = [UIColor blackColor];
    _PickVC1.alpha = 0.5;
    _PickVC1.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC1];
    
    //高200
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 70, 233, 220)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10004;
    [self.view addSubview:view];
    
//    UILabel * leftLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 35, 213, 70)];
//    leftLabel.text = @"正在开发中...";
//    leftLabel.tag = 369;
//    leftLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
//    leftLabel.textAlignment = 1;
//    leftLabel.font = [UIFont boldSystemFontOfSize:20];
//    [view addSubview:leftLabel];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"结算";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];

    UILabel * leftLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 40, 60, 39)];
    leftLabel.text = @"银行卡";
    leftLabel.tag = 4369;
    leftLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel];

    UILabel * leftLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 80, 60, 39)];
    leftLabel1.text = @"提现金额";
    leftLabel1.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel1.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel1];
    
    UILabel * leftLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 120, 60, 40)];
    leftLabel2.text = @"支付密码";
    leftLabel2.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    leftLabel2.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:leftLabel2];
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 79, 213, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [view addSubview:lineLabel];
    
    UILabel * lineLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 119, 213, 1)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [view addSubview:lineLabel1];
    
    UILabel * lineLabel2 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 159, 213, 1)];
    lineLabel2.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [view addSubview:lineLabel2];
    
    UILabel * textLabel1 = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 160, 213, 20)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel1.text = @"1.提现T+1到账，节假日顺延 2.整百提现";
    textLabel1.textAlignment = 0;
    textLabel1.textColor = [UIColor lightGrayColor];
    textLabel1.font = [UIFont systemFontOfSize:10*kScreenHeight2];
    [view addSubview:textLabel1];
    
    UILabel * rightLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(70, 40, 150, 39)];
    leftLabel.text = @"银行卡";
    rightLabel.text = [NSString stringWithFormat:@"%@", _bankDic[@"cardNo"]];
    rightLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
    rightLabel.tag = 60011;
    rightLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [view addSubview:rightLabel];

    float a = 0;
    if ([_InfoDic[@"amount"] floatValue] - [_InfoDic[@"transfer"] floatValue] - [_InfoDic[@"semenAmount"] floatValue] < 0) {
        a = 0;
    } else {
        a = [_InfoDic[@"amount"] floatValue] - [_InfoDic[@"transfer"] floatValue] - [_InfoDic[@"semenAmount"] floatValue];
    }
    
    
    UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(70, 85, 160, 35)];
    textTf.placeholder = [NSString stringWithFormat:@"可提现到卡%.2f积分", a];
    textTf.tag = 15001;
    textTf.delegate = self;
    textTf.keyboardType = UIKeyboardTypeNumberPad;
    [textTf setValue:[UIFont boldSystemFontOfSize:12*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
    [view addSubview:textTf];
    
    UITextField * textTf1 = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(70, 125, 130, 35)];
    textTf1.placeholder = [NSString stringWithFormat:@"请输入支付密码"];
    textTf1.tag = 15002;
    textTf1.delegate = self;
    textTf1.keyboardType = UIKeyboardTypeNumberPad;
    [textTf1 setValue:[UIFont boldSystemFontOfSize:12*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
    [view addSubview:textTf1];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 185, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.tag = 7899;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleTT) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    //    UITableView * ZDTable = [[UITableView alloc] init];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff4) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleTT
{
    UIButton * Btn = [self.view viewWithTag:7899];
    Btn.userInteractionEnabled = NO;
    
    UITextField * tf = [self.view viewWithTag:15001];
    UITextField * tf1 = [self.view viewWithTag:15002];
    
    float a = [tf.text floatValue] / 100;
    NSString * str = [NSString stringWithFormat:@"%f", a];
    NSArray * ary = [str componentsSeparatedByString:@"."];
    if ([tf.text floatValue] > 0 && [[ary lastObject] intValue] == 0) {
        [WDHRequest requestTypePostWith:[NSString stringWithFormat:GGLTX, [NSString stringWithFormat:@"%.2f", [tf.text floatValue]], tf1.text, @"1"] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"提现结果:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 817) {
                Btn.userInteractionEnabled = YES;
                [[self.view viewWithTag:60002] removeFromSuperview];
                [self pickerViewAction4];
                Alert_Show(@"提现成功请耐心等待1-2个工作日！")
                [self requestCXTDLB];
                [self requestUserInfo];
            } else {
                Btn.userInteractionEnabled = YES;
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            Btn.userInteractionEnabled = YES;
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else {
        Alert_Show(@"提现金额必须为整百")
    }
}

- (void) handleOff4 {
    [_PickVC1 removeFromSuperview];
    [[self.view viewWithTag:10004] removeFromSuperview];
    [[self.view viewWithTag:60002] removeFromSuperview];
}

- (void) pickerViewAction4 {
    [_PickVC1 removeFromSuperview];
    [[self.view viewWithTag:60002] removeFromSuperview];
    [[self.view viewWithTag:10004] removeFromSuperview];
}

- (void) handleFive {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction5)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10005;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"收米";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    UITableView * tableVC = [[UITableView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 90) style:UITableViewStylePlain];
    tableVC.backgroundColor = [UIColor whiteColor];
    tableVC.delegate = self;
    tableVC.dataSource = self;
    tableVC.tag = 66666;
    tableVC.separatorStyle = NO;
    [view addSubview:tableVC];
    [tableVC registerClass:[SZCell class] forCellReuseIdentifier:@"SZ"];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff5) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];

}

- (void) handleOff5 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10005] removeFromSuperview];
}

- (void) pickerViewAction5 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10005] removeFromSuperview];
}

- (void) handleSix {
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_QQ withPlatformIcon:[UIImage imageNamed:@"qq"]  withPlatformName:@"QQ"];
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_Sina withPlatformIcon:[UIImage imageNamed:@"sina"]  withPlatformName:@"新浪微博"];
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatSession withPlatformIcon:[UIImage imageNamed:@"wechat"]  withPlatformName:@"微信"];
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatTimeLine withPlatformIcon:[UIImage imageNamed:@"timeline"]  withPlatformName:@"朋友圈"];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"果果乐" descr:[NSString stringWithFormat:@"%@邀请您来一起畅玩果果乐农场, 朝着大地主的梦想进发吧!!!", _InfoDic[@"mobile"]] thumImage:[UIImage imageNamed:@"icon"]];
        //设置网页地址
        shareObject.webpageUrl = @"https://m.caiyun156.com";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        [UMSocialShareResponse shareResponseWithMessage:@"分享成功"];
        //调用分享接口https://www.yixiaolabs.com
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
                
            }
        }];
    }];
}

- (void) handleOff6 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10006] removeFromSuperview];
}

- (void) pickerViewAction6 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10006] removeFromSuperview];
}

- (void) handleSeven {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction7)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 150)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10007;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"设置";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSArray * ary = @[@"修改登录密码", @"修改支付密码", @"绑定银行卡", @"注销"];
    for (int i = 0; i < 4; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(60, 35 + 30 * i, 20, 20)];
        imageView.image = [UIImage imageNamed:ary[i]];
        [view addSubview:imageView];
        UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(90, 30 + 30 * i, 150, 30)];
        textLabel.text = ary[i];
        textLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        [view addSubview:textLabel];
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(0, 30 + 30 * i, 233, 30);
        Btn.backgroundColor = [UIColor clearColor];
        Btn.tag = 500 + i;
        [Btn addTarget:self action:@selector(handleGo:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
    }
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff7) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}

- (void) handleGo:(UIButton *)sender
{
    [self handleOff7];
    if (sender.tag == 500) {
        //修改登录密码
        [self hanldeMiMa:@"1"];
    } else if (sender.tag == 501) {
        //修改支付密码
        [self hanldeMiMa:@"2"];
    } else if (sender.tag == 502) {
        //绑定银行卡
        [WDHRequest requestAllListWith:[NSString stringWithFormat:GGLbankInfo] completeWithBlock:^(NSDictionary *responseObject) {
            NSLog(@"请求银行卡信息:%@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
                _bankDic = responseObject[@"data"];
                [self handleBankCard:@"0"];
            } else {
                [self handleBankCard:@"1"];
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else if (sender.tag == 503) {
        //注销
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date1"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date2"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refresh_token"];
        [self configBack];
    }
}

- (void)handleList
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewAction27)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 125, 233, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 10307;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"查看";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    NSArray * ary = @[@"查看挂单记录", @"查看粉丝列表"];
    for (int i = 0; i < 2; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(60, 45 + 40 * i, 20, 20)];
        imageView.image = [UIImage imageNamed:ary[i]];
        [view addSubview:imageView];
        UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(90, 40 + 40 * i, 150, 30)];
        textLabel.text = ary[i];
        textLabel.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
        textLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        [view addSubview:textLabel];
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(0, 40 + 40 * i, 233, 30);
        Btn.backgroundColor = [UIColor clearColor];
        Btn.tag = 500 + i;
        [Btn addTarget:self action:@selector(handleGo1:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
    }
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff27) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];

}

- (void) handleGo1:(UIButton *)sender
{
    [self handleOff27];
    if (sender.tag == 500) {
        //查看挂单列表
        [self requestGDList];
    } else if (sender.tag == 501) {
        //查看粉丝列表
        [self requestFenSiList];
    }
}

- (void) handleOff27 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10307] removeFromSuperview];
}

- (void) pickerViewAction27 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10307] removeFromSuperview];
}


- (void) handleOff7 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10007] removeFromSuperview];
}

- (void) pickerViewAction7 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10007] removeFromSuperview];
}

- (void) hanldeMiMa:(NSString *)str {
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    
    
    if ([str intValue] == 1) {
        //修改登录
        UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 90, 233, 165)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        view.tag = 20001;
        [self.view addSubview:view];
        
        NSArray * ary = @[@"新密码", @"确认新密码", @"验证码"];
        NSArray * ary1 = @[@"请输入", @"请输入", @"请输入"];
        for (int i = 0; i < 3; i++) {
            UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 50 + 30 * i, 213, 1)];
            lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
            [view addSubview:lineLabel];
            
            UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 20 + 30 * i, 80, 29)];
            Label.text = ary[i];
            Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
            Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
            [view addSubview:Label];
            
            UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(100, 23 + 30 * i, 120, 26)];
            textTf.placeholder = ary1[i];
            textTf.tag = 70000 + i;
            textTf.delegate = self;
            [textTf setValue:[UIFont boldSystemFontOfSize:15*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
            [view addSubview:textTf];
        }
        
        self.GetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _GetBtn.frame = WDH_CGRectMake1(180, 85, 40, 20);
        _GetBtn.layer.cornerRadius = 5;
        _GetBtn.layer.masksToBounds = YES;
        _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
        [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_GetBtn setTitle:@"获取" forState:UIControlStateNormal];
        _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
        [_GetBtn addTarget:self action:@selector(handleGet1) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_GetBtn];
        
        UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 113, 213, 12)];
        textLabel.text = @"密码是6-16位的数字, 字母组合";
        textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1];
        textLabel.font = [UIFont systemFontOfSize:10*kScreenHeight2];
        [view addSubview:textLabel];
        
        UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 130, 60, 30);
        buyBtn.layer.cornerRadius = 5;
        buyBtn.layer.masksToBounds = YES;
        buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
        buyBtn.tag = 30001;
        [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(handleChange:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:buyBtn];
        
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(210.5, 7.5, 15, 15);
        [Btn setBackgroundImage:[UIImage imageNamed:@"修改密码关闭"] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(handleOff10) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
    } else {
        //修改支付
        if ([_InfoDic[@"ampassIs"] intValue] == 0) {
            UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 90, 233, 165)];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 10;
            view.layer.masksToBounds = YES;
            view.tag = 20001;
            [self.view addSubview:view];
            
            NSArray * ary = @[@"新密码", @"确认新密码", @"验证码"];
            NSArray * ary1 = @[@"请输入", @"请输入", @"请输入"];
            for (int i = 0; i < 3; i++) {
                UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 50 + 30 * i, 213, 1)];
                lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
                [view addSubview:lineLabel];
                
                UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 20 + 30 * i, 80, 29)];
                Label.text = ary[i];
                Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
                Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
                [view addSubview:Label];
                
                UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(100, 23 + 30 * i, 120, 26)];
                textTf.keyboardType = UIKeyboardTypeNumberPad;
                textTf.placeholder = ary1[i];
                textTf.tag = 70000 + i;
                textTf.delegate = self;
                [textTf setValue:[UIFont boldSystemFontOfSize:15*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
                [view addSubview:textTf];
            }
            
            self.GetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            _GetBtn.frame = WDH_CGRectMake1(180, 85, 40, 20);
            _GetBtn.layer.cornerRadius = 5;
            _GetBtn.layer.masksToBounds = YES;
            _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
            [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
            [_GetBtn setTitle:@"获取" forState:UIControlStateNormal];
            _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
            [_GetBtn addTarget:self action:@selector(handleGet) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_GetBtn];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 113, 213, 12)];
            textLabel.text = @"密码是6-16位的数字, 字母组合";
            textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1];
            textLabel.font = [UIFont systemFontOfSize:10*kScreenHeight2];
            [view addSubview:textLabel];
            
            UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 130, 60, 30);
            buyBtn.layer.cornerRadius = 5;
            buyBtn.layer.masksToBounds = YES;
            buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
            buyBtn.tag = 30003;
            [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
            [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buyBtn addTarget:self action:@selector(handleChange:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:buyBtn];
            UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
            Btn.frame = WDH_CGRectMake1(210.5, 7.5, 15, 15);
            [Btn setBackgroundImage:[UIImage imageNamed:@"修改密码关闭"] forState:UIControlStateNormal];
            [Btn addTarget:self action:@selector(handleOff10) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:Btn];
        } else {
            UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 90, 233, 165)];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 10;
            view.layer.masksToBounds = YES;
            view.tag = 20001;
            [self.view addSubview:view];
            
            NSArray * ary = @[@"新密码", @"确认新密码", @"验证码"];
            NSArray * ary1 = @[@"请输入", @"请输入", @"请输入"];
            for (int i = 0; i < 3; i++) {
                UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 50 + 30 * i, 213, 1)];
                lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
                [view addSubview:lineLabel];
                
                UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 20 + 30 * i, 80, 29)];
                Label.text = ary[i];
                Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
                Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
                [view addSubview:Label];
                
                UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(100, 23 + 30 * i, 120, 26)];
                textTf.keyboardType = UIKeyboardTypeNumberPad;
                textTf.placeholder = ary1[i];
                textTf.delegate = self;
                textTf.tag = 70000 + i;
                [textTf setValue:[UIFont boldSystemFontOfSize:15*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
                [view addSubview:textTf];
            }
            
            self.GetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            _GetBtn.frame = WDH_CGRectMake1(180, 85, 40, 20);
            _GetBtn.layer.cornerRadius = 5;
            _GetBtn.layer.masksToBounds = YES;
            _GetBtn.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
            [_GetBtn setTitleColor:[UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1] forState:UIControlStateNormal];
            [_GetBtn setTitle:@"获取" forState:UIControlStateNormal];
            _GetBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
            [_GetBtn addTarget:self action:@selector(handleGet) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_GetBtn];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 113, 213, 12)];
            textLabel.text = @"密码是6-16位的数字, 字母组合";
            textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1];
            textLabel.font = [UIFont systemFontOfSize:10*kScreenHeight2];
            [view addSubview:textLabel];
            
            UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 130, 60, 30);
            buyBtn.layer.cornerRadius = 5;
            buyBtn.layer.masksToBounds = YES;
            buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
            buyBtn.tag = 30002;
            [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
            [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buyBtn addTarget:self action:@selector(handleChange:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:buyBtn];
            UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
            Btn.frame = WDH_CGRectMake1(210.5, 7.5, 15, 15);
            [Btn setBackgroundImage:[UIImage imageNamed:@"修改密码关闭"] forState:UIControlStateNormal];
            [Btn addTarget:self action:@selector(handleOff10) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:Btn];
        }
    }
}

//获取验证码
- (void) handleGet1
{
    _GetBtn.enabled = NO;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:GGLYZM, _InfoDic[@"mobile"], @"2"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

//获取验证码
- (void) handleGet
{
    _GetBtn.enabled = NO;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:GGLYZM, _InfoDic[@"mobile"], @"3"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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


- (void) handleChange:(UIButton *)sender
{
    if (sender.tag == 30001) {
        //修改登录
        [self requestDLMM];
    } else if (sender.tag == 30002) {
        [self requestZFMM:@"1"];
    } else if (sender.tag == 30003) {
        [self requestZFMM:@"0"];
    }
}

- (void) handleOff10 {
    _time = 60;
    [timer invalidate];
    [_GetBtn removeFromSuperview];
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:20001] removeFromSuperview];
}


- (void) handleBankCard:(NSString *)str
{
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view  addSubview:_PickVC];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 60, 233, 225)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 20002;
    [self.view addSubview:view];
    
    NSArray * ary = @[@"持卡人", @"卡号", @"银行", @"支行"];
    NSArray * ary1 = @[@"姓名", @"银行卡号", @"银行名称", @"银行支行"];
    for (int i = 0; i < 5; i++) {
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 50 + 30 * i, 213, 1)];
        lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
        [view addSubview:lineLabel];
        
        if (i < 4) {
            UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 20 + 30 * i, 80, 29)];
            Label.text = ary[i];
            Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
            Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
            [view addSubview:Label];
            
            UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(70, 23 + 30 * i, 140, 26)];
            if (i == 1) {
                textTf.keyboardType = UIKeyboardTypeNumberPad;
            }
            textTf.delegate = self;
            textTf.placeholder = ary1[i];
            textTf.tag = 80000 + i;
            [textTf setValue:[UIFont boldSystemFontOfSize:15*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
            [view addSubview:textTf];
        } else if (i == 4) {
            UILabel * Label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 20 + 30 * i, 100, 29)];
            Label.text = @"支付密码";
            Label.textColor = [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1];
            Label.font = [UIFont systemFontOfSize:15*kScreenHeight2];
            [view addSubview:Label];
            
            UITextField * textTf = [[UITextField alloc] initWithFrame:WDH_CGRectMake1(90, 23 + 30 * i, 140, 26)];
            textTf.keyboardType = UIKeyboardTypeNumberPad;
            textTf.placeholder = @"支付密码";
            textTf.tag = 80000 + i;
            textTf.delegate = self;
            [textTf setValue:[UIFont boldSystemFontOfSize:15*kScreenHeight2] forKeyPath:@"_placeholderLabel.font"];
            [view addSubview:textTf];
        }
    }
    
    if ([str isEqualToString:@"0"]) {
        UITextField * tf = [self.view viewWithTag:80000];
        UITextField * tf1 = [self.view viewWithTag:80001];
        UITextField * tf2 = [self.view viewWithTag:80002];
        UITextField * tf3 = [self.view viewWithTag:80003];
        
        tf.text = [NSString stringWithFormat:@"%@", _bankDic[@"name"]];
        tf1.text = [NSString stringWithFormat:@"%@", _bankDic[@"cardNo"]];
        tf2.text = [NSString stringWithFormat:@"%@", _bankDic[@"bank"]];
        tf3.text = [NSString stringWithFormat:@"%@", _bankDic[@"subbranch"]];
    }
     
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10, 173, 213, 12)];
    textLabel.text = @"为保证资金安全, 只能绑定认证本人银行卡";
    textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1];
    textLabel.font = [UIFont systemFontOfSize:10*kScreenHeight2];
    [view addSubview:textLabel];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 50) / 2, 190, 60, 30);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    if ([str isEqualToString:@"0"]) {
        buyBtn.tag = 25001;
    } else {
        buyBtn.tag = 25002;
    }
    [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleOk:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];

    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 7.5, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"修改密码关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff11) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    
}

- (void) handleOk:(UIButton *)sender {
    if (sender.tag == 25002) {
        [self requestAddBank];
    } else {
        [self requestupdBank];
    }
}

- (void) handleOff11 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:20002] removeFromSuperview];
}

//更新银行卡
- (void)requestupdBank
{
    UITextField * tf = [self.view viewWithTag:80000];
    UITextField * tf1 = [self.view viewWithTag:80001];
    UITextField * tf2 = [self.view viewWithTag:80002];
    UITextField * tf3 = [self.view viewWithTag:80003];
    UITextField * tf4 = [self.view viewWithTag:80004];
    NSString *UrlStr = [[NSString stringWithFormat:GGLupdBank, tf.text, tf1.text, tf3.text, tf4.text, @"", tf2.text, [NSString stringWithFormat:@"%@", _bankDic[@"id"]]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [WDHRequest requestTypePostWith:UrlStr completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"新航卡信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self handleOff11];
            Alert_Show(@"绑定成功")
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

//添加银行卡
- (void)requestAddBank
{
    UITextField * tf = [self.view viewWithTag:80000];
    UITextField * tf1 = [self.view viewWithTag:80001];
    UITextField * tf2 = [self.view viewWithTag:80002];
    UITextField * tf3 = [self.view viewWithTag:80003];
    UITextField * tf4 = [self.view viewWithTag:80004];
    NSString *UrlStr = [[NSString stringWithFormat:GGLaddBank, tf.text, tf1.text, tf3.text, tf4.text, @"", tf2.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [WDHRequest requestTypePostWith:UrlStr completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"添加银行卡信息:%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            [self handleOff11];
            Alert_Show(@"绑定成功")
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
    } WithError:^(NSString *errorStr) {
        //处理token失效
        if ([errorStr isEqualToString:@"1"]) {
            [self LoginRequest];
        }
    }];
}

#pragma mark ----------- 游戏规则 -------------
-(void)gameRule{
    
    UIView *alertView = [[UIView alloc]initWithFrame:self.view.bounds];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.tag = 123321456;
    [self.view addSubview:alertView];
    
    NSArray * ary = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg", @"11.jpg"];
    UIScrollView * scroller = [[UIScrollView alloc] initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    scroller.backgroundColor = [UIColor whiteColor];
    scroller.contentSize = CGSizeMake((667*kScreenWidth2) * 11, 0);
    scroller.delegate = self;
    scroller.bounces = NO;
    scroller.tag = 786;
    scroller.alwaysBounceVertical = NO;
    scroller.showsHorizontalScrollIndicator = NO;
    scroller.pagingEnabled = YES;
    [alertView addSubview:scroller];
    
    for (int i = 0; i < 11; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(667 * i, 0, 667, 375)];
        imageView.image = [UIImage imageNamed:ary[i]];
        [scroller addSubview:imageView];
    }
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.tag = 98765;
    leftBtn.frame = WDH_CGRectMake1(20, 167.5, 25, 40);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ShiYongZuo) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.tag = 98766;
    rightBtn.frame = WDH_CGRectMake1(622, 167.5, 25, 40);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(ShiYongYou) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:rightBtn];

    
    //弹窗取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = WDH_CGRectMake1(617, 20, 30, 30);
    [alertView addSubview:cancelBtn];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"宝典关闭图标"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBrnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)ShiYongZuo {
    UIScrollView * mainScroll = [self.view viewWithTag:786];
    if (mainScroll.contentOffset.x > 0) {
        float a = mainScroll.contentOffset.x / (667.0*kScreenWidth2);
        NSString * str = [NSString stringWithFormat:@"%f", a];
        NSArray * ary = [str componentsSeparatedByString:@"."];
        if ([[ary lastObject] intValue] == 0) {
            [mainScroll setContentOffset:CGPointMake(mainScroll.contentOffset.x - (667.0*kScreenWidth2), 0) animated:YES];
        }
    }
}

- (void)ShiYongYou {
    UIScrollView * mainScroll = [self.view viewWithTag:786];
    if (mainScroll.contentOffset.x < mainScroll.contentSize.width - (667.0*kScreenWidth2)) {
        float a = mainScroll.contentOffset.x / (667.0*kScreenWidth2);
        NSString * str = [NSString stringWithFormat:@"%f", a];
        NSArray * ary = [str componentsSeparatedByString:@"."];
        if ([[ary lastObject] intValue] == 0) {
            [mainScroll setContentOffset:CGPointMake(mainScroll.contentOffset.x + (667.0*kScreenWidth2), 0) animated:YES];
        }
    }
}


-(void)cancelBrnClick:(UIButton *)sender{
    //点击取消按钮   关闭游戏规则弹窗
    UIView *alertView = [self.view viewWithTag:123321456];
    [alertView removeFromSuperview];
}

//抢种子
-(void)qiangBtnClick{
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:10001] removeFromSuperview];
    
    UILabel *label1 = [self.view viewWithTag:10102020];
    UILabel *label2 = [self.view viewWithTag:10102021];
    UIButton *btn = [self.view viewWithTag:10102022];
    [label1 removeFromSuperview];
    [label2 removeFromSuperview];
    [btn removeFromSuperview];
    
    [WDHRequest requestTypePostWith:[NSString stringWithFormat:robSemenUrl] completeWithBlock:^(NSDictionary *responseObject) {
        NSLog(@"抢种子---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            Alert_Show(@"种子购买成功")
            [self requestUserInfo];
            [self requestCXTDLB];
        } else {
            NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
            Alert_Show(msg);
        }
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
    //, [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"]
    [manager POST:[NSString stringWithFormat:GGL@"/oauth/token?grant_type=refresh_token&refresh_token=464936c1-a8a0-4a99-b2ca-1cc7f930c4dc"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        LoginVC * loginVC = [[LoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }];
}

//将字符串转成NSDate类型
- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark ----------添加偷取功能
//获取可以偷取土地列表
-(void)requestStealSeedList{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString * date = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSLog(@"当前时间:%@", dateTime);
    NSLog(@"取出时间:%@", date);
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"date"]) {
        [self.StealAry removeAllObjects];
        [WDHRequest requestAllListWith:GGL@"/land/steal/list" completeWithBlock:^(NSDictionary *responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                NSArray * ary = responseObject[@"data"];
                for (NSDictionary * dic in ary) {
                    [self.StealAry addObject:dic];
                }
                [self stealSeedWithData:_StealAry];
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else if ([dateTime isEqualToString:date]) {
        [self.StealAry removeAllObjects];
        [WDHRequest requestAllListWith:GGL@"/land/steal/list" completeWithBlock:^(NSDictionary *responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                NSArray * ary = responseObject[@"data"];
                for (NSDictionary * dic in ary) {
                    [self.StealAry addObject:dic];
                }
                [self stealSeedWithData:_StealAry];
            }
        } WithError:^(NSString *errorStr) {
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    } else {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"date1"]) {
            Alert_Show(@"今天已经不能偷了哟, 明天再来吧");
        } else {
            NSString * date = [[NSUserDefaults standardUserDefaults] objectForKey:@"date1"];
            Alert_Show(date);
        }
        
    }
}

- (void)stealSeedWithData:(NSArray *)dic
{
    [self handleOff22];
    NSLog(@"偷取列表内容:%@", dic);
    _PickVC = [[UIView alloc]initWithFrame:WDH_CGRectMake1(0, 0, 667, 375)];
    _PickVC.backgroundColor = [UIColor blackColor];
    _PickVC.alpha = 0.5;
    _PickVC.userInteractionEnabled = YES;
    [self.view addSubview:_PickVC];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOff22)];
    [_PickVC addGestureRecognizer:tap];
    
    UIView * view = [[UIView alloc] initWithFrame:WDH_CGRectMake1(208.5, 120, 233, 155)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.tag = 1000122;
    [self.view addSubview:view];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(0, 0, 233, 30)];
    textLabel.backgroundColor = [UIColor colorWithRed:114 / 255.0 green:162 / 255.0 blue:57 / 255.0 alpha:1];
    textLabel.text = @"偷取土地";
    textLabel.textAlignment = 1;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:17*kScreenHeight2];
    [view addSubview:textLabel];
    
    self.scroll = [[UIScrollView alloc]initWithFrame:WDH_CGRectMake1(0, 30, 233, 100)];
    _scroll.showsVerticalScrollIndicator = FALSE;
    _scroll.showsHorizontalScrollIndicator = FALSE;
    _scroll.tag = 1999;
    _scroll.delegate = self;
    [view addSubview:_scroll];
    _scroll.contentSize = CGSizeMake((10 + (60 + 5) * [dic count]) * kScreenWidth2, 0);
    if (_TouQu > 0) {
        [_scroll setContentOffset:CGPointMake(_TouQu, 0) animated:YES];
    }
    
    for (int i = 0; i < [dic count]; i++) {
        UIView * backView = [[UIView alloc] initWithFrame:WDH_CGRectMake1(10 + i * (60 + 5), 5, 60, 80)];
        backView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:254 / 255.0 blue:220 / 255.0 alpha:1];
        [_scroll addSubview:backView];
        
        NSDictionary * dataDic = dic[i];
        UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = WDH_CGRectMake1(15 + i * (60 + 5), 10, 50, 50);
        Btn.tag = [dataDic[@"landId"] intValue];
        [Btn setBackgroundImage:[UIImage imageNamed:@"tudi"] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(requestStealSeed:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:Btn];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:WDH_CGRectMake1(50 + i * (60 + 5), 45, 25, 20)];
        imageView.image = [UIImage imageNamed:@"偷取手势"];
        [_scroll addSubview:imageView];
        
        if ([dataDic[@"stealType"] intValue] == 1) {
            imageView.hidden = YES;
        } else {
            imageView.hidden = NO;
        }
        
        UILabel * label = [[UILabel alloc] initWithFrame:WDH_CGRectMake1(10 + i * (60 + 5), 65, 60, 20)];
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:10*kScreenHeight2];
        label.textColor = [UIColor colorWithRed:120 / 255.0 green:160 / 255.0 blue:55 / 255.0 alpha:1];
        label.text = [NSString stringWithFormat:@"%@", dataDic[@"nickname"]];
        [_scroll addSubview:label];
    }
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.frame = WDH_CGRectMake1((233 - 100) / 2, 125, 100, 20);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.backgroundColor = [UIColor clearColor];
    buyBtn.tag = 88888;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenHeight2];
    [buyBtn setTitle:@"点击换一批" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor colorWithRed:231 / 255.0 green:164 / 255.0 blue:60 / 255.0 alpha:1]forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(requestStealSeedList) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buyBtn];
    
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = WDH_CGRectMake1(210.5, 6, 15, 15);
    [Btn setBackgroundImage:[UIImage imageNamed:@"弹窗关闭"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(handleOff22) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
}


- (void) handleOff22 {
    [_PickVC removeFromSuperview];
    [[self.view viewWithTag:1000122] removeFromSuperview];
    
}


-(void)requestStealSeed:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSDictionary * dataDic;
    for (NSDictionary * dic in _StealAry) {
        if ([dic[@"landId"] intValue] == sender.tag) {
            dataDic = [NSDictionary dictionaryWithDictionary:dic];
        }
    }
    
    if ([dataDic[@"stealType"] intValue] == 1) {
        sender.userInteractionEnabled = YES;
        Alert_Show(@"这块地被偷太多啦，主人要发怒了，别偷啦，快跑吧");
    } else {
        [WDHRequest requestTypePostWith:[NSString stringWithFormat:@"%@/semen/steal?landId=%ld",GGL,sender.tag] completeWithBlock:^(NSDictionary *responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                Alert_Show(@"偷取成功");
            } else if ([responseObject[@"code"] intValue] == 845) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                Alert_Show(@"你已经偷过这块地啦，换一块吧");
            } else if ([responseObject[@"code"] intValue] == 843) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                Alert_Show(@"这块地被偷太多啦，留他余种，给他发展机会，下次再来吧！");
            } else if ([responseObject[@"code"] intValue] == 844) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                Alert_Show(@"今天偷得太多啦，告诉你个小秘密，种地越多偷的越广哦")
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
                [[NSUserDefaults standardUserDefaults] setObject:@"今天偷得太多啦，告诉你个小秘密，种地越多偷的越广哦" forKey:@"date1"];
            } else if ([responseObject[@"code"] intValue] == 852) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                Alert_Show(@"你分享的伙伴太少了，偷东西也要团队合作，赶紧去分享吧！")
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateTime = [formatter stringFromDate:[NSDate date]];
                NSString * date = [self GetTomorrowDay:[self dateFromString:dateTime]];
                NSLog(@"存入时间:%@", date);
                [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
                [[NSUserDefaults standardUserDefaults] setObject:@"你分享的伙伴太少了，偷东西也要团队合作，赶紧去分享吧！" forKey:@"date1"];
            } else if ([responseObject[@"code"] intValue] == 868) {
                [self handleOff22];
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                Alert_Show(@"果果已收到您的圣旨，稍后可去粮仓查看是否有惊喜");
            } else if ([responseObject[@"code"] intValue] == 869) {
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                NSString * str = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                Alert_Show(str);
            } else {
                sender.userInteractionEnabled = YES;
                int i = 0;
                for (NSDictionary * dic in _StealAry) {
                    if ([dic[@"landId"] intValue] == sender.tag) {
                        break;
                    }
                    i++;
                }
                NSDictionary * dic = _StealAry[i];
                NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                dic1[@"stealType"] = @"1";
                NSDictionary * dic2 = [NSDictionary dictionaryWithDictionary:dic1];
                NSLog(@"偷取字典2:%@", dic2);
                [_StealAry removeObjectAtIndex:i];
                [_StealAry insertObject:dic2 atIndex:i];
                [self stealSeedWithData:_StealAry];
                NSString * msg = [ErrorCode initWithErrorCode:[responseObject[@"code"] intValue]];
                Alert_Show(msg);
            }
        } WithError:^(NSString *errorStr) {
            sender.userInteractionEnabled = YES;
            //处理token失效
            if ([errorStr isEqualToString:@"1"]) {
                [self LoginRequest];
            }
        }];
    }
}


@end
