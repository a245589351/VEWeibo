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

// 3.设置cell的边框宽度
#define kCellBorderWidth 10

// 4.cell内部子控件字体设置
#define kScreenNameFont [UIFont systemFontOfSize:17]
#define kTimeFont       [UIFont systemFontOfSize:13]
#define kSourceFont     kTimeFont
#define kTextFont       [UIFont systemFontOfSize:15]

#define kRetweetedScreenNameFont [UIFont systemFontOfSize:16]
#define kRetweetedTextFont       [UIFont systemFontOfSize:16]

// 5.获得rgb颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// 6.cell子控件的字体颜色设置
// 会员昵称颜色
#define kMBScreenNameColor kColor(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor kColor(93, 93, 93)

// 7.图片尺寸
// 头像
#define kIconSmallW   34
#define kIconSmallH   34

#define kIconDefaultW 50
#define kIconDefaultH 50

#define kIconBigW     85
#define kIconBigH     85

// 认证图标
#define kVerifyIconW  18
#define kVerifyIconH  18

// 会员皇冠图标
#define kMBIconW 14
#define kMBIconH 14
