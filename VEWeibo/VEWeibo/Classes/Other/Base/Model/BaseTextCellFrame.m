//
//  BaseTextCellFrame.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseTextCellFrame.h"
#import "IconView.h"
#import "User.h"
#import "BaseText.h"

@implementation BaseTextCellFrame

- (void)setBaseText:(BaseText *)baseText {
    _baseText = baseText;
    
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 1.头像
    CGFloat iconX   = kCellBorderWidth;
    CGFloat iconY   = kCellBorderWidth;
    CGSize iconSize = [IconView iconSizeWithType:kIconTypeSmall];
    _iconFrame      = (CGRect){{iconX, iconY}, iconSize};
    
    // 2.昵称
    CGFloat screenNameX   = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY   = iconY;
    CGSize screenNameSize = [baseText.user.screenName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kScreenNameFont, NSFontAttributeName, nil]];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (baseText.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame    = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    // 微博评论\转发内容
    CGFloat textX   = screenNameX;
    CGFloat textY   = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGSize textSize = [baseText.text boundingRectWithSize:CGSizeMake(cellWidth - kCellBorderWidth - textX, MAXFLOAT) options:options attributes:[NSDictionary dictionaryWithObjectsAndKeys:kTextFont, NSFontAttributeName, nil] context:nil].size;
    _textFrame      = (CGRect){{textX, textY}, textSize};
    
    // 时间
    CGFloat timeX   = textX;
    CGFloat timeY   = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
    CGSize timeSize = CGSizeMake(textSize.width, kTimeFont.lineHeight);
    _timeFrame      = (CGRect){{timeX, timeY}, timeSize};
    
    // cell高度
    _cellHeight = CGRectGetMaxY(_timeFrame) + kCellBorderWidth;
}

@end
