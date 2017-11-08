//
//  LYTBackView.m
//  addProject
//
//  Created by 云盛科技 on 2017/7/25.
//  Copyright © 2017年 神廷. All rights reserved.
//

#import "LYTBackView.h"
static LYTBackView *_instance;
static UIView *dissView;


@implementation LYTBackView

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
    dispatch_once(&onceToken,^{
        // 只执行1次的代码(这里面默认是线程安全的)
        _instance = [super allocWithZone:zone];
        
    });
    return _instance;
}
+ (instancetype)shareSingle
{
    return [[self alloc] initWithFrame:WDH_CGRectMake(0, 0, 375, 667)];
}

+(void)showWithView:(UIView *)topView{
    LYTBackView *view = [self shareSingle];
    
    view.backgroundColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:0.7];
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    [window addSubview:view];
    
    
    
    dissView = [[UIView alloc]initWithFrame:topView.frame];
    dissView.alpha = 1;
    [window addSubview:dissView];
    [dissView addSubview:topView];
    topView.frame = CGRectMake(0, 0, dissView.frame.size.width, dissView.frame.size.height);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissMiss)];
    [view addGestureRecognizer:tapGesture];

}


+(void)dissMiss{
    LYTBackView *view = [self shareSingle];
    [view removeFromSuperview];
    [dissView removeFromSuperview];
    [view.delegate touchBackView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
