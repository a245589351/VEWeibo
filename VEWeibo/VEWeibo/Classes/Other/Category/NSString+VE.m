//
//  NSString+VE.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+VE.h"

@implementation NSString (VE)
// 追加字符串
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

// 去除html标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text     = nil;
    while([scanner isAtEnd] == NO)
    {
        // 1.找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 2.找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 3.替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
