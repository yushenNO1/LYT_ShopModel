//
//  WSSModifyAddressViewController.m
//  cccc
//
//  Created by 王松松 on 2017/1/15.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
//添加常用的宏



#import "WSSAdressView.h"
#import "WSSAddressTableViewController.h"
#import "WSSModifyAddressViewController.h"

@interface WSSModifyAddressViewController ()
{
    UITextField *tf;
    UITextField *tf1;
    UITextField *tf3;
    UILabel *tf2Label;
}
@property(nonnull,copy)NSString *provinceStr;
@property(nonnull,copy)NSString *cityStr;
@property(nonnull,copy)NSString *districtStr;
@property(nonnull,retain)NSArray *cityNameArr;
@property(nonnull,retain)NSArray *cityIdArr;
@end

@implementation WSSModifyAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:33/255.0 green:35/255.0 blue:33/255.0 alpha:1];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.title = @"新增收货地址";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height+64)];
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor backGray];
    [self CreateUI];
}

- (void)CreateUI
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 100 * kScreenHeight1, 100 * kScreenWidth1, 40 * kScreenHeight1)];
    lab.text =@"收货人姓名";
    lab.textColor =[UIColor xiaobiaotiColor];
    lab.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
    [backView addSubview:lab];
    tf =[[UITextField alloc]initWithFrame:CGRectMake(140 * kScreenWidth1, 100 * kScreenHeight1, 170 * kScreenWidth1, 40 * kScreenHeight1)];
    tf.placeholder = @"请输入收货人姓名";
    tf.font =[UIFont systemFontOfSize:14 * kScreenHeight1];
    [backView addSubview:tf];
    UILabel *labLine =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 140 * kScreenHeight1, 290 * kScreenWidth1, 1 * kScreenHeight1)];
    labLine.backgroundColor =[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    labLine.alpha =0.5;
    [backView addSubview:labLine];
    
    
    UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 150 * kScreenHeight1, 100 * kScreenWidth1, 40 * kScreenHeight1)];
    lab1.text =@"手机号码";
    lab1.textColor =[UIColor xiaobiaotiColor];
    lab1.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
    [backView addSubview:lab1];
    tf1 =[[UITextField alloc]initWithFrame:CGRectMake(140 * kScreenWidth1, 150 * kScreenHeight1, 170 * kScreenWidth1, 40 * kScreenHeight1)];
    tf1.font =[UIFont systemFontOfSize:14 * kScreenHeight1];
    tf1.adjustsFontSizeToFitWidth =YES;
    tf1.placeholder = @"请输入手机号码";
    tf1.keyboardType = UIKeyboardTypePhonePad;
    [backView addSubview:tf1];
    UILabel *labLine1 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 190 * kScreenHeight1, 290 * kScreenWidth1, 1 * kScreenHeight1)];
    labLine1.backgroundColor =[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    labLine1.alpha =0.5;
    [backView addSubview:labLine1];
    
    
    UILabel *lab2 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 200 * kScreenHeight1, 100 * kScreenWidth1, 40 * kScreenHeight1)];
    lab2.text =@"所在地";
    lab2.textColor =[UIColor xiaobiaotiColor];
    lab2.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
    [backView addSubview:lab2];
    UIButton *tf2 =[UIButton buttonWithType:UIButtonTypeCustom];
    tf2.frame = CGRectMake(140 * kScreenWidth1, 200 * kScreenHeight1, 170 * kScreenWidth1, 40 * kScreenHeight1);
    [tf2 addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:tf2];
    tf2Label = [[UILabel alloc]initWithFrame:CGRectMake(140 * kScreenWidth1, 200 * kScreenHeight1, 200 * kScreenWidth1, 40 * kScreenHeight1)];
    tf2Label.font = [UIFont systemFontOfSize:14 * kScreenHeight1];
    [self.view addSubview:tf2Label];
    
    UILabel *labLine3 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 240 * kScreenHeight1, 290 * kScreenWidth1, 1 * kScreenHeight1)];
    labLine3.backgroundColor =[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    labLine3.alpha =0.5;
    [backView addSubview:labLine3];
    
    
    UILabel *lab3 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 250 * kScreenHeight1, 100 * kScreenWidth1, 40 * kScreenHeight1)];
    lab3.text =@"详细地址";
    lab3.textColor =[UIColor xiaobiaotiColor];
    lab3.font =[UIFont systemFontOfSize:15 * kScreenHeight1];
    [backView addSubview:lab3];
    tf3 =[[UITextField alloc]initWithFrame:CGRectMake(140 * kScreenWidth1, 250 * kScreenHeight1, 170 * kScreenWidth1, 40 * kScreenHeight1)];
    tf3.placeholder = @"请输入详细地址";
    tf3.font =[UIFont systemFontOfSize:14 * kScreenHeight1];
    tf3.adjustsFontSizeToFitWidth =YES;
    [backView addSubview:tf3];
    UILabel *labLine4 =[[UILabel alloc]initWithFrame:CGRectMake(40 * kScreenWidth1, 290 * kScreenHeight1, 290 * kScreenWidth1, 1 * kScreenHeight1)];
    labLine4.backgroundColor =[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    labLine4.alpha =0.5;
    [backView addSubview:labLine4];
    
    
    
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake((kScreenWidth - 150 * kScreenWidth1) / 2, 320 * kScreenHeight1, 150 * kScreenWidth1, 35 * kScreenHeight1);
    btn.backgroundColor =[UIColor anniuColor];
    btn.layer.masksToBounds =YES;
    btn.layer.cornerRadius =5 * kScreenHeight1;
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    if (self.model != nil) {
        tf.text = _model.name;
        tf1.text = _model.mobile;
        tf3.text = _model.addr;
        _provinceStr = _model.province;
        _cityStr = _model.city;
        _districtStr = _model.region;
        tf2Label.text = [NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.region];
//        [tf2 setTitle:[NSString stringWithFormat:@"%@",_model.full_address] forState:UIControlStateNormal];
    }
}

