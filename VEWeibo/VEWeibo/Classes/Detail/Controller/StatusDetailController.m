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
#import "DetailHeader.h"
#import "StatusTool.h"
#import "Status.h"

@interface StatusDetailController () <DetailHeaderDelegate> {
    StatusDetailCellFrame *_detailFrame;
}

@end

@implementation StatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.tableView.backgroundColor = kGlobalBg;
    
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
    return 50;
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
    DetailHeader *header = [[DetailHeader alloc] init];
    header.delegate      = self;
    header.status        = _status;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section;
}

#pragma mark - DetailHeader的代理方法
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index {
    if (index == kDetailHeaderBtnTypeRepost) { // 点击转发
        [StatusTool repostsWithSinceId:0 maxId:0 statusId:_status.statusId success:^(NSArray *reposts) {
            MyLog(@"获取转发数据%@", reposts);
        } failure:^(NSError *error) {
            nil;
        }];
    } else if (index == kDetailHeaderBtnTypeComment) { // 点击评论
        [StatusTool CommentsWithSinceId:0 maxId:0 statusId:_status.statusId success:^(NSArray *comments) {
            MyLog(@"获取评论数据%@", comments);
        } failure:^(NSError *error) {
            nil;
        }];
    }
}
@end
