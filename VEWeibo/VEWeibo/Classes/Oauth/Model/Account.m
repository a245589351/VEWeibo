//
//  Account.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Account.h"

@implementation Account
#pragma mark 归档时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
