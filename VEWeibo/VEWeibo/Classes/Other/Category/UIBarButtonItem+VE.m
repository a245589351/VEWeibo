//
//  UIBarButtonItem+VE.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIBarButtonItem+VE.h"

@implementation UIBarButtonItem (VE)
- (id)initWithIcon:(NSString *)icon highLightedIcon:(NSString *)highLighted addTarget:(id)target action:(SEL)action {
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置普通背景图片
    UIImage *btnImage = [UIImage imageNamed:icon];
    [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    // 设置高亮背景图片
    [btn setBackgroundImage:[UIImage imageNamed:highLighted] forState:UIControlStateHighlighted];
    
    // 设置尺寸
    btn.bounds = (CGRect){CGPointZero, btnImage.size};
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithIcon:(NSString *)icon highLightedIcon:(NSString *)highLighted addTarget:(id)target action:(SEL)action {
    return [[self alloc] initWithIcon:icon highLightedIcon:highLighted addTarget:target action:action];
}
@end
