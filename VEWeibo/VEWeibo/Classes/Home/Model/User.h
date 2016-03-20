//
//  User.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//  用户

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *screenName;

- (id)initWithDict:(NSDictionary *)dict;

@end
