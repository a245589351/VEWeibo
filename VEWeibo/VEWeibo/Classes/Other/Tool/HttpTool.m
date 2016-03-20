//
//  HttpTool.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "AccountTool.h"

@implementation HttpTool

+ (void)requestWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(RequestMethod)method {
    // 1.初始化请求主体
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.获取所有参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams setDictionary:params];
    }
    
    // 3.如果access_token已经存在，则自动拼接
    NSString *token = [AccountTool sharedAccountTool].currentAccount.accessToken;
    if (token) {
        allParams[@"access_token"] = token;
    }    // 4.发送请求
    if (method == kRequestMethodGet) {
        [manager GET:path parameters:allParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success == nil) {
                return ;
            }
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(JSON);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure == nil) {
                return ;
            }
            failure(error);
        }];
    } else if (method == kRequestMethodPost) {
        [manager POST:path parameters:allParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(JSON);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

+ (void)getWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path params:params success:success failure:failure method:kRequestMethodGet];
}

+ (void)postWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path params:params success:success failure:failure method:kRequestMethodPost];
}
@end
