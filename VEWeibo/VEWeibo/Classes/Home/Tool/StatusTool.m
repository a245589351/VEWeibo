//
//  StatusTool.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "Weibocfg.h"
#import "AccountTool.h"
#import "Status.h"
#import "Comment.h"

@implementation StatusTool

+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"]    = @50;
    params[@"since_id"] = @(sinceId);
    params[@"max_id"]   = @(maxId);
    // 获取微博数据
    [HttpTool getWithPath:kHomeTimeline params:params success:^(id JSON) {
        if (success == nil) {
            return ;
        }
        NSMutableArray *statuses = [NSMutableArray array];
        
        NSArray *array = JSON[@"statuses"];
        for (NSDictionary *dict in array) {
            Status *s = [[Status alloc] initWithDict:dict];
            [statuses addObject:s];
        }
        
        // 回调block
        success(statuses);
    } failure:^(NSError *error) {
        if (failure == nil) {
            return ;
        }
        failure(error);
    }];
}

+ (void)CommentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"]       = @(statusId);
    params[@"since_id"] = @(sinceId);
    params[@"max_id"]   = @(maxId);
    params[@"count"]   = @5;
    // 获取微博数据
    [HttpTool getWithPath:kCommentsShow params:params success:^(id JSON) {
        if (success == nil) {
            return ;
        }
        
        // 微博评论(JSON数组)
        NSArray *array = JSON[@"comments"];
        
        NSMutableArray *comments = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Comment *c = [[Comment alloc] initWithDict:dict];
            [comments addObject:c];
        }
        
        success(comments, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (failure == nil) {
            return ;
        }
        failure(error);
    }];
}

+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"]       = @(statusId);
    params[@"since_id"] = @(sinceId);
    params[@"max_id"]   = @(maxId);
    // 获取微博数据
    [HttpTool getWithPath:kStatusesRepostTimeline params:params success:^(id JSON) {
        if (success == nil) {
            return ;
        }
        
        // 转发微博(JSON数组)
        NSArray *array = JSON[@"reposts"];
        
        NSMutableArray *reposts = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Status *r = [[Status alloc] initWithDict:dict];
            [reposts addObject:r];
        }
        
        success(reposts, [JSON[@"total_number"] intValue]);
    } failure:^(NSError *error) {
        if (failure == nil) {
            return ;
        }
        failure(error);
    }];
}

@end
