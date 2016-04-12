//
//  BaseTextCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseTextCell.h"
#import "IconView.h"
#import "BaseText.h"
#import "User.h"
#import "BaseTextCellFrame.h"
#import "UIImage+VE.h"

@interface BaseTextCell () {
    IconView *_icon;       // 头像
    UILabel *_screenName;  // 昵称
    UIImageView *_mbIcon;  // 会员皇冠图标
    UILabel *_time;        // 时间
    UILabel *_text;        // 内容
}

@end

@implementation BaseTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        [self addAllSubviews];
        
        // 设置选中背景色
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kColorA(231, 231, 231, 0.3)]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 添加所有子控件
- (void)addAllSubviews {
    // 1.头像
    _icon = [[IconView alloc] init];
    _icon.type = kIconTypeSmall;
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
    
    // 4.内容
    _text      = [[UILabel alloc] init];
    _text.font = kTextFont;
    _text.numberOfLines = 0;
    [self.contentView addSubview:_text];
}

- (void)setCellFrame:(BaseTextCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    BaseText *baseText = cellFrame.baseText;
    
    // 头像
    _icon.frame = cellFrame.iconFrame;
    _icon.user  = baseText.user;
    
    // 昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text  = baseText.user.screenName;
    // 判断是不是会员
    if (baseText.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    // 内容
    _text.frame = cellFrame.textFrame;
    _text.text  = baseText.text;
    
    // 时间
    _time.frame = cellFrame.timeFrame;
    _time.text  = baseText.createdAt;
}

@end
