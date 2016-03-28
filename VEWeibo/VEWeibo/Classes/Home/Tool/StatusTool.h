//
//  StatusTool.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

// statuses都是微博对象
typedef void (^StatusSuccessBlock)(NSArray *statuses);
typedef void (^StatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject

+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;

@end
