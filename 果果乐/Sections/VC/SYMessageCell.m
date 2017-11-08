//
//  SYMessageCell.m
//  MainPage
//
//  Created by 云盛科技 on 2017/1/13.
//  Copyright © 2017年 云盛科技. All rights reserved.
//
#define kScreenWidth1       ([UIScreen mainScreen].bounds.size.width / 375)     //适配宽度
#define kScreenHeight1      ([UIScreen mainScreen].bounds.size.height / 667)    //适配高度
#import "SYMessageCell.h"
#import "SYMessage.h"

@interface SYMessageCell()

/** 消息View */
@property (nonatomic, strong) UIView *messageView;
/** 消息内容 */
@property (nonatomic, strong) UILabel *messageContent;
/** 消息时间 */
@property (nonatomic, strong) UILabel *messageTime;


@end

@implementation SYMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"messageCell";
    SYMessageCell *shopCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (shopCell == nil) {
        shopCell = [[SYMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return shopCell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){

        [self addSubview:self.messageContent];
        [self addSubview:self.messageTime];

    }
    return self;
}

-(UIView *)messageView{
    if (!_messageView) {
        _messageView = [[UIView alloc]init];
        _messageView.backgroundColor = [UIColor whiteColor];
        _messageView.layer.borderWidth = 1;
        _messageView.layer.borderColor = [[UIColor grayColor]CGColor];
        [_messageView addSubview:self.messageContent];
        [_messageView addSubview:self.messageTime];
    }
    return _messageView;
}
-(UILabel *)messageContent{
    if (!_messageContent) {
        _messageContent = [[UILabel alloc]init];
        _messageContent.numberOfLines = 0;
        _messageContent.font = [UIFont systemFontOfSize:14];
    }
    return _messageContent;
}
-(UILabel *)messageTime{
    if (!_messageTime) {
        _messageTime = [[UILabel alloc]init];
        _messageTime.font = [UIFont systemFontOfSize:14];
    }
    return _messageTime;
}
- (void)setMessageModel:(SYMessage *)messageModel{
    NSLog(@"传过来的消息----%@",messageModel);
    _messageModel = messageModel;
    
    [self addSubview:self.messageView];
    self.backgroundColor = [UIColor backGray];
    
    
    CGRect rect = [messageModel.messageContent boundingRectWithSize:CGSizeMake(627, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];

    
    self.messageView.frame = CGRectMake(10, 5, 647, rect.size.height + 40);
    self.messageContent.frame = CGRectMake(10, 10, 627, rect.size.height);
    self.messageTime.frame = CGRectMake( 500, rect.size.height + 20, 150, 20);
    
    self.messageTime.text = messageModel.messageTime;
    
    _messageContent.textColor = [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0];
    self.messageContent.text = messageModel.messageContent;
    NSLog(@"传过来的内容-----%@",messageModel.messageContent);

}

@end
