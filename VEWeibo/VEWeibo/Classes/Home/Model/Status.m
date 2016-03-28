//
//  Status.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Status.h"
#import "User.h"
#import "NSString+VE.h"

@implementation Status

- (id)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        self.statusId = [dict[@"id"] longLongValue];
        self.text     = dict[@"text"];
        self.user     = [[User alloc] initWithDict:dict[@"user"]];
        self.picUrls  = dict[@"pic_urls"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweet];
        }
        
        self.createdAt      = dict[@"created_at"];
        self.source         = dict[@"source"];
        self.repostsCount   = [dict[@"reposts_count"] intValue];
        self.commentsCount  = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

- (NSString *)createdAt {
    // 1.将新浪的时间字符串转为NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat       = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale           = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date         = [fmt dateFromString:_createdAt];
    
    // 2.获得当前时间
    NSDate *now = [NSDate date];
    
    // 3.获取当前时间与date的间隔
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    // 4.根据时间间隔返回合适的字符串
    if (delta < 60) { // 1分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.0f分钟前", delta / 60];
    } else if (delta < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.0f小时前", delta / 60 /60];
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH-mm";
        return [fmt stringFromDate:date];
    }
}

- (void)setSource:(NSString *)source {
    _source = [NSString stringWithFormat:@"来自%@", [NSString filterHTML:source]];
}

@end
