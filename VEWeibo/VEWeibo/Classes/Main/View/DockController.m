//
//  DockController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DockController.h"

#define kDockHeight 44

@interface DockController () <DockDelegate>

@end

@implementation DockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加dock
    [self addDock];
}

#pragma marks 初始化dock
- (void)addDock {
    // 1.添加dock
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
}

#pragma mark dock的代理方法
- (void)dock:(Dock *)dock itemSelectedFrom:(int16_t)from to:(int16_t)to {
    if (to < 0 || to >= self.childViewControllers.count) {
        return;
    }
    
    // 0.移除旧控制器view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width           = self.view.frame.size.width;
    CGFloat height          = self.view.frame.size.height - kDockHeight;
    newVc.view.frame        = CGRectMake(0, 0, width, height);
    
    // 2.添加新控制器的view到MainController上
    [self.view addSubview:newVc.view];
}

@end
