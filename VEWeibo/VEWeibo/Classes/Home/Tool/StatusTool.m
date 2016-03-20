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

+ (void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure {
    // 获取微博数据
    [HttpTool getWithPath:kHomeTimeline params:nil success:^(id JSON) {
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
