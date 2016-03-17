//
//  UIImage+VE.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+VE.h"
#import "NSString+VE.h"

@implementation UIImage (VE)
#pragma mark 加载全屏图片
+ (UIImage *)fullScreenImage:(NSString *)imgName {
    // 1.如果是iphone5，对文件名特殊处理
    if (iPhone5) {
        imgName = [imgName fileAppend:@"-568h@2x"];
    }
    return [self imageNamed:imgName];
}
@end
