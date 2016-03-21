//
//  User.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        self.screenName      = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        self.verified        = [dict[@"verified"] boolValue];
        self.verifiedType    = [dict[@"verified_type"] intValue];
        self.mbrank          = [dict[@"mbrank"] boolValue];
        self.mbtype          = [dict[@"mbtype"] intValue];
    }
    return self;
}

@end
