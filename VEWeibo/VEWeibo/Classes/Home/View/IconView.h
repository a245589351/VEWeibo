//
//  IconView.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//  头像

#import <UIKit/UIKit.h>

typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
} IconType;

@class User;
@interface IconView : UIView

@property (nonatomic, strong) User     *user;
@property (nonatomic, assign) IconType type;

+ (CGSize)iconSizeWithType:(IconType)type;

@end
