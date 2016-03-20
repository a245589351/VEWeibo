//
//  UIBarButtonItem+VE.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (VE)
- (id)initWithIcon:(NSString *)icon highLightedIcon:(NSString *)highLighted addTarget:(id)target action:(SEL)action;
+ (id)itemWithIcon:(NSString *)icon highLightedIcon:(NSString *)highLighted addTarget:(id)target action:(SEL)action;
@end
