//
//  DetailHeader.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//  第一组头部控件

#import <UIKit/UIKit.h>

@class Status, DetailHeader;

typedef enum {
    kDetailHeaderBtnTypeRepost, // 转发
    kDetailHeaderBtnTypeComment // 评论
} DetailHeaderBtnType;

@protocol DetailHeaderDelegate <NSObject>
@optional
- (void) detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index;
@end

@interface DetailHeader : UIImageView

@property (nonatomic, strong) Status *status;
@property (nonatomic, weak) id<DetailHeaderDelegate> delegate;

@end
