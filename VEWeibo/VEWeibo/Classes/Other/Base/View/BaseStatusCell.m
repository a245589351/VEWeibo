//
//  BaseStatusCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseStatusCell.h"
#import "IconView.h"
#import "ImageListView.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"

@interface BaseStatusCell () {
    IconView *_icon;       // 头像
    UILabel *_screenName;  // 昵称
    UIImageView *_mbIcon;  // 会员皇冠图标
    UILabel *_time;        // 时间
    UILabel *_source;      // 来源
    UILabel *_text;        // 内容
    ImageListView *_image; // 配图
    
    UILabel *_retweetedScreenName;  // 被转发微博的用户昵称
    UILabel *_retweetedText;        // 被转发微博的内容
    ImageListView *_retweetedImage; // 被转发微博的配图
}

@end

@implementation BaseStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.添加微博的子控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReWeetedAllSubviews];
        
        // 3.设置背景
        [self setBg];
    }
    return self;
}

#pragma mark - 添加微博的子控件
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

#pragma mark - 添加被转发微博的子控件
- (void)addReWeetedAllSubviews {
    // 1.被添加微博的父控件
    _retweeted = [[UIImageView alloc] init];
    _retweeted.backgroundColor = kRetweetedBackgroundColor;
    _retweeted.userInteractionEnabled = YES;
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

#pragma mark - 设置背景
- (void)setBg {
    UIImageView *bg = [[UIImageView alloc] init];
    bg.backgroundColor = kStatusCellSelectBackgroundColor;
    self.selectedBackgroundView = bg;
}

#pragma mark - 设置cellFrame
- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    Status *s = cellFrame.status;
    
    // 1.头像
    _icon.type  = kIconTypeSmall;
    _icon.frame = cellFrame.iconFrame;
    _icon.user  = s.user;
    
    // 2.昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text  = s.user.screenName;
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.text      = s.createdAt;
    CGFloat timeX   = cellFrame.screenNameFrame.origin.x;
    CGFloat timeY   = CGRectGetMaxY(cellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [_time.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTimeFont, NSFontAttributeName, nil]];
    _time.frame     = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    _source.text      = s.source;
    CGFloat sourceX   = CGRectGetMaxX(cellFrame.timeFrame) + kCellBorderWidth;
    CGFloat sourceY   = timeY;
    CGSize sourceSize = [_source.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kSourceFont, NSFontAttributeName, nil]];
    _source.frame     = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    _text.frame = cellFrame.textFrame;
    _text.text  = s.text;
    
    // 6。配图
    if (s.picUrls.count) {
        _image.hidden    = NO;
        _image.frame     = cellFrame.imageFrame;
        _image.imageUrls = s.picUrls;
        //#warning 配图的图片
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        _retweeted.frame  = cellFrame.retweetedFrame;
        
        // 8.被转发微博昵称
        _retweetedScreenName.frame = cellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text  = [NSString stringWithFormat:@"@%@", s.retweetedStatus.user.screenName];
        
        // 9.被转发微博的内容
        _retweetedText.frame = cellFrame.retweetedTextFrame;
        _retweetedText.text  = s.retweetedStatus.text;
        
        // 10.被转发微博的配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden    = NO;
            _retweetedImage.frame     = cellFrame.retweetedImageFrame;
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
