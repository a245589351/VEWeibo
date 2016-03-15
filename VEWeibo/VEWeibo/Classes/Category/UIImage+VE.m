//
//  UIImage+VE.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+VE.h"

@implementation UIImage (VE)
#pragma mark 加载全屏图片
+ (UIImage *)fullScreenImage:(NSString *)imgName {
    // 1.如果是iphone5，对文件名特殊处理
    if (iPhone5) {
        // 1.1.获取文件拓展名
        NSString *ext = [imgName pathExtension];
        // 1.2.删除拓展名
        imgName = [imgName stringByDeletingPathExtension];
        // 1.3.拼接-568h@2x
        imgName = [imgName stringByAppendingString:@"-568h@2x"];
        // 1.4.拼接拓展名
        imgName = [imgName stringByAppendingPathExtension:ext];
    }
    return [self imageNamed:imgName];
}
@end
