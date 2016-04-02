//
//  common.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef common_h
#define common_h

#define MAS_SHORTHAND //use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND_GLOBALS //enable auto-boxing for default syntax

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
// 表格间距
#define kTableBorderWidth 10
// 设置每个cell之间的间距
#define kCellMargin 10
// 设置微博dock的高度
#define kStatusDockHeight 25

// 4.cell内部子控件字体设置
#define kScreenNameFont [UIFont systemFontOfSize:15]
#define kTimeFont       [UIFont systemFontOfSize:11]
#define kSourceFont     kTimeFont
#define kTextFont       [UIFont systemFontOfSize:13]

#define kRetweetedScreenNameFont [UIFont systemFontOfSize:13]
#define kRetweetedTextFont       [UIFont systemFontOfSize:13]

// 5.获得rgb颜色
#define kColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kColor(r, g, b)     kColorA((r), (g), (b), 1)

// 6.cell子控件的字体颜色设置
// 会员昵称颜色
#define kMBScreenNameColor kColor(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor kColor(93, 93, 93)
// 被转发微博昵称颜色
#define kRetweetedScreenNameColor kColor(63, 104, 161)

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

// 主页背景色
#define kGlobalBg kColor(246, 246, 246)

// 8.被转发微博的背景颜色
#define kRetweetedBackgroundColor kGlobalBg
// 微博cell被选中的颜色
#define kStatusCellSelectBackgroundColor kColor(240, 240, 240)
// 微博底部操作条的选中背景颜色
#define kStatusDockSelectBackgroundColor kStatusCellSelectBackgroundColor

// 9.去除滚动条
#define kHideScroll - (void)viewDidAppear:(BOOL)animated {}


