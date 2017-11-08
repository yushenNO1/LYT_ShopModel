//
//  LYTSudokuView.m
//  addProject
//
//  Created by 云盛科技 on 2017/8/3.
//  Copyright © 2017年 神廷. All rights reserved.
//



#import "LYTSudokuView.h"

@interface LYTSudokuBtn : UIButton

@property(nonatomic,assign)BOOL LYTIsSelect;
@property(nonatomic,assign)NSInteger btnId;
@end
@implementation LYTSudokuBtn

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    LYTSudokuBtn *btn = [super buttonWithType:buttonType];
    if (btn) {
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [[UIColor redColor]CGColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.LYTIsSelect = NO;
    }
    return btn;
}

@end


@interface LYTSudokuView()

@property(nonatomic,retain)NSMutableArray *btnArr;

@end

@implementation LYTSudokuView

-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectType = LYTSudokuBtnSelectSingle;
        UILabel *line = [[UILabel alloc]initWithFrame:WDH_CGRectMake(0, 0, frame.size.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
    }
    return self;
}

-(void)configViewWithDataArr:(NSArray *)arr DataIdArr:(NSArray *)idArr title:(NSString *)titleString selectIndex:(NSInteger)index{
    
//    NSLog(@"configViewWithDataArr---%@  DataIdArr---%@ ",titleString,idArr);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:WDH_CGRectMake(10, 10, 200, 20)];
    titleLabel.text = titleString;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:titleLabel];
//    NSLog(@"self.selectId-----%ld",index);
    double location_X = 10 ;
    int location_Y = 40 ;
//    NSLog(@"_btnTitleArr---%@",arr);
    for (int i = 0; i < arr.count; i ++) {
        LYTSudokuBtn *btn = [LYTSudokuBtn buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.btnId = [idArr[i] integerValue];
        [btn addTarget: self action:@selector(LYTSudokuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArr addObject:btn];
        
        if (index == [idArr[i] integerValue]) {
            btn.backgroundColor = [UIColor greenColor];
        }else{
            btn.backgroundColor = [UIColor grayColor];
        }
        
        
        
        //计算位置
        CGRect strRect = [arr[i] boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        double XLoc = location_X + strRect.size.width + 20;
//        NSLog(@"XLoc---%f    self----%f",XLoc,self.frame.size.width);
        if (XLoc <= self.frame.size.width) {
            btn.frame = WDH_CGRectMake(location_X , location_Y, strRect.size.width + 10, 20);
            location_X = location_X + strRect.size.width + 20;
        }else{
            location_Y = location_Y + 30;
            location_X = 10;
            btn.frame = WDH_CGRectMake(location_X , location_Y, strRect.size.width + 10, 20);
            location_X = location_X + strRect.size.width + 20;
        }
        
//        NSLog(@"btn.frame-----%@",NSStringFromCGRect(btn.frame));
        [self addSubview:btn];

    }
//    NSLog(@"最后的高度---%d",location_Y + 30);
    self.viewHight = location_Y + 30;
}

-(void)LYTSudokuBtnClick:(LYTSudokuBtn *)sender{
    if ((self.selectType == LYTSudokuBtnSelectSingle)) {
        for (UIButton *btn in self.btnArr) {
            btn.backgroundColor = [UIColor grayColor];
            
        }
        sender.backgroundColor = [UIColor greenColor];
    }else{
        sender.LYTIsSelect = !sender.LYTIsSelect;
        if (sender.LYTIsSelect) {
            sender.backgroundColor = [UIColor greenColor];
        }else{
            sender.backgroundColor = [UIColor grayColor];
        }
    }
    self.selectId = sender.btnId;
    [self.delegate clickBtnIndex:self.selectIndex WithBtnInfo:sender.titleLabel.text changeView:self];
}

@end
