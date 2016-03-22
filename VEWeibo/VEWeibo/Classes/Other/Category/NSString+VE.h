//
//  NSString+VE.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VE)
// 追加字符串
- (NSString *)fileAppend:(NSString *)append;

// 取出html标签
+ (NSString *)filterHTML:(NSString *)html;
@end
