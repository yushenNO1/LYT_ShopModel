//
//  NetURL.h
//  YSApp
//
//  Created by 云盛科技 on 16/4/28.
//  Copyright © 2016年 云盛科技. All rights reserved.
//
#import <Foundation/Foundation.h>

#define Alert_show_pushRoot(str) UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:(UIAlertControllerStyleAlert)];UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {[self.navigationController popViewControllerAnimated:YES];}];[alertVC addAction:okAction];[self presentViewController:alertVC animated:YES completion:nil];


#define Alert_go_push(id,str) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {id *vc = [[id alloc]init];[self.navigationController pushViewController:vc animated:YES];}];UIAlertAction *dissAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];[alert addAction:goAction];[alert addAction:dissAction];[self presentViewController:alert animated:YES completion:nil];

#pragma mark          ---------- 接口 ----------
//忘记密码
#define GGLWJMM                GGL@"/user/updatePassNoAuth?mobile=%@&newPass=%@&sms=%@"

//验证码
#define GGLYZM                GGL@"/sms/code/send?mobile=%@&bizType=%@"

//登录  //
#define GGLDL                 GGL@"/oauth/token?grant_type=password&username=%@&password=%@"

//注册  //
#define GGLZC                 GGL@"/user/addUser?mobile=%@&referrer=%@&chekCode=%@&sms=%@"

//查询用户信息   //
#define GGLUserInfo           GGL@"/user/userInfo"

//用户种子信息   //
#define GGLSeedsInfo          GGL@"/semen/list"

//挂单    //
#define GGLGD                 GGL@"/picksemen/sale"

//挂单记录    //
#define GGLGDJL               GGL@"/picksemen/list?status=%@"

//种子商城
#define GGLZZSC               GGL@"/market/sementypes"

//查询用户土地列表   //
#define GGLCXTDLB             GGL@"/land/list"

//购买土地生成订单   //
#define GGLTDSCDD             GGL@"/payOrder/createBuyLand?num=%@"

//修改支付密码   //
#define GGLZFMM               GGL@"/user/updateAmPass?sms=%@&newPass=%@"

//修改登录密码   //
#define GGLDLMM               GGL@"/user/updatePass?sms=%@&newPass=%@"

//抢种子生成订单接口
#define GGLZZOrder            GGL@"/payOrder/createBuySemen?type=%@"

//种子订单支付接口
#define GGLZZZF               GGL@"/payOrder/pay?orderId=%@&payPassword=%@&tradeNo=%@"

//土地种植   //
#define GGLTDZZ               GGL@"/land/plant?landId=%@&semenTypeId=%@"

//添加银行卡   //
#define GGLaddBank            GGL@"/card/addCard?name=%@&cardNo=%@&subbranch=%@&ampass=%@&alipayNo=%@&bank=%@"

//查询银行卡   //
#define GGLbankInfo           GGL@"/card/cardInfo"

//查询银行卡   //
#define GGLbank               GGL@"/draw/check"

//更改银行卡    //
#define GGLupdBank            GGL@"/card/updateCard?name=%@&cardNo=%@&subbranch=%@&ampass=%@&alipayNo=%@&bank=%@&cardId=%@"

//提现    //
#define GGLTX                 GGL@"/draw/askFor?amount=%@&ampass=%@&cardType=%@"

//转账    //
#define GGLZZ                 GGL@"/user/transfer?amount=%@&ampass=%@&tranmobile=%@"
#define GGLZZZ                 GGL@"/user/transferSemen?amount=%@&ampass=%@&tranmobile=%@"

//账单   //
#define GGLZD                 GGL@"/billLong/listF?offset=%@"

//账单   //
#define GGLZDY                 GGL@"/billLong/listO?offset=%@"

//收账    //
#define GGLSZ                 GGL@"/billLong/list?offset=%@"

//查收账   //
#define GGLCSZ                GGL@"/billLong/open?billId=%@"

//采摘    //
#define GGLCZ                 GGL@"/land/cai?landId=%@"

//创建购买化肥订单接口
#define GGLBuyHF              GGL@"/payOrder/createBuyHaFei?landId=%@"

//施肥
#define GGLSF                 GGL@"/land/shi?landId=%@"

//累计收益
#define GGLSY                 GGL@"/user/shouyi"


//消息接口
#define messageUrl            GGL@"/article/list?offset=%d"

//抢种子
#define robSemenUrl           GGL@"/payOrder/robSemen"

//修改原有已付款未分配种子的订单信息
#define notZFUrl              GGL@"/payOrder/updateBuySemen?type=%d&upOrder=%@"

//粉丝
#define FenSi                 GGL@"/user/fensi"

//领狗
#define GetDog                GGL@"/user/getdog"

//弹窗接口
#define popOver               GGL@"/article/popup"


















#pragma mark -----------商城





#pragma mark-------------------java接口------------------------



