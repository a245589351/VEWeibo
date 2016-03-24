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

@interface HomeController () {
    NSMutableArray *_statuseFrames;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置界面属性
    [self buildUI];
    
    // 2.获得用户的微博数据
    [self loadStatusData];
    
}

#pragma mark - 设置界面属性
- (void)buildUI {
    // 1.设置标题
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2.左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png" highLightedIcon:@"navigationbar_compose_highlighted.png" addTarget:self action:@selector(sendStatus)];
    
    // 3.右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png" highLightedIcon:@"navigationbar_pop_highlighted.png" addTarget:self action:@selector(sendStatus)];
}

#pragma mark - 获得用户的微博数据
- (void)loadStatusData {
    _statuseFrames = [NSMutableArray array];
    // 发送请求
    [StatusTool statusesWithSuccess:^(NSArray *statuses) {
        // 1.在拿到最新微博数据的同时计算它的frame
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [_statuseFrames addObject:f];
        }
        
        // 2.刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
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
    
    cell.statusCellFrame = _statuseFrames[indexPath.row];
    
    return cell;
}

#pragma mark - TableView delegate
#pragma mark - 返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_statuseFrames[indexPath.row] cellHeight];
}

@end
