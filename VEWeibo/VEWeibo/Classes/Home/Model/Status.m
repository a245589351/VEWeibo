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
    if (self == [super initWithDict:dict]) {
        self.picUrls  = dict[@"pic_urls"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweet];
        }
        
        self.source         = dict[@"source"];
        self.repostsCount   = [dict[@"reposts_count"] intValue];
        self.commentsCount  = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

- (void)setSource:(NSString *)source {
    _source = [NSString stringWithFormat:@"来自%@", [NSString filterHTML:source]];
}

@end
