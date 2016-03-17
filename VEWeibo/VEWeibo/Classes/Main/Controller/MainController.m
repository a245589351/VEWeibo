//
//  MainController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "MessageController.h"
#import "MeController.h"
#import "SquareController.h"
#import "MoreController.h"
#import "WBNavigationController.h"

#define kDockHeight 44

@interface MainController () <DockDelegate>

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化所有子控制器
    [self addAllChildController];
    
    // 2.初始化dock
    [self addDockItems];
}

#pragma marks 初始化所有子控制器
- (void)addAllChildController {
    // 1.首页
    HomeController *home = [[HomeController alloc] init];
    WBNavigationController *navHome = [[WBNavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:navHome];
    
    // 2.消息
    UIViewController *msg = [[MessageController alloc] init];
    WBNavigationController *navMsg = [[WBNavigationController alloc] initWithRootViewController:msg];
    [self addChildViewController:navMsg];
    
    // 3.我
    UIViewController *me = [[MeController alloc] init];
    WBNavigationController *navMe = [[WBNavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:navMe];
    
    // 4.广场
    UIViewController *square = [[SquareController alloc] init];
    WBNavigationController *navSquare = [[WBNavigationController alloc] initWithRootViewController:square];
    [self addChildViewController:navSquare];
    
    // 5.更多
    MoreController *more = [[MoreController alloc] init];
    WBNavigationController *navMore = [[WBNavigationController alloc] initWithRootViewController:more];
    [self addChildViewController:navMore];
}

#pragma marks 初始化dock
- (void)addDockItems {
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    // 2.往Dock里填充内容
    [_dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    [_dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    [_dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    [_dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more.png_selected" title:@"更多"];
}

@end
