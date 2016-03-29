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
#import "UIBarButtonItem+VE.h"

#define kDockHeight 44

@interface MainController () <DockDelegate, UINavigationControllerDelegate>

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
    HomeController *home            = [[HomeController alloc] init];
    WBNavigationController *navHome = [[WBNavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:navHome];
    navHome.delegate = self;
    
    // 2.消息
    UIViewController *msg          = [[MessageController alloc] init];
    WBNavigationController *navMsg = [[WBNavigationController alloc] initWithRootViewController:msg];
    [self addChildViewController:navMsg];
    navMsg.delegate = self;
    
    // 3.我
    UIViewController *me          = [[MeController alloc] init];
    WBNavigationController *navMe = [[WBNavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:navMe];
    navMe.delegate = self;
    
    // 4.广场
    UIViewController *square          = [[SquareController alloc] init];
    WBNavigationController *navSquare = [[WBNavigationController alloc] initWithRootViewController:square];
    [self addChildViewController:navSquare];
    navSquare.delegate = self;
    
    // 5.更多
    MoreController *more            = [[MoreController alloc] initWithStyle:UITableViewStyleGrouped];
    WBNavigationController *navMore = [[WBNavigationController alloc] initWithRootViewController:more];
    [self addChildViewController:navMore];
    navMore.delegate = self;
}

#pragma marks - 实现代理方法
// 导航控制器即将显示新的控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果显示的不是导航控制器的根控制器，则拉长导航控制器view的高度
    // 1.获取当前导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) { // 不等于根控制器
        // 2.拉长导航控制器view的高度
        CGRect frame = navigationController.view.frame;
        frame.size.height = [[UIScreen mainScreen] bounds].size.height;
        navigationController.view.frame = frame;
        
        // 3.添加dock控制器到根控制器上
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view可以滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        // 4.添加左上角返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back.png" highLightedIcon:@"navigationbar_back_highlighted.png" addTarget:self action:@selector(back)];
    }
}

- (void)back {
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *root = navigationController.viewControllers[0];
    if (root == viewController) {
        // 1.让导航控制器的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [[UIScreen mainScreen] bounds].size.height - _dock.frame.size.height;
        navigationController.view.frame = frame;
        
        // 2.添加dock到mainController上
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
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
