//
//  MessageController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题和背景
    self.title = @"消息";
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 发私信
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发私信" style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
