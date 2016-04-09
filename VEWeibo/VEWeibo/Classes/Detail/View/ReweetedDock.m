//
//  ReweetedDock.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ReweetedDock.h"
#import "UIImage+VE.h"
#import "Status.h"

@interface ReweetedDock () {
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;
}

@end

@implementation ReweetedDock

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
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
    [btn setBackgroundImage:[UIImage imageWithColor:kRetweetedBackgroundColor] forState:UIControlStateNormal];
    // 高亮背景色
    [btn setBackgroundImage:[UIImage imageWithColor:kStatusDockSelectBackgroundColor] forState:UIControlStateHighlighted];
    // 设置文字颜色
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    // 设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置frame
    CGFloat w           = self.frame.size.width / 3;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.frame           = CGRectMake(index * w, 0, w, kReweetedDockHeight);
    
    [self addSubview:btn];
    
    return btn;
}

- (void)setFrame:(CGRect)frame {
    frame.size.width  = 200;
    frame.size.height = kReweetedDockHeight;
    [super setFrame:frame];
}

- (void)setStatus:(Status *)status {
    _status = status;
    
    // 1.设置转发
    [self setBtn:_repost title:@"0" count:status.repostsCount];
    
    // 2.设置评论
    [self setBtn:_comment title:@"0" count:status.commentsCount];
    
    // 3.设置赞
    [self setBtn:_attitude title:@"0" count:status.attitudesCount];
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
        str = title;
    }
    [btn setTitle:str forState:UIControlStateNormal];
}


@end
