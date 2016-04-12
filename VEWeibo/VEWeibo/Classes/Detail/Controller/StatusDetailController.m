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
#import "RepostCellFrame.h"
#import "CommentCellFrame.h"
#import "Comment.h"
#import "RepostCell.h"
#import "CommentCell.h"
#import "MJRefresh.h"

@interface StatusDetailController () <DetailHeaderDelegate> {
    StatusDetailCellFrame *_detailFrame;
    NSMutableArray *_repostFrames;  // 转发的frame数据
    NSMutableArray *_commentFrames; // 评论的frame数据
    
    DetailHeader *_header;
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
    
    _repostFrames  = [NSMutableArray array];
    _commentFrames = [NSMutableArray array];
    
    // 默认点击评论
    [self detailHeader:nil btnClick:kDetailHeaderBtnTypeComment];
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMore:)];
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
    } else if (_header.currentBtnType == kDetailHeaderBtnTypeRepost) { // 转发
        return _repostFrames.count;
    } else {
        return _commentFrames.count;
    }
}

#pragma mark - 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    } else if (_header.currentBtnType == kDetailHeaderBtnTypeRepost) { // 转发
        return [_repostFrames[indexPath.row] cellHeight];
    } else {
        return [_commentFrames[indexPath.row] cellHeight];
    }
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
    } else if (_header.currentBtnType == kDetailHeaderBtnTypeRepost) { // 转发cell
        static NSString *CellIdentifier = @"RepostCell";
        RepostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[RepostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _repostFrames[indexPath.row];
        
        return cell;
    } else { // 评论cell
        static NSString *CellIdentifier = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _commentFrames[indexPath.row];
        return cell;
    }
}

#pragma mark - 返回头部控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    if (_header == nil) {
        DetailHeader *header = [[DetailHeader alloc] init];
        header.delegate = self;
        _header = header;
    }
    _header.status = _status;
    return _header;
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
        [self loadNewRepost];
    } else if (index == kDetailHeaderBtnTypeComment) { // 点击评论
        [self loadNewComment];
    }
}

#pragma mark - 加载最新的转发数据
- (void)loadNewRepost {
    [StatusTool repostsWithSinceId:0 maxId:0 statusId:_status.statusId success:^(NSArray *reposts, int totalNumber) {
        // 解析最新的转发frame数据
        NSMutableArray *newRepostFrames = [NSMutableArray array];
        for (Status *s in reposts) {
            RepostCellFrame *f = [[RepostCellFrame alloc] init];
            f.baseText = s;
            [newRepostFrames addObject:f];
        }
        _status.repostsCount = totalNumber;
        
        // 添加数据
        [_commentFrames addObjectsFromArray:newRepostFrames];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark - 加载最新的评论数据
- (void)loadNewComment {
    long long firstId = _commentFrames.count ? [[_commentFrames[0] baseText] statusId] : 0;
    
    [StatusTool CommentsWithSinceId:firstId maxId:0 statusId:_status.statusId success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        // 解析最新的评论frame数据
        NSMutableArray *newCommentFrames = [NSMutableArray array];
        for (Comment *c in comments) {
            CommentCellFrame *f = [[CommentCellFrame alloc] init];
            f.baseText = c;
            [newCommentFrames addObject:f];
        }
        
        _status.commentsCount = totalNumber;
        
        // 添加数据到旧数据的前面
        [_commentFrames insertObjects:newCommentFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newCommentFrames.count)]];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark - 上拉加载更多
- (void)reloadMore:(MJRefreshBackNormalFooter *)refresh {
    if (_header.currentBtnType == kDetailHeaderBtnTypeComment) {
        long long lastId = [[[_commentFrames lastObject] baseText] statusId] - 1;
        
        [StatusTool CommentsWithSinceId:0 maxId:lastId statusId:_status.statusId success:^(NSArray *comments, int totalNumber, long long nextCursor) {
            // 解析最新的评论frame数据
            NSMutableArray *newCommentFrames = [NSMutableArray array];
            for (Comment *c in comments) {
                CommentCellFrame *f = [[CommentCellFrame alloc] init];
                f.baseText = c;
                [newCommentFrames addObject:f];
            }
            
            _status.commentsCount = totalNumber;
            
            // 添加数据到旧数据的后面
            [_commentFrames addObjectsFromArray:newCommentFrames];
            
            // 刷新表格
            [self.tableView reloadData];
            
            refresh.hidden = nextCursor == 0;
            
            [refresh endRefreshing];
        } failure:^(NSError *error) {
            [refresh endRefreshing];
        }];
    } else {
        [refresh endRefreshing];
    }
}
@end
