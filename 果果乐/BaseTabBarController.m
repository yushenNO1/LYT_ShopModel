//
//  BaseTabBarController.m
//  HuanLeLvTuApp
//
//  Created by zjw on 15/10/12.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "BaseTabBarController.h"
#import "LYTLifeTableVC.h"
#import "LYTNav.h"
#import "ZjwCategorySearchVC.h"
#import "ShopCartVC.h"
#import "LYTGGLMineVC.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>

@property(nonatomic,copy)NSString *badge;

@end

@implementation BaseTabBarController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    
    //返回按钮的箭头颜色
    
//    [navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置返回样式图片
    
    UIImage *image = [UIImage imageNamed:@"返回"];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationBar.backIndicatorImage = image;
    
    navigationBar.backIndicatorTransitionMaskImage = image;
    
//    UIImage *backButtonImage = [[UIImage imageNamed:@"返回"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1]];//设置
    self.tabBar.tintColor = [UIColor colorWithRed:250 / 255.0 green:47 / 255.0 blue:91 / 255.0 alpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self configureViewControllers];
//    [self configureNavigationAndTabBar];
  
    self.tabBar.clipsToBounds = YES;//取消顶部灰线

//    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1]];//设置Tabbar背景色
//    [UITabBar appearance].translucent = NO;//取消毛玻璃状态
//    self.tabBar.tintColor = [UIColor colorWithRed:250 / 255.0 green:47 / 255.0 blue:91 / 255.0 alpha:1];
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
//    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    la.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.8];
//    [backView addSubview:la];
//    backView.backgroundColor = [UIColor whiteColor];
//    [self.tabBar insertSubview:backView atIndex:0];
//    self.tabBar.opaque = YES;
    
//    [self.tabBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.99 alpha:1.00] size:CGSizeMake(self.view.frame.size.width, .5)]];
//    [self.tabBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:0.87 green:0.88 blue:0.90 alpha:1.00] size:CGSizeMake(self.view.frame.size.width, .5)]];
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark
#pragma mark ------------------ 配置导航条/tabBar/所管理的视图控制器 ----------------

- (void)configureViewControllers{
   //首页
    LYTLifeTableVC * MainPageVC = [[LYTLifeTableVC alloc] init];
    LYTNav * MainPageNA = [[LYTNav alloc] initWithRootViewController:MainPageVC];
    MainPageVC.title = @"首页";
    MainPageNA.tabBarItem.image = [[UIImage imageNamed:@"index_shopping_hui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MainPageNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"inde_shopping_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //分类
    ZjwCategorySearchVC * LocalLife = [[ZjwCategorySearchVC alloc]init];
    LYTNav * LocalLifeNA = [[LYTNav alloc] initWithRootViewController:LocalLife];
    LocalLife.title = @"分类";
    LocalLifeNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"index_local_red@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LocalLifeNA.tabBarItem.image = [[UIImage imageNamed:@"分类1@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LocalLifeNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"搜索选中1@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
 
    //购物车
    ShopCartVC * ShopCart = [[ShopCartVC alloc] init];
    LYTNav * ShopCartNA = [[LYTNav alloc] initWithRootViewController:ShopCart];
    ShopCart.title = @"购物车";
    ShopCartNA.tabBarItem.image = [[UIImage imageNamed:@"index_shopcar_hui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ShopCartNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"index_shopcar_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//
    //我的
    LYTGGLMineVC * mineVC = [[LYTGGLMineVC alloc] init];
    LYTNav * mineNA = [[LYTNav alloc] initWithRootViewController:mineVC];
    mineVC.title = @"我的";
    mineNA.tabBarItem.image = [[UIImage imageNamed:@"index_my_hui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"index_my_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    


    self.viewControllers = @[MainPageNA,LocalLifeNA,ShopCartNA,mineNA];
}
/*
 **
 **yu
 **时间:
 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if (tabBarController.selectedIndex == 0) {   //购物车
        UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
        _statusBarView.backgroundColor=[UIColor clearColor];
        _statusBarView.alpha = 1;
        self.navigationController.navigationBar.alpha = 0;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        UIView *_statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];;
        _statusBarView.backgroundColor=[UIColor whiteColor];
        _statusBarView.alpha = 1;
        self.navigationController.navigationBar.alpha = 1;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    if (tabBarController.selectedIndex == 2) {   //广告红包

    }
    if (tabBarController.selectedIndex == 4) {   //我的

    }
}

@end
