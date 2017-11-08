//
//  WSSAddressTableViewController.h
//  cccc
//
//  Created by 王松松 on 2017/1/17.
//  Copyright © 2017年 云盛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSSAddressTableViewController : UITableViewController
@property (nonatomic,copy) void (^content)(NSArray *titleArr,NSArray *idArr);


@end
