//
//  BaseTextCellFrame.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseText;
@interface BaseTextCellFrame : NSObject

@property (nonatomic, strong) BaseText *baseText;

@property (nonatomic, readonly) CGFloat cellHeight;// cell的高度

@property (nonatomic, readonly) CGRect  iconFrame;// 头像的Frame
@property (nonatomic, readonly) CGRect  mbIconFrame;// 会员图标的Frame
@property (nonatomic, readonly) CGRect  screenNameFrame;// 昵称的Frame
@property (nonatomic, readonly) CGRect  timeFrame;// 时间的Frame
@property (nonatomic, readonly) CGRect  textFrame;// 内容的Frame

@end
