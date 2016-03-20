//
//  Status.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//  微博

#import <Foundation/Foundation.h>

@class User;
@interface Status : NSObject

@property (nonatomic, copy) NSString *text; // 微博内容
@property (nonatomic, strong) User *user;   // 用户对象

- (id)initWithDict:(NSDictionary *)dict;

@end
