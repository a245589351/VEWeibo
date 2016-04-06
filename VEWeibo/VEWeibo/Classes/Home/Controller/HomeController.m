//
//  HomeController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+VE.h"
#import "StatusTool.h"
#import "AccountTool.h"
#import "Status.h"
#import "User.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "MJRefresh.h"
#import "StatusDetailController.h"

@interface HomeController () <UITableViewDelegate> {
    NSMutableArray *_statuseFrames;
}

@end

@implementation HomeController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置界面属性
    [self buildUI];
    
    // 2.集成刷新控件
    [self addRefreshViews];
}

#pragma mark - 集成刷新控件
- (void)addRefreshViews {
    // 1.下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh:)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 2.上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMore:)];
    
    _statuseFrames = [NSMutableArray array];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 下拉刷新
- (void)startRefresh:(MJRefreshNormalHeader *)refresh {
    // 1.第一条微博的id
    StatusCellFrame *f = _statuseFrames.count ? _statuseFrames[0] : nil;
    long long first = [f.status statusId];
    
    // 2.获取微博数据
    [StatusTool statusesWithSinceId:first maxId:0 success:^(NSArray *statuses) {
        // 2.1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        // 2.2.将新微博数据newFrames插入到旧数据前面
        [_statuseFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        // 2.3.刷新表格
        [self.tableView reloadData];
        
        // 2.4.让刷新控件停止刷新状态
        [refresh endRefreshing];
        
        // 2.5.展示最新微博的数目
        [self showStatusCount:statuses.count];
    } failure:^(NSError *error) {
        [refresh endRefreshing];
    }];
}

#pragma mark - 展示最新微博的数目
- (void)showStatusCount:(NSInteger)count {
    // 1.创建按钮
    UIButton *btn               = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled                 = NO;
    btn.backgroundColor         = kColorA(247, 103, 33, 0.7);
    CGFloat w                   = self.view.frame.size.width;
    CGFloat h                   = 35;
    UINavigationBar *bar        = self.navigationController.navigationBar;
    CGFloat navigationBarHeight = CGRectGetMaxY(bar.frame);
    btn.frame                   = CGRectMake(0, navigationBarHeight - h, w, h);
    NSString *title             = count ? [NSString stringWithFormat:@"共有%ld条新的微博", (long)count] : @"没有新的微博";
    [btn setTitle:title forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:bar];
    
    // 2.开始执行动画
    CGFloat duration = 0.5;
    [UIView animateWithDuration:duration animations:^{ // 下来
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

#pragma mark - 上拉加载更多
- (void)reloadMore:(MJRefreshBackNormalFooter *)refresh {
    // 1.最后一条微博的id
    StatusCellFrame *f = [_statuseFrames lastObject];
    long long last = [f.status statusId];
    
    // 2.获取微博数据
    [StatusTool statusesWithSinceId:0 maxId:last - 1 success:^(NSArray *statuses) {
        // 2.1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        // 2.2.将新微博数据newFrames插入到旧数据后面
        [_statuseFrames addObjectsFromArray:newFrames];
        
        // 2.3.刷新表格
        [self.tableView reloadData];
        
        // 2.4.让刷新控件停止刷新状态
        [refresh endRefreshing];
    } failure:^(NSError *error) {
        [refresh endRefreshing];
    }];
}

#pragma mark - 设置界面属性
- (void)buildUI {
    // 1.设置标题
    self.title = @"首页";
    self.view.backgroundColor = kGlobalBg;
    
    // 2.左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png" highLightedIcon:@"navigationbar_compose_highlighted.png" addTarget:self action:@selector(sendStatus)];
    
    // 3.右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png" highLightedIcon:@"navigationbar_pop_highlighted.png" addTarget:self action:@selector(sendStatus)];
    
    // 4.设置cell的底部不显示分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark 发送微博
- (void)sendStatus {
    
}

#pragma mark 弹出菜单
- (void)popMenu {
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _statuseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.cellFrame = _statuseFrames[indexPath.row];
    
    return cell;
}

#pragma mark - TableView delegate
#pragma mark - 返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_statuseFrames[indexPath.row] cellHeight];
}

#pragma mark - 监听cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StatusDetailController *detail = [[StatusDetailController alloc] init];
    StatusCellFrame *f = _statuseFrames[indexPath.row];
    detail.status      = f.status;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
