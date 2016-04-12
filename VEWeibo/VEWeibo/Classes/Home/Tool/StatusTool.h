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

typedef void (^CommentsSuccessBlock)(NSArray *comments, int totalNumber, long long nextCursor);
typedef void (^CommentsFailureBlock)(NSError *error);

typedef void (^RepostsSuccessBlock)(NSArray *reposts, int totalNumber);
typedef void (^RepostsFailureBlock)(NSError *error);

@interface StatusTool : NSObject

// 抓取微博数据
+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;

// 抓取某条微博的评论数据
+ (void)CommentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure;

// 抓取某条微博的转发数据
+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure;

@end
