//
//  NewfeatureController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NewfeatureController.h"
#import "UIImage+VE.h"
#import "OauthController.h"

#define kCount 4

@interface NewfeatureController () <UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView *_scroll;
}
@end

@implementation NewfeatureController

#pragma mark 自定义view
- (void) loadView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage fullScreenImage:@"new_feature_background.png"];
    imageView.frame = [[UIScreen mainScreen] bounds];
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加UIScrollView
    [self addScrollView];
    
    // 2.添加图片
    [self addScrollImages];
    
    // 3.添加UIPageControl
    [self addPagerControl];
}

#pragma mark 添加UI控件
#pragma mark 添加滚动视图
- (void)addScrollView {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0);
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    _scroll = scroll;
}

#pragma mark 添加滚动时显示的图片
- (void)addScrollImages {
    CGSize size = _scroll.frame.size;
    for (int i = 0; i < kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d.png", i + 1];
        imageView.image = [UIImage fullScreenImage:name];
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scroll addSubview:imageView];
        
        if (i == kCount - 1) {
            // 立即体验按钮
            UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *startNormal = [UIImage imageNamed:@"new_feature_finish_button.png"];
            [start setBackgroundImage:startNormal forState:UIControlStateNormal];
            [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"] forState:UIControlStateHighlighted];
            start.center = CGPointMake(size.width * 0.5, size.height * 0.8);
            start.bounds = (CGRect){CGPointZero, startNormal.size};
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:start];
            
            // 分享按钮
            UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
            [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
            share.center = CGPointMake(start.center.x, start.center.y - 50);
            share.bounds = (CGRect){CGPointZero, shareNormal.size};
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            share.selected = YES;
            share.adjustsImageWhenHighlighted = NO;
            [imageView addSubview:share];
            imageView.userInteractionEnabled = YES;
        }
    }
}

#pragma mark 添加分页指示器
- (void)addPagerControl {
    CGSize size = self.view.frame.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(size.width * 0.5, size.height * 0.95);
    page.numberOfPages = kCount;
    page.bounds = CGRectMake(0, 0, 150, 0);
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    [self.view addSubview:page];
    _page = page;
}

#pragma mark 监听按钮点击
#pragma mark 开始
- (void)start {
    MyLog(@"开始微博");
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[OauthController alloc] init];
}

#pragma mark 分享
- (void)share:(UIButton *)btn {
    btn.selected = !btn.selected;
}

#pragma mark 代理滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    MyLog(@"销毁-----NEW");
}

@end
