//
//  Dock.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@implementation Dock {
    DockItem *_selectedItem;
}

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title {
    // 1.创建item
    DockItem *item = [[DockItem alloc] init];
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    // 图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    // 监听item点击事件
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    // 2.添加item
    [self addSubview:item];
    
    // 3.调整所有item的frame
//    [UIView beginAnimations:nil context:nil];
    int16_t count  = self.subviews.count;
    if (count == 1) {
        [self itemClick:item];
    }
    CGFloat height = self.frame.size.height;
    CGFloat width  = self.frame.size.width / count;
    for (int i = 0; i < count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
//    [UIView commitAnimations];
}

#pragma mark 监听item点击事件
- (void)itemClick:(DockItem *)item {
    // 1.通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    
    // 2.取消选中当前选中的item
    _selectedItem.selected = NO;
    
    // 3.选中当前选中的item
    item.selected = YES;
    
    // 4.赋值
    _selectedItem = item;
    
    _selectedIndex = _selectedItem.tag;
}

@end