-(void)textFieldChange:(UIButton *)sender
{
    WSSAddressTableViewController *vc = [[WSSAddressTableViewController alloc]init];
    vc.content = ^(NSArray *titleArr,NSArray *idArr)
    {
        NSLog(@"titleArr---%@   idArr---%@" ,titleArr,idArr);
        self.cityNameArr = titleArr;
        self.cityIdArr = idArr;
        NSString *str = @"";
        for (NSString *str1 in titleArr) {
            str = [NSString stringWithFormat:@"%@%@",str,str1];
        }
        tf2Label.text = str;
        if (idArr.count >= 3) {
            _provinceStr = idArr[0];
            _cityStr = idArr[1];
            _districtStr = idArr[2];
        }
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnClick
{
    
    NSLog(@"保存...");
    if (_model != nil) {
        
        [self updataAdressWithAdressID:_model.addr_id];
    }else{
        if ([self isMobile:tf1.text]) {
            if (tf2Label.text.length > 0) {
                [self addAdress];
            }else{
                Alert_Show(@"请完善地址信息")
            }
            
        }else{
            Alert_Show(@"请检查手机号")
        }
        
    }
}
#pragma mark
#pragma mark -------- 请求 >>> 添加地址 -----------
-(void)addAdress
{
    NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str1 componentsSeparatedByString:@" "];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/member-address/add.do?token=%@&name=%@&mobile=%@&province=%@&province_id=%@&city=%@&city_id=%@&region=%@&region_id=%@&addr=%@&def_addr=1",tokenArr[1],tf.text,tf1.text,self.cityNameArr[0],self.cityIdArr[0],self.cityNameArr[1],self.cityIdArr[1],self.cityNameArr[2],self.cityIdArr[2],tf3.text];
    NSString *str = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
   
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"添加地址收货地址--%@",responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] intValue] == 1) {
            Alert_show_pushRoot(@"添加成功")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"添加地址收货地址232失败-");
        [SVProgressHUD dismiss];
    }];
}
#pragma mark
#pragma mark -------- 请求 >>> 更新地址列表 -----------
-(void)updataAdressWithAdressID:(NSString *)adressID
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSArray *tokenArr = [str1 componentsSeparatedByString:@" "];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:GGLSC@"/api/mobile/member-address/edit.do?token=%@&name=%@&mobile=%@&province=%@&province_id=%@&city=%@&city_id=%@&region=%@&region_id=%@&addr=%@&def_addr=1&addr_id=%@",tokenArr[1],tf.text,tf1.text,self.cityNameArr[0],self.cityIdArr[0],self.cityNameArr[1],self.cityIdArr[1],self.cityNameArr[2],self.cityIdArr[2],tf3.text,adressID];
    NSString *str = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"更新地址列表--%@",responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] intValue] == 1) {
            Alert_show_pushRoot(@"更新成功")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更新地址列表32失败-");
        [SVProgressHUD dismiss];
    }];
    
}
//验证手机号
- (BOOL) isMobile:(NSString *)mobileNumbel{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189,181(增加)
//     */
//    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,181(增加)
//     22         */
//    NSString * CT = @"^1((33|53|8[019])[0-9]|349|77[0-9])\\d{7}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if ([mobileNumbel length] == 0){
//        
//        Alert_Show(@"电话号码为空,请输入您的电话号码");
//        return NO;
//    }else if (([regextestmobile evaluateWithObject:mobileNumbel]
//               || [regextestcm evaluateWithObject:mobileNumbel]
//               || [regextestct evaluateWithObject:mobileNumbel]
//               || [regextestcu evaluateWithObject:mobileNumbel])) {
//        return YES;
//    }else{
//        
//        Alert_Show(@"请输入正确的手机号!");
//        return NO;
//    }
    
    NSString * all = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", all];
    if ([mobileNumbel length] == 0){
        Alert_Show(@"电话号码为空,请输入您的电话号码");
        return NO;
    }else if ([regextestct evaluateWithObject:mobileNumbel]) {
        return YES;
    }else{
        Alert_Show(@"请输入正确的手机号!");
        return NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
