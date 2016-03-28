//
//  StatusDock.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusDock.h"
#import "UIImage+VE.h"
#import "Status.h"

@interface StatusDock () {
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;
}

@end

@implementation StatusDock

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // 固定dock的位置
        self.autoresizingMask       = UIViewAutoresizingFlexibleTopMargin;
        self.userInteractionEnabled = YES;
        
        // 设置整个dock的背景色
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加边框
        UIImageView *border = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kColor(230, 230, 230)]];
        border.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kStatusDockHeight + 2);
        [self addSubview:border];
        
        // 1.添加三个按钮
        _repost   = [self addBtnWithTitle:@"转发" icon:@"timeline_icon_retweet" index:0];
        _comment  = [self addBtnWithTitle:@"评论" icon:@"timeline_icon_comment" index:1];
        _attitude = [self addBtnWithTitle:@"赞" icon:@"timeline_icon_unlike" index:2];
    }
    return self;
}

- (UIButton *)addBtnWithTitle:(NSString *)title icon:(NSString *)icon index:(NSInteger)index{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标题
    [btn setTitle:title forState:UIControlStateNormal];
    // 图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 背景色
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    // 高亮背景色
    [btn setBackgroundImage:[UIImage imageWithColor:kStatusDockSelectBackgroundColor] forState:UIControlStateHighlighted];
    // 设置文字颜色
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    // 设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置frame
    CGFloat w           = self.frame.size.width / 3;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.frame           = CGRectMake(index * w, 1, w, kStatusDockHeight);
    
    [self addSubview:btn];
    
    if (index) { // index不等于0添加分割线
        UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        divider.center = CGPointMake(btn.frame.origin.x, kStatusDockHeight * 0.5);
        [self addSubview:divider];
    }
    
    return btn;
}

- (void)setFrame:(CGRect)frame {
    frame.size.width  = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = kStatusDockHeight;
    [super setFrame:frame];
}

- (void)setStatus:(Status *)status {
    _status = status;
    
    // 1.设置转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    
    // 2.设置评论
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    
    // 3.设置赞
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
    status.repostsCount = 10000;
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(NSInteger)count {
    NSString *str;
    if (count >= 10000) { // 上万
        CGFloat cnt = count / 10000.0;
        str = [NSString stringWithFormat:@"%0.1f万", cnt];
        str = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // 一万以内
        str = [NSString stringWithFormat:@"%ld", count];
    } else { // 没有
        str = @"转发";
    }
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
