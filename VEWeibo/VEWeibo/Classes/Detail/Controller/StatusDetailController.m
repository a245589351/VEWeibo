//
//  StatusDetailController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusDetailController.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"

@interface StatusDetailController () {
    StatusDetailCellFrame *_detailFrame;
}

@end

@implementation StatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    _detailFrame = [[StatusDetailCellFrame alloc] init];
    _detailFrame.status = _status;
}

#pragma mark - 1.返回的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - 2.每组的头部有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 44;
}

#pragma mark - 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

#pragma mark - 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // 返回微博详情cell
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _detailFrame;
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

#pragma mark - 返回头部控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return [UIButton buttonWithType:UIButtonTypeContactAdd];
}

@end
