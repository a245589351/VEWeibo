//
//  HttpTool.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

typedef enum {
    kRequestMethodGet,  // GET请求
    kRequestMethodPost  // POST请求
} RequestMethod;

@interface HttpTool : NSObject
+ (void)requestWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(RequestMethod)method;
+ (void)getWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
+ (void)postWithPath:(NSString *)path params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView;
@end
