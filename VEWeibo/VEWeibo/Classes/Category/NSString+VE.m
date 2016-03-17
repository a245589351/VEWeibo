//
//  NSString+VE.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+VE.h"

@implementation NSString (VE)
- (NSString *)fileAppend:(NSString *)append {
    // 1.1.获取文件拓展名
    NSString *ext = [self pathExtension];
    // 1.2.删除拓展名
    NSString *imgName = [self stringByDeletingPathExtension];
    // 1.3.拼接append
    imgName = [imgName stringByAppendingString:append];
    // 1.4.拼接拓展名
    return [imgName stringByAppendingPathExtension:ext];
}
@end
