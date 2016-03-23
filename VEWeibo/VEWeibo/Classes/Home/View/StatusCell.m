//
//  StatusCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "UIImageView+WebCache.h"
#import "ImageListView.h"

@interface StatusCell () {
    IconView *_icon;       // 头像
    UILabel *_screenName;  // 昵称
    UIImageView *_mbIcon;  // 会员皇冠图标
    UILabel *_time;        // 时间
    UILabel *_source;      // 来源
    UILabel *_text;        // 内容
    ImageListView *_image; // 配图
    
    UIImageView *_retweeted;        // 被添加微博的父控件
    UILabel *_retweetedScreenName;  // 被转发微博的用户昵称
    UILabel *_retweetedText;        // 被转发微博的内容
    ImageListView *_retweetedImage; // 被转发微博的配图
}

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.添加微博的自控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的自控件
        [self addReWeetedAllSubviews];
    }
    return self;
}

#pragma mark - 添加微博的自控件
- (void)addAllSubviews {
    // 1.头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName      = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    
    // 会员图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership"]];
    [self.contentView addSubview:_mbIcon];
    
    // 3.时间
    _time           = [[UILabel alloc] init];
    _time.font      = kTimeFont;
    _time.textColor = kColor(246, 165, 68);
    [self.contentView addSubview:_time];
    
    // 4.来源
    _source      = [[UILabel alloc] init];
    _source.font = kSourceFont;
    [self.contentView addSubview:_source];
    
    // 5.内容
    _text      = [[UILabel alloc] init];
    _text.font = kTextFont;
    _text.numberOfLines = 0;
    [self.contentView addSubview:_text];
    
    // 6.配图
    _image = [[ImageListView alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark - 添加被转发微博的自控件
- (void)addReWeetedAllSubviews {
    // 1.被添加微博的父控件
    _retweeted = [[UIImageView alloc] init];
    _retweeted.backgroundColor = kRetweetedBackgroundColor;
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的用户昵称
    _retweetedScreenName           = [[UILabel alloc] init];
    _retweetedScreenName.font      = kRetweetedScreenNameFont;
    _retweetedScreenName.textColor = kRetweetedScreenNameColor;
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText      = [[UILabel alloc] init];
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.numberOfLines = 0;
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[ImageListView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame {
    _statusCellFrame = statusCellFrame;
    
    Status *s = statusCellFrame.status;
    
    // 1.头像
    _icon.type  = kIconTypeSmall;
    _icon.frame = statusCellFrame.iconFrame;
    _icon.user  = s.user;
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text  = s.user.screenName;
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = statusCellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.text      = s.createdAt;
    CGFloat timeX   = statusCellFrame.screenNameFrame.origin.x;
    CGFloat timeY   = CGRectGetMaxY(statusCellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [_time.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTimeFont, NSFontAttributeName, nil]];
    _time.frame     = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    _source.text      = s.source;
    CGFloat sourceX   = CGRectGetMaxX(statusCellFrame.timeFrame) + kCellBorderWidth;
    CGFloat sourceY   = timeY;
    CGSize sourceSize = [_source.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kSourceFont, NSFontAttributeName, nil]];
    _source.frame     = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    _text.text  = s.text;
    
    // 6。配图
    if (s.picUrls.count) {
        _image.hidden    = NO;
        _image.frame     = statusCellFrame.imageFrame;
        _image.imageUrls = s.picUrls;
//#warning 配图的图片
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        _retweeted.frame  = statusCellFrame.retweetedFrame;
        
        // 8.被转发微博昵称
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text  = [NSString stringWithFormat:@"@%@", s.retweetedStatus.user.screenName];
        
        // 9.被转发微博的内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text  = s.retweetedStatus.text;
        
        // 10.被转发微博的配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden    = NO;
            _retweetedImage.frame     = statusCellFrame.retweetedImageFrame;
            _retweetedImage.imageUrls = s.retweetedStatus.picUrls;
//#warning 被转发微博的配图
        } else {
            _retweetedImage.hidden = true;
        }
    } else {
        _retweeted.hidden = YES;
    }
}

@end
