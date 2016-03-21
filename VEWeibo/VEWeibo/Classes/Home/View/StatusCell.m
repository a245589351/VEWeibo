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
#import "UIImageView+WebCache.h"

@interface StatusCell () {
    UIImageView *_icon;   // 头像
    UILabel *_screenName; // 昵称
    UILabel *_time;       // 时间
    UILabel *_source;     // 来源
    UILabel *_text;       // 内容
    UIImageView *_image;  // 配图
    
    UIImageView *_retweeted;       // 被添加微博的父控件
    UILabel *_retweetedScreenName; // 被转发微博的用户昵称
    UILabel *_retweetedText;       // 被转发微博的内容
    UIImageView *_retweetedImage;  // 被转发微博的配图
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
    _icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    [self.contentView addSubview:_time];
    
    // 4.来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont;
    [self.contentView addSubview:_source];
    
    // 5.内容
    _text = [[UILabel alloc] init];
    _text.font = kTextFont;
    _text.numberOfLines = 0;
    [self.contentView addSubview:_text];
    
    // 6.配图
    _image = [[UIImageView alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark - 添加被转发微博的自控件
- (void)addReWeetedAllSubviews {
    // 1.被添加微博的父控件
    _retweeted = [[UIImageView alloc] init];
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的用户昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.numberOfLines = 0;
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[UIImageView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame {
    _statusCellFrame = statusCellFrame;
    
    Status *s = statusCellFrame.status;
    
    // 1.头像
    _icon.frame = statusCellFrame.iconFrame;
    [_icon sd_setImageWithURL:[NSURL URLWithString:s.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text  = s.user.screenName;
    
    // 3.时间
    _time.frame = statusCellFrame.timeFrame;
    _time.text  = s.createdAt;
    
    // 4.来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text  = s.source;
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    _text.text  = s.text;
    
    // 6。配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame  = statusCellFrame.imageFrame;
        NSURL *imageUrl = [NSURL URLWithString:s.picUrls[0][@"thumbnail_pic"]];
        [_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
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
        _retweetedScreenName.text  = s.retweetedStatus.user.screenName;
        
        // 9.被转发微博的内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text  = s.retweetedStatus.text;
        
        // 10.被转发微博的配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame  = statusCellFrame.retweetedImageFrame;
            NSURL *retweetedImageUrl = [NSURL URLWithString:s.retweetedStatus.picUrls[0][@"thumbnail_pic"]];
            [_retweetedImage sd_setImageWithURL:retweetedImageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
//#warning 被转发微博的配图
        } else {
            _retweetedImage.hidden = true;
        }
    } else {
        _retweeted.hidden = YES;
    }
}

@end
