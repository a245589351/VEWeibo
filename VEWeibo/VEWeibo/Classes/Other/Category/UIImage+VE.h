//
//  UIImage+VE.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VE)
#pragma mark 加载全屏图片
+ (UIImage *)fullScreenImage:(NSString *)imgName;

#pragma mark 自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPost:(CGFloat)xPost yPost:(CGFloat)yPost;
@end
