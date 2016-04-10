//
//  Comment.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Comment : NSObject

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;

- (id)initWithDict:(NSDictionary *)dict;

@end
