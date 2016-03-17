//
//  WBNavigationController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.取出所有的bar
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 设置导航栏文字主题
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    // 2.修改所有UIbarButtonItem的主题
//    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 修改背景图片
//    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 修改文字主题
//    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    // 3.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

@end
