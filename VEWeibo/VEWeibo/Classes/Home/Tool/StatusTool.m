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

@implementation StatusTool

+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"]    = @5;
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

@end
