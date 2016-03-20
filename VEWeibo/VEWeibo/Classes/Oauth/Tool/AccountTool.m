//
//  AccountTool.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AccountTool.h"

// account的文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

single_implementation(AccountTool)

- (id)init {
    if (self == [super init]) {
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccount:(Account *)account {
    _currentAccount = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}
@end
