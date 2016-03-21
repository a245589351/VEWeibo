//
//  User.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//  用户

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *screenName;      // 用户昵称
@property (nonatomic, copy) NSString *profileImageUrl; // 用户头像
@property (nonatomic, assign) BOOL verified;           // 是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic, assign) NSInteger verifiedType;  // 认证类型
@property (nonatomic, assign) NSInteger mbrank;        // 会员等级
@property (nonatomic, assign) NSInteger mbtype;        // 会员类型

- (id)initWithDict:(NSDictionary *)dict;

@end
