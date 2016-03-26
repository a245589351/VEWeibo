//
//  MoreController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreController.h"
#import "UIImage+VE.h"
#import "GroupCell.h"

#pragma mark 这个类只在MoreController使用
@interface LogoutBtn : UIButton

@end

@implementation LogoutBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

@interface MoreController () {
    NSArray *_data;
}

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.搭建UI界面
    [self buildUI];
    
    // 2.读取plist文件
    [self loadPlist];
    
    // 3.设置TableView属性
    [self buildTableView];
}

#pragma mark 搭建UI界面
- (void) buildUI {
    // 1.设置标题
    self.title = @"更多";
    
    // 2.设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 3.设置右边Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark 读取plist文件
- (void)loadPlist {
    // 1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    
    // 2.读取数据
    _data = [NSArray arrayWithContentsOfURL:url];
}

#pragma mark 设置TableView属性
- (void)buildTableView {
    // 1.设置背景
    self.tableView.backgroundColor = kGlobalBg;
    
    // 2.设置TableView头部高度
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 20)];
    self.tableView.sectionFooterHeight = 0;
    
    // 3.在底部加一个按钮
    LogoutBtn *logout = [LogoutBtn buttonWithType:UIButtonTypeCustom];
    
    // 设置按钮背景图片
    [logout setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    logout.bounds = CGRectMake(0, 0, 0, 44);
    self.tableView.tableFooterView = logout;
    
    // 增加底部额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    self.tableView.layoutMargins  = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.myTableView = tableView;
        
        cell.layoutMargins  = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    // 2.取出这行对应的字典数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    
    // 3.设置文字
    cell.textLabel.text = dict[@"name"];
    
    // 设置cell的类型
    if (indexPath.section == 2) {
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = indexPath.row ? @"有图模式" : @"阅读模式";
    } else {
        cell.cellType = kCellTypeArrow;
    }
    
    return cell;
}

#pragma mark 选中后取消选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 设置最后一个cell的heightForFoot
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _data.count - 1) {
        return 10;
    }
    return 0;
}

@end
