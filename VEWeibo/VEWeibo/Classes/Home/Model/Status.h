//
//  Status.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//  微博

#import <Foundation/Foundation.h>

@class User;
@interface Status : NSObject

@property (nonatomic, copy) NSString *text;              // 微博内容
@property (nonatomic, strong) User *user;                // 用户对象
@property (nonatomic, strong) NSArray *picUrls;          // 微博图片
@property (nonatomic, strong) Status *retweetedStatus;   // 被转发的微博
@property (nonatomic, copy) NSString *createdAt;         // 微博创建时间
@property (nonatomic, assign) NSInteger repostsCount;	 // 转发数
@property (nonatomic, assign) NSInteger commentsCount;	 // 评论数
@property (nonatomic, assign) NSInteger attitudesCount;  // 表态数(被赞)
@property (nonatomic, copy) NSString *source;            // 微博来源

- (id)initWithDict:(NSDictionary *)dict;

@end
