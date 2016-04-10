//
//  Comment.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment

- (id)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        self.text     = dict[@"text"];
        self.user     = [[User alloc] initWithDict:dict[@"user"]];
        self.createdAt      = dict[@"created_at"];
    }
    return self;
}

@end
