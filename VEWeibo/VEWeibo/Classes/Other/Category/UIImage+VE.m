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

#pragma mark 自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName {
    return [self resizedImage:imgName xPost:0.5 yPost:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPost:(CGFloat)xPost yPost:(CGFloat)yPost {
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPost topCapHeight:image.size.height * yPost];
}

#pragma mark - 将颜色转为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
