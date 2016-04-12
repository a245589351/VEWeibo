//
//  Status.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//  微博

#import "BaseText.h"

@interface Status : BaseText

@property (nonatomic, strong) NSArray   *picUrls;// 微博图片
@property (nonatomic, strong) Status    *retweetedStatus;// 被转发的微博
@property (nonatomic, assign) NSInteger repostsCount;// 转发数
@property (nonatomic, assign) NSInteger commentsCount;// 评论数
@property (nonatomic, assign) NSInteger attitudesCount;// 表态数(被赞)
@property (nonatomic, copy  ) NSString  *source;// 微博来源

@end
