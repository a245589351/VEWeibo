//
//  StatusCellFrame.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "ImageListView.h"

@implementation StatusCellFrame
- (void)setStatus:(Status *)status {
    _status = status;
    
    // 利用微博数据计算所有自控件的frame
    
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
    CGSize screenNameSize = [status.user.screenName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kScreenNameFont, NSFontAttributeName, nil]];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame    = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    // 3.时间
    CGFloat timeX   = screenNameX;
    CGFloat timeY   = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [status.createdAt sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTimeFont, NSFontAttributeName, nil]];
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX   = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY   = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kSourceFont, NSFontAttributeName, nil]];
    _sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    CGFloat textX   = iconX;
    CGFloat textY   = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_iconFrame)) + kCellBorderWidth;
    CGSize textSize = [status.text boundingRectWithSize:CGSizeMake(cellWidth - kCellBorderWidth * 2, MAXFLOAT) options:options attributes:[NSDictionary dictionaryWithObjectsAndKeys:kTextFont, NSFontAttributeName, nil] context:nil].size;
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    NSInteger imageListCount = status.picUrls.count;
    if (imageListCount) { // 6.有配图
        CGFloat imageX   = textX;
        CGFloat imageY   = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize imageSize = [ImageListView imageListSizeWithCuont:imageListCount];
        _imageFrame      = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    } else if (status.retweetedStatus) { // 7.有被转发的微博
        // 被转发微博整体
        CGFloat retweetedX      = 0;
        CGFloat retweetedY      = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGFloat retweetedWidth  = cellWidth;
        CGFloat retweetedHeight = kCellBorderWidth;
        
        // 8.被转发微博的昵称
        CGFloat retweetedScreenNameX   = kCellBorderWidth;
        CGFloat retweetedScreenNameY   = kCellBorderWidth;
        CGSize retweetedScreenNameSize = [[NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kRetweetedScreenNameFont, NSFontAttributeName, nil]];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 9.被转发微博的内容
        CGFloat retweetedTextX   = retweetedScreenNameX;
        CGFloat retweetedTextY   = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderWidth;
        CGSize retweetedTextSize = [status.retweetedStatus.text boundingRectWithSize:CGSizeMake(retweetedWidth - 2 * kCellBorderWidth, MAXFLOAT) options:options attributes:[NSDictionary dictionaryWithObjectsAndKeys:kRetweetedTextFont, NSFontAttributeName, nil] context:nil].size;
        _retweetedTextFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 10.被转发微博的配图
        NSInteger retweetedImageListCount = status.retweetedStatus.picUrls.count;
        if (retweetedImageListCount) {
            CGFloat retweetedImageX   = retweetedTextX;
            CGFloat retweetedImageY   = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            CGSize retweetedImageSize = [ImageListView imageListSizeWithCuont:retweetedImageListCount];
            _retweetedImageFrame      = CGRectMake(retweetedImageX, retweetedImageY, retweetedImageSize.width, retweetedImageSize.height);
            retweetedHeight += CGRectGetMaxY(_retweetedImageFrame);
        } else {
            retweetedHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        _retweetedFrame = CGRectMake(retweetedX, retweetedY, retweetedWidth, retweetedHeight);
    }
    
    // 11.整个cell的高度
    _cellHeight = kCellBorderWidth + kCellMargin;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    } else if (status.retweetedStatus) {
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
}
@end
