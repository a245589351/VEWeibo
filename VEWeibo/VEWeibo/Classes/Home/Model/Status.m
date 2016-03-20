//
//  Status.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status

- (id)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        self.text = dict[@"text"];
        self.user = [[User alloc] initWithDict:dict[@"user"]];
    }
    return self;
}

@end
