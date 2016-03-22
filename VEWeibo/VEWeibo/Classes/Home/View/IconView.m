//
//  IconView.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@interface IconView () {
    UIImageView *_icon;   // 用户头像
    UIImageView *_verify; // 认证图标
    
    NSString *_placeHolder; // 占位图片
}

@end

@implementation IconView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // 1.用户头像
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        // 2.右下角认证图标
        _verify = [[UIImageView alloc] init];
        [self addSubview:_verify];
    }
    return self;
}

#pragma mark - 设置模型数据
- (void)setUser:(User *)user {
    _user = user;
    
    // 1.设置用户头像图片
    [_icon sd_setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:_placeHolder] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 2.设置右下角认证图标
    NSString *verifiedIcon = nil;
    switch (user.verifiedType) {
        case kVerifiedTypeNone: // 没有认证
            _verify.hidden = YES;
            break;
        case kVerifiedTypeDaren: // 微博达人
            verifiedIcon = @"avatar_grassroot";
            break;
        case kVerifiedTypePersonal: // 个人
            verifiedIcon = @"avatar_vip";
            break;
        default: // 企业认证
            verifiedIcon = @"avatar_enterprise_vip";
            break;
    }
    
    // 3.如果有认证,显示图标
    if (verifiedIcon) {
        _verify.hidden = NO;
        [_verify setImage:[UIImage imageNamed:verifiedIcon]];
    }
}

#pragma mark - 设置头像规格
- (void)setType:(IconType)type {
    _type = type;
    
    // 1.判断类型
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: // 小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            _placeHolder = @"avatar_default";
            break;
        case kIconTypeDefault: // 中等图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            _placeHolder = @"avatar_default_small";
            break;
        case kIconTypeBig: // 大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            _placeHolder = @"avatar_default_big";
            break;
        default:
            break;
    }
    
    // 2.设置frame
    _icon.frame    = (CGRect){CGPointZero, iconSize};
    _verify.bounds = CGRectMake(0, 0, kVerifyIconW, kVerifyIconH);
    _verify.center = CGPointMake(iconSize.width, iconSize.height);
    
    // 3.返回自己的宽高
    CGFloat width  = CGRectGetMaxX(_verify.frame);
    CGFloat height = CGRectGetMaxY(_verify.frame);
    self.bounds    = CGRectMake(0, 0, width, height);
}

+ (CGSize)iconSizeWithType:(IconType)type {
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: // 小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            break;
        case kIconTypeDefault: // 中等图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
        case kIconTypeBig: // 大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
        default:
            break;
    }
    
    CGFloat width  = iconSize.width + kVerifyIconW * 0.5;
    CGFloat height = iconSize.height + kVerifyIconH * 0.5;
    return CGSizeMake(width, height);
}

- (void)setFrame:(CGRect)frame {
    frame.size = self.frame.size;
    [super setFrame:frame];
}

@end
