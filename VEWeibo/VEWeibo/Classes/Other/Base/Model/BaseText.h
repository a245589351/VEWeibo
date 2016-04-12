//
//  BaseText.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface BaseText : NSObject

@property (nonatomic, assign) long long statusId;// 微博id
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;

- (id)initWithDict:(NSDictionary *)dict;

@end
