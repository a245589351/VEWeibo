//
//  BaseStatusCellFrame.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status;
@interface BaseStatusCellFrame : NSObject {
    CGFloat _cellHeight;
    CGRect  _retweetedFrame;
}

@property (nonatomic, strong  ) Status  *status;// 微博数据

@property (nonatomic, readonly) CGFloat cellHeight;// cell的高度

@property (nonatomic, readonly) CGRect  iconFrame;// 头像的Frame
@property (nonatomic, readonly) CGRect  mbIconFrame;// 会员图标的Frame
@property (nonatomic, readonly) CGRect  screenNameFrame;// 昵称的Frame
@property (nonatomic, readonly) CGRect  timeFrame;// 时间的Frame
@property (nonatomic, readonly) CGRect  sourceFrame;// 来源的Frame
@property (nonatomic, readonly) CGRect  textFrame;// 内容的Frame
@property (nonatomic, readonly) CGRect  imageFrame;// 配图的Frame

@property (nonatomic, readonly) CGRect  retweetedFrame;// 被添加微博的父控件的Frame
@property (nonatomic, readonly) CGRect  retweetedScreenNameFrame;// 被转发微博的用户昵称的Frame
@property (nonatomic, readonly) CGRect  retweetedTextFrame;// 被转发微博的内容的Frame
@property (nonatomic, readonly) CGRect  retweetedImageFrame;// 被转发微博的配图的Frame

@end
