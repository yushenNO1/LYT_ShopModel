//
//  LYTNav.m
//  果果乐
//
//  Created by 云盛科技 on 2017/8/11.
//  Copyright © 2017年 Zjw. All rights reserved.
//

#import "LYTNav.h"
#import "LoginVC.h"
#import "MainVC.h"
#import "RegisterVC.h"
#import "LYTLifeTableVC.h"
@interface LYTNav ()

@end

@implementation LYTNav

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
 }



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController *vc =  self.topViewController;
    if([vc isKindOfClass:[LoginVC class]]|| [vc isKindOfClass:[MainVC class]]||[vc isKindOfClass:[RegisterVC class]]){//要横屏的界面
        return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate

{
    UIViewController *vc =  self.topViewController;
    if([vc isKindOfClass:[LoginVC class]] || [vc isKindOfClass:[MainVC class]] || [vc isKindOfClass:[RegisterVC class]]){//要横屏的界面
        return YES;
    }
    //横屏的上一个界面，要返回为YES,否则横屏返回的时候上一界面不能还原成竖屏
    if([vc isKindOfClass:[LYTLifeTableVC class]]){
        return YES;
    }
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *vc =  self.topViewController;
    if([vc isKindOfClass:[LoginVC class]]||[vc isKindOfClass:[RegisterVC class]]|| [vc isKindOfClass:[MainVC class]]){//要横屏的界面
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
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
