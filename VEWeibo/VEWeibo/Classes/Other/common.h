//
//  common.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef common_h
#define common_h

// 1.判断是否为iphone5的宏
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

// 2.日志输出的宏定义
#ifdef DEBUG
// 2.1.调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 2.2.发布状态
#define MyLog(...)
#endif

#endif /* common_h */
