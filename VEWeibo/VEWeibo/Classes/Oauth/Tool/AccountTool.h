//
//  AccountTool.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/19.
//  Copyright © 2016年 apple. All rights reserved.
//  管理账号信息

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"
@class Account;
@interface AccountTool : NSObject

single_interface(AccountTool)
// 获得当前帐号
@property (nonatomic, readonly) Account *currentAccount;

- (void)saveAccount:(Account *)account;
@end
