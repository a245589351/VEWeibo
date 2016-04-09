//
//  DetailHeader.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailHeader.h"
#import "Masonry.h"
#import "UIImage+VE.h"
#import "Status.h"

@interface DetailHeader () {
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;
    UIButton *_selectedBtn;
    
    UIImageView *_hint;
    UIImageView *_border;
}

@end

@implementation DetailHeader

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加按钮
        _repost   = [self addBtnWithTitle:@"0 转发"];
        _comment  = [self addBtnWithTitle:@"0 评论"];
        _attitude = [self addBtnWithTitle:@"0 赞"];
        
        // 添加底部边框
        _border = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kColor(200, 199, 204)]];
        [self addSubview:_border];
        
        // 添加指示器
        _hint = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor orangeColor]]];
        [self addSubview:_hint];
        
        // 设置控件位置
        [self setLayout];
        
        [self btnClick:_comment];
    }
    return self;
}

#pragma mark - 添加按钮
- (UIButton *)addBtnWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置按钮文字
    [btn setTitle:title forState:UIControlStateNormal];
    
    // 设置按钮文字颜色
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    return btn;
}

#pragma mark - 设置控件位置
- (void)setLayout {
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.2;
    
    // 转发的位置
    [_repost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.right.equalTo(self).with.offset(-(width * 4));
    }];
    
    // 评论的位置
    [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(_repost.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.right.equalTo(self).with.offset(-(width * 3));
    }];
    
    // 赞的位置
    [_attitude mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.right.equalTo(self).with.offset(0);
        make.width.equalTo(width);
    }];
    
    // 指示器的位置
    [_hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_comment.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.height.equalTo(@1);
        make.width.equalTo(_repost);
    }];
    
    // 底部边框的位置
    [_border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_repost.mas_bottom).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
    }];
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)btn {
    _selectedBtn.enabled = YES;
    btn.enabled          = NO;
    _selectedBtn         = btn;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _hint.center;
        center.x       = btn.center.x;
        _hint.center   = center;
    }];
}

- (void)setStatus:(Status *)status {
    _status = status;
    
    // 1.设置转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    
    // 2.设置评论
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    
    // 3.设置赞
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(NSInteger)count {
    NSString *str;
    if (count >= 10000) { // 上万
        CGFloat cnt = count / 10000.0;
        str = [NSString stringWithFormat:@"%0.1f万 %@", cnt, title];
        str = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else { // 一万以内
        str = [NSString stringWithFormat:@"%ld %@", count, title];
    }
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
